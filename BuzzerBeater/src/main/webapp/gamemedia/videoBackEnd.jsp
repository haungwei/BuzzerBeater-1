<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="eeit.season.model.*"%>
<%@ page import="eeit.groups.model.*"%>
<%@ page import="eeit.gamemedia.model.*"%>
<%@ page import="java.util.*"%>
<%
	// 	SeasonService seasonSvc = new SeasonService();
	// 	Set<HashMap<String, Object>> list = seasonSvc.getAll();
	SeasonDAO_Hibernate dao = new SeasonDAO_Hibernate();
	Set<SeasonVO> list = dao.getAll();
	request.setAttribute("list", list);

	SeasonVO seasonVO = new SeasonVO();
	Set<GroupsVO> groupSet = seasonVO.getGroupsSet();
	request.setAttribute("groupSet", groupSet);

	// 	GameMediaService gameMediaSvc = new GameMediaService();
	// 	List<GameMediaVO> media = gameMediaSvc.getAll();

	// 	request.setAttribute("gameMediaSvc", media);
%>
<jsp:useBean id="gameMediaSvc" scope="page"
	class="eeit.gamemedia.model.GameMediaService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>EEIT97-第一組</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" -->
<!-- 	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css"> -->

<jsp:include page="/header_css.jsp" />
<%-- <script src="<%=request.getContextPath() %>/js/jquery-3.2.1.min.js"></script> --%>

<!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->

<style>
#myModalLabel {
	width: 200px
}

#myModalLabel1 {
	width: 200px
}

#myModalLabel2 {
	width: 200px
}

#myModalLabel3 {
	width: 200px
}

#table {
	table-layout: fixed;
}

#uploadButton {
	margin: 5px;
}

#cancelButton {
	margin: 5px
}

#tabletopic {
	margin-left: 3px
}

#thead {
	font-weight: bold;
}

#upload {
	height: 5px;
	padding: 17px;
	line-height: 1px;
}

#video {
	width: 400px;
	padding-top: 20px;
	padding-left: 0px;
	padding-right: 100px;
}

#update {
	margin: 0px;
}

#delete {
	margin: 0px;
}

#topic {
	margin-left: 0px;
	padding-left: 0px;
}

#x {
	margin-right: -20px;
}

span {
	margin-top: -20px;
}

.input-group-addon {
	width: 10%;
	height: 20px;
}

