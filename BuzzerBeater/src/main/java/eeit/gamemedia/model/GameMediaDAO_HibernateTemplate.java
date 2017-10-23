package eeit.gamemedia.model;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public class GameMediaDAO_HibernateTemplate implements GameMediaDAO_Interface {

	private HibernateTemplate hibernateTemplate;

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	private static final String GET_ALL_STMT = "FROM GameMediaVO ORDER BY mediaID";

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insert(GameMediaVO gameMediaVO) {
		hibernateTemplate.save(gameMediaVO);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(GameMediaVO gameMediaVO) {
		hibernateTemplate.update(gameMediaVO);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delete(Integer mediaID) {
		GameMediaVO gameMediaVO = (GameMediaVO) hibernateTemplate.get(GameMediaVO.class, mediaID);
		hibernateTemplate.delete(gameMediaVO);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public GameMediaVO findByPrimaryKey(Integer gameMediaID) {
		GameMediaVO gameMediaVO = (GameMediaVO) hibernateTemplate.get(GameMediaVO.class, gameMediaID);
		return gameMediaVO;
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public List<GameMediaVO> getAll() {
		Object obj = hibernateTemplate.find(GET_ALL_STMT);
		List<GameMediaVO> list = (List<GameMediaVO>) obj;
		return list;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("modelConfig1_DataSource.xml");
		GameMediaDAO_Interface dao = (GameMediaDAO_Interface) context.getBean("GameMediaDAO");
		
		
		List<GameMediaVO> set =dao.getAll();
		
		for(GameMediaVO vo : set){
			System.out.println(vo.getGameVideo());
		}


	}

}
