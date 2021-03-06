package allPay.payment.integration.verification;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import allPay.payment.integration.allPayOperator.PaymentVerifyBase;
import allPay.payment.integration.domain.InvoiceObj;
import allPay.payment.integration.errorMsg.ErrorMessage;
import allPay.payment.integration.exception.AllPayException;

public class VerifyAioCheckOut extends PaymentVerifyBase {

	public VerifyAioCheckOut(){
		super();
	}
	
	public String getAPIUrl(String mode){
		Element ele = (Element)doc.getElementsByTagName("AioCheckOut").item(0);
		String url = "";
		NodeList nodeList = ele.getElementsByTagName("url");
		for(int i = 0; i < nodeList.getLength(); i++){
			ele = (Element)nodeList.item(i);
			if(ele.getAttribute("type").equalsIgnoreCase(mode)){
				url = ele.getTextContent();
				break;
			}
		}
		if(url == ""){
			throw new AllPayException(ErrorMessage.OperatingMode_ERROR);
		}
		return url;
	}
	
	public void verifyParams(Object obj){
		Class<?> cls = obj.getClass();
		Method method;
		String objValue;
		List<String> fieldNames = new ArrayList<String>();
		for(Field field : cls.getDeclaredFields()){
			fieldNames.add(field.getName());
		}
		Element ele = (Element)doc.getElementsByTagName("AioCheckOut").item(0);
		NodeList nodeList = ele.getElementsByTagName("param");
		for(int i = 0; i < nodeList.getLength(); i++){
			Element tmpEle = (Element)nodeList.item(i);
			if(fieldNames.contains(tmpEle.getAttribute("name"))){
				try {
					method = cls.getMethod("get"+tmpEle.getAttribute("name").substring(0, 1).toUpperCase()+tmpEle.getAttribute("name").substring(1), null);
					objValue = method.invoke(obj, null).toString();
				} catch (Exception e) {
					throw new AllPayException(ErrorMessage.OBJ_MISSING_FIELD);
				}
				if(!(obj instanceof InvoiceObj))
					requireCheck(tmpEle.getAttribute("name"), objValue, tmpEle.getAttribute("require").toString());
				valueCheck(tmpEle.getAttribute("type"), objValue, tmpEle);
			} else{
				continue;
			}
		}
	}
	