.form-control {
	width: 90%;
	height: 20px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/datatables.min.css" />

</head>
<body>
	<jsp:include page="/header.jsp" />


	<!--主文(開始)-->
	<div class="container">
		<div class="jumbotron">
			<div class="row">
				<div class="col-md-4" id="topic">
					<h1>影片專區</h1>
					</br>
					<c:if test="${not empty errorMsgs}">
					請修正以下錯誤:
                    <ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li>${message}</li>
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</div>
			<div class="row">
				<!-- 				<div class="col-md-2"> -->
				<!-- 					<div class="dropdown"> -->
				<!--     					<button type="button" class="btn btn-warning dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">賽季<span class="caret"></span> -->
				<!--     					</button> -->
				<!--     					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> -->
				<%--         					<c:forEach var="list" items="${list}"> --%>
				<%--         						<li>${list.seasonName}</li> --%>
				<%--         					</c:forEach> --%>
				<!--     					</ul> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="col-md-2"> -->
				<!-- 					<div class="dropdown"> -->
				<!--     					<button type="button" class="btn btn-danger dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">賽季<span class="caret"></span> -->
				<!--     					</button> -->
				<!--     					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> -->
				<%--         					<c:forEach var="set" items="${list}"> --%>
				<%--         						<c:forEach var="g" items="${set.groupsSet}"> --%>
				<%--         							<li>${g.groupName}</li> --%>
				<%--         						</c:forEach> --%>
				<%--         					</c:forEach> --%>
				<!--     					</ul> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="col-md-2"> -->
				<!-- 					<div class="dropdown"> -->
				<!--     					<button type="button" class="btn btn-primary dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">球隊<span class="caret"></span> -->
				<!--     					</button> -->
				<!--     					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> -->
				<%--         					<c:forEach var="list" items="${list}"> --%>
				<%--         						<li>${list.seasonName}</li> --%>
				<%--         					</c:forEach> --%>
				<!--     					</ul> -->
				<!-- 					</div> -->
				<!-- 				</div> -->

			</div>
			</br>
			<div class="row">
				<table class="table table-bordered" id="table">
					<thead>
						<tr align='center' valign='middle' id="thead">
							<td><nobr>分組</nobr></td>
							<td>賽事</td>
							<td>最後上傳/修改時間</td>
							<td>標題</td>
							<td>備註</td>
							<td>標籤</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<%--   							<c:forEach var="gameMediaSvc" items="${gameMediaSvc.all}"> --%>
						<%--   							<c:forEach var="gameMediaType" items="${gameMediaSvc.mediaType}"> --%>
						<%--   							<c:if test="${gameMediaType eq 'video'}"> --%>
						<!--   								<tr align='center' valign='middle'> -->
						<%--       								<td>${gameMediaSvc.gamesVO.groupsVO.groupName}</td> --%>
						<%--       								<td>${gameMediaSvc.gamesVO.teamAVO.teamName} </br>VS</br> ${gameMediaSvc.gamesVO.teamBVO.teamName}</td> --%>
						<%--       								<td>${gameMediaSvc.mediaDate}</td> --%>
						<%--       								<td>${gameMediaSvc.mediasName}</td> --%>
						<%--       								<td>${gameMediaSvc.descriptions}</td> --%>
						<%--       								<td>${gameMediaSvc.tag}</td> --%>
						<!--       								<td> -->
						<!--                                     </td> -->
						<!--                                     <td> -->
						<!--                                     	<button class="btn btn-warning" id="123"  data-toggle="modal" data-target="#myModal2">修改</button> -->
						<!--                                     </td> -->
						<!--                                     <td> -->
						<!--                                         <button class="btn btn-danger" id="456"  data-toggle="modal" data-target="#myModal3">刪除</button> -->
						<!--       										<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true" data-backdrop="false"> -->
						<!--     											<div class="modal-dialog"> -->
						<!--         											<div class="modal-content"> -->
						<!--             											<div class="modal-header"> -->
						<!--                 											<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="x">&times;</button> -->
						<!--                 											<h4 class="modal-title" id="myModalLabel3">刪除影片</h4> -->
						<!--             											</div> -->
						<!--             											<div class="modal-body"> -->
						<!--             												<div class="row"> -->
						<!--   																<h4>警告!!!</br> -->
						<%--   																	即將刪除影片${gameMediaSvc.mediasName}，是否確定? --%>
						<!--   																</h4> -->
						<!--             												</div> -->
						<!--             												</br> -->
						<!--             											</div> -->
						<!--             											<div class="modal-footer"> -->
						<!--             												<button type="button" class="btn btn-default" data-dismiss="modal">確定</button> -->
						<!--                 											<button type="button" class="btn btn-default" data-dismiss="modal">取消</button> -->
						<!--             											</div> -->
						<!--         											</div> -->
						<!--     											</div> -->
						<!-- 											</div>	 -->
						<!--       								</td> -->

						<!--     							</tr> -->
						<%--     							</c:if> --%>
						<%--   							</c:forEach> --%>
						<%--   							</c:forEach> --%>
					</tbody>
				</table>
			</div>

			<div class="row">
				<div class="col-md-3">
					<h3>影片上傳</h3>
				</div>
			</div>
			<div class="row">
				<button class="btn btn-warning" id="789" data-toggle="modal"
					data-target="#myModal">選擇檔案</button>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					data-backdrop="false">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true" id="x">&times;</button>
								<h4 class="modal-title" id="myModalLabel">檔案上傳</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<!--     									<label class="control-label">選擇檔案</label> -->
										<input type="file" class="file">
									</div>
								</div>
								</br>
								<div class="input-group">
									<span class="input-group-addon">標題</span> <input type="text"
										class="form-control">
								</div>
								</br>
								<div class="input-group">
									<span class="input-group-addon">備註</span> <input type="text"
										class="form-control">
								</div>
								</br>
								<div class="input-group">
									<span class="input-group-addon">標籤</span> <input type="text"
										class="form-control" placeholder="請用以,分格標籤     ex:張君雅,單手爆扣">
								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">確認上傳</button>
								<button type="button" class="btn btn-primary"
									data-dismiss="modal">取消</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<jsp:include page="/footer.jsp" />
		</div>
	</div>
	<!--主文(結束)-->

	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel1" aria-hidden="true"
		data-backdrop="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" id="x">&times;</button>
					<h4 class="modal-title" id="myModalLabel1">預覽影片</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<video controls id="xxx" src=""> <!--        								<source  type="video/mp4" >	 -->
						</video>
					</div>
					</br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" data-dismiss="modal">離開</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel2" aria-hidden="true"
		data-backdrop="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" id="x">&times;</button>
					<h4 class="modal-title" id="myModalLabel2">修改影片資訊</h4>
				</div>
				<form method="post"
					action="<%=request.getContextPath()%>/GameMedia.do" name="updateTable">
					<input type="hidden" name="action" value="Update"> <input
						type="hidden" name="" value="">
					<div class="modal-body">
						<div class="row">
							<div class="input-group">
								<span class="input-group-addon">分組</span> <input type="text"
									class="form-control" id="group" name="group" value="">
							</div>
							<div class="input-group">
								<span class="input-group-addon">比賽隊伍1</span> <input type="text"
									class="form-control" id="teamA" value="">
							</div>
							<div class="input-group">
								<span class="input-group-addon">比賽隊伍2</span> <input type="text"
									class="form-control" id="teamB" value="">
							</div>
							<div class="input-group">
								<span class="input-group-addon">標題</span> <input type="text"
									class="form-control" id="title" value="">
							</div>
							<div class="input-group">
								<span class="input-group-addon">備註</span> <input type="text"
									class="form-control" id="descriptions" value="">
							</div>
							<div class="input-group">
								<span class="input-group-addon">標籤</span> <input type="text"
									class="form-control" id="tag" value="">
							</div>
						</div>
						</br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="updateCheck">確定</button>

						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="/footer_css.jsp" />
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/datatables.min.js"></script>
	<script>
	
	$(function(){
		
 		loadTable();		
 		
 
 		
 		
 		
 		
 		
 		function loadTable(){
			$.getJSON('<%=request.getContextPath()%>/GameMedia.do', {'action':'getAll'},function(data){
				var docFrag = $(document.createDocumentFragment());
				var tb = $('#tbody');
				tb.empty();
				
				$.each(data, function(index,gMVO){
	  				if(gMVO.mediaType=='video'){
	 					console.log(data);
						var cell1 = $('<td></td>').text(gMVO.groupName).attr('id','groupID');
						var cell2 = $('<td></td>').text(gMVO.teamA+' VS '+gMVO.teamB).attr('id','teams');
						var cell3 = $('<td></td>').text(gMVO.mediaDate).attr('id','mediaDate');
						var cell4 = $('<td></td>').text(gMVO.mediasName).attr('id','mediasName');
						var cell5 = $('<td></td>').text(gMVO.descriptions).attr('id','descriptions');
						var cell6 = $('<td></td>').text(gMVO.tag).attr('id','tag');
						var id = gMVO.mediaID;
						var gameVideo = gMVO.gameVideo;
						var cell7 = $('<td><button type="button" class="btn btn-info testmodal" data-toggle="myModal1" data-target="dialog-4" value="'+gameVideo+'" >預覽</button></td>');
						var cell8 = $('<td><button type="button" class="btn btn-warning testmodal2" data-toggle="myModal2" data-target="dialog-4" id="'+id+'">修改</button></td>');
						var cell9 = $('<td><button type="button" class="btn btn-danger" data-toggle="myModal" data-target="dialog-4" >刪除</button></td>');
						var row = $('<tr align="center" valign="middle"></tr>').append([cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9])				 				
						docFrag.append(row);
						tb.append(docFrag);	
	  				}

	  				
	  				var group = null;
					var teamA = null;
					var teamB = null;
					var mediasName = null;
					var descriptions = null;
					var tag = null;
	  				
	  				$(".testmodal").on('click',function(){
	  					//事件處發顯示模態框
	  			        $('#myModal1').modal('show');
	  					//抓到上方cell7讀到的gameVideo內部的值
                        var path01 = $(this).val(); 
	  					//字串串接路徑
	  				    var videoNo1 = "<%=request.getContextPath()%>/videos/"+ path01;
 	  				    $('#xxx').attr("src", videoNo1)
	  				})
					
	  				$('.testmodal2').on('click',function(){
			 			var cell1 = $(this).parents('tr').find('td:first').text();
			 			console.log(cell1);
			 			
						$('form[name=updateTable]').find('input:nth-child(3)').val(cell1);
						$('#myModal2>#teamA').val($(this).parent('tr').find('#teamA').val());
						$('#myModal2>#teamB').val($(this).parent('tr').find('#teamB').val());
						$('#myModal2>#title').val($(this).parent('tr').find('#title').val());
						$('#myModal2>#descriptions').val($(this).parent('tr').find('#descriptions').val());
						$('#myModal2>#tag').val($(this).parent('tr').find('#tag').val());
							
						$('#myModal2').modal('show');
							
							
					})
	  				
	  				$('#updateCheck').on('click',function(){
	  					
<%-- 	  					$.postJSON('<%=request.getContextPath()%>/GameMedia.do?action=Update',{'groupName':group,'teamA':teamA,'teamB':teamB,'title':title,'descriptions':descriptions,'tag':tag},function(data){ --%>
// 	  						$(this).val()
	  						
// 	  					});
	  					
	  				})
				
				})	
			});
 		}
		
		
		
 		
		
		$('#table').DataTable({
				columnDefs: [{ width: 200, targets: 6}],
				"lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
				"pagingType": "full_numbers",
				"language": {
					"lengthMenu":"每一頁顯示_MENU_ 筆資料",
					"zeroRecords":"查無資料",
					"info":"現在正在第_PAGE_ 頁，總共有_PAGES_ 頁",
					"infoEmpty":"無資料",
					"infoFiltered":"(總共搜尋了_MAX_ 筆資料)",
					"search":"搜尋：",
					"paginate":{
						"first":"第一頁",
						"previous":"上一頁",
						"next":"下一頁",
						"last":"最末頁"					
					}
			  }
		})
		

	});

	
	
		
	</script>


</body>
</html>