	public void verifyInvoice(InvoiceObj obj){
		// 1. ���S�����Ȭ̻ۨݨD
		// a. [CarruerType]�� 1 => CustomerID ���ର��
		if(obj.getCarruerType().equals("1")){ 
			if(obj.getCustomerID().isEmpty())
				throw new AllPayException("CustomerID cannot be empty when CarruerType is 1.");
		} else if(!obj.getCustomerID().isEmpty()){ // [CustomerID]������ => CarruerType ���ର��
			if(obj.getCarruerType().isEmpty())
				throw new AllPayException("CarruerType cannot be empty when CustomerID is not empty.");
		}
		// b. �C�L���O[Print]��1 => CustomerName, CustomerAddr
		if(obj.getPrint().equals("1")){
			if(obj.getCustomerName().isEmpty() || obj.getCustomerAddr().isEmpty())
				throw new AllPayException("CustomerName and CustomerAddr cannot be empty when Print is 1.");
			if(!obj.getCustomerID().isEmpty())
				throw new AllPayException("Print cannot be 1 when CustomerID is not empty.");
		}
		// c. CustomerPhone�MCustomerEmail�ܤ֤@�Ӧ���
		if(obj.getCustomerPhone().isEmpty() && obj.getCustomerEmail().isEmpty())
			throw new AllPayException("CustomerPhone and CustomerEmail cannot both be empty.");
		// d. [TaxType]�� 2 => ClearanceMark = 1 or 2
		if(obj.getTaxType().equals("2"))
			if(!obj.getClearanceMark().equals("1") && !obj.getClearanceMark().equals("2"))
				throw new AllPayException("ClearanceMark has to be 1 or 2 when TaxType is 2.");
		// e. �Τ@�s��[CustomerIdentifier]���Ȯ� => CarruerType != 1 or 2, *Donation = 2, print = 1
		if(!obj.getCustomerIdentifier().isEmpty()){
			if(obj.getCarruerType().equals("1") || obj.getCarruerType().equals("2"))
				throw new AllPayException("CarruerType cannot be 1 or 2 when CustomerIdentifier is given");
			if(!obj.getDonation().equals("2") || !obj.getPrint().equals("1"))
				throw new AllPayException("Print must be 1 and Donation must be 2 when CustomerIdentifier is given.");
		}
		// f. CarruerType���Ȯ�=> Print = 0
		if(!obj.getCarruerType().isEmpty())
			if(obj.getPrint().equals("1"))
				throw new AllPayException("Print must be 0 when CarruerType is given.");
		// [CarruerType]��'' or 1 �� => CarruerNum = '', [CarruerType]�� 2�A CarruerNum = �T�w���׬� 16 �B�榡�� 2 �X�j�p�g�r���[�W 14 �X�Ʀr�C [CarruerType]�� 3 �A�a�T�w���׬� 8 �B�榡�� 1 �X�׽u�u/�v�[�W�� 7 �X�Ʀr�Τj�p�g�r���զ�
		if(obj.getCarruerType().isEmpty() || obj.getCarruerType().equals("1")){
			if(!obj.getCarruerNum().isEmpty())
				throw new AllPayException("CarruerNum must be empty when CarruerType is empty or 1.");
		} else if(obj.getCarruerType().equals("2")){
			Pattern r = Pattern.compile("[A-Za-z]{2}[0-9]{14}");
			Matcher m = r.matcher(obj.getCarruerNum()); 
			if(!m.find())
				throw new AllPayException("CarruerNum must be 2 alphabets and 14 numbers when CarruerType is 2.");
		} else if(obj.getCarruerType().equals("3")){
			Pattern r = Pattern.compile("^\\/[A-Za-z0-9\\s+-]{7}$");
			Matcher m = r.matcher(obj.getCarruerNum());
			if(!m.find())
				throw new AllPayException("CarruerNum must start with / followed by 7 alphabet and number characters when CarruerType is 3.");
		} else
			throw new AllPayException("Unexpected Value in CarruerType");
		// Donation = 1 => LoveCode���ର��, print = 0
		if(obj.getDonation().equals("1")){
			if(obj.getLoveCode().isEmpty())
				throw new AllPayException("LoveCode cannot be empty when Donation is 1.");
			if(!obj.getPrint().equals("0"))
				throw new AllPayException("Print must be 0 when Donation is 1.");
		}
		// 2. ���ӫ~�W�١A�ƶq�A���A����Atax���ؼƶq�O�_�@�P
		if(obj.getInvoiceItemName().isEmpty())
			throw new AllPayException("InvoiceItemName cannot be empty.");
		else if(obj.getInvoiceItemCount().isEmpty())
			throw new AllPayException("InvoiceItemCount cannot be empty.");
		else if(obj.getInvoiceItemWord().isEmpty())
			throw new AllPayException("InvoiceItemWord cannot be empty.");
		else if(obj.getInvoiceItemPrice().isEmpty())
			throw new AllPayException("InvoiceItemPrice cannot be empty.");
		else if(obj.getInvoiceItemTaxType().isEmpty())
			throw new AllPayException("InvoiceItemTaxType cannot be empty.");
		// �ӫ~�W�٧t���޽u => �{���O�h�˰ӫ~ *InvoiceItemName�A *InvoiceItemCount �A*InvoiceItemWord�A *InvoiceItemPrice InvoiceItemTaxType�v�@�κ޽u���ΡA�p��ƶq��P�Ĥ@�Ӥ��
		if(obj.getInvoiceItemName().contains("|")){
			int itemCount = obj.getInvoiceItemName().split("|").length;
			int paramCount = 0;
			Pattern r = Pattern.compile("(\\|\\||^\\||\\|$)");
			Matcher invCount = r.matcher(obj.getInvoiceItemCount());
			Matcher invWord = r.matcher(obj.getInvoiceItemWord());
			Matcher invPrice = r.matcher(obj.getInvoiceItemPrice());
			Matcher invType = r.matcher(obj.getInvoiceItemTaxType());
			if(invCount.find()){
				throw new AllPayException("InvoiceItemCount contains empty value.");
			} else{
				paramCount = obj.getInvoiceItemCount().split("\\|").length;
				if(itemCount != paramCount)
					throw new AllPayException("Count of item info InvoiceItemCount(" + paramCount + ") not match item count from InvoiceItemName(" + itemCount + ")");
			}
			if(invWord.find()){
				throw new AllPayException("InvoiceItemWord contains empty value.");
			} else{
				paramCount = obj.getInvoiceItemWord().split("\\|").length;
				if(itemCount != paramCount)
					throw new AllPayException("Count of item info InvoiceItemWord(" + paramCount + ") not match item count from InvoiceItemName(" + itemCount + ")");
			}
			if(invPrice.find()){
				throw new AllPayException("InvoiceItemPrice contains empty value.");
			} else{
				paramCount = obj.getInvoiceItemPrice().split("\\|").length;
				if(itemCount != paramCount)
					throw new AllPayException("Count of item info InvoiceItemPrice(" + paramCount + ") not match item count from InvoiceItemName(" + itemCount + ")");
			}
			if(invType.find()){
				throw new AllPayException("InvoiceItemTaxType contains empty value.");
			} else{
				paramCount = obj.getInvoiceItemTaxType().split("\\|").length;
				if(itemCount != paramCount)
					throw new AllPayException("Count of item info InvoiceItemTaxType(" + paramCount + ") not match item count from InvoiceItemName(" + itemCount + ")");
			}
			// �ҵ|���O[TaxType] = 9 �� => InvoiceItemTaxType ��t��1,2 3(and at least contains one 1 and other)
			String[] itemTax = obj.getInvoiceItemTaxType().split("\\|");
			for(String tax : itemTax){
				if(tax.equals("1") || tax.equals("2") || tax.equals("3"))
					continue;
				else
					throw new AllPayException("Ilegal InvoiceItemTaxType: " + tax);
			}
			if(obj.getTaxType().equals("9")){
				if(!itemTax.toString().contains("1"))
					throw new AllPayException("InvoiceItemTaxType must contain at least one 1.");
				else
					if(!itemTax.toString().contains("2") && !itemTax.toString().contains("3"))
						throw new AllPayException("InvoiceItemTaxType cannot be all 1 when TaxType is 9.");
				if(itemTax.toString().contains("2") && itemTax.toString().contains("3"))
					throw new AllPayException("InvoiceItemTaxType cannot contain 2 and 3 at the same time.");
			}
		} else{
			// �S���޽u => �v�@�ˬd��4�����L�޽u
			if(obj.getInvoiceItemCount().contains("|"))
				throw new AllPayException("Item info InvoiceItemCount contains pipeline delimiter but there's only one item in param InvoiceItemName.");
			else if(obj.getInvoiceItemWord().contains("|"))
				throw new AllPayException("Item info InvoiceItemWord contains pipeline delimiter but there's only one item in param InvoiceItemName.");
			else if(obj.getInvoiceItemPrice().contains("|"))
				throw new AllPayException("Item info InvoiceItemPrice contains pipeline delimiter but there's only one item in param InvoiceItemName.");
			else if(obj.getInvoiceItemTaxType().contains("|"))
				throw new AllPayException("Item info InvoiceItemTaxType contains pipeline delimiter but there's only one item in param InvoiceItemName.");
		}
		// 4 ���Ҧ����Pattern
		verifyParams(obj);
	}
}
