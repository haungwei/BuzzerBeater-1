package eeit.teamcomposition.model;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@SuppressWarnings("unchecked")
@Transactional(readOnly = true)
public class TeamCompositionDAO_HibernateTemplate implements TeamCompositionDAO_interface {
	private HibernateTemplate hibernateTemplate;

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	private static final String GET_ALL_STMT = "FROM TeamCompositionVO ORDER BY leaveTeamDate DESC";
	private static final String FIND_BY_TEAMID = "FROM TeamCompositionVO WHERE teamID=?";
	private static final String FIND_BY_PLAYERID = "FROM TeamCompositionVO WHERE playerID=?";
	private static final String FIND_BY_CID = "FROM TeamCompositionVO WHERE playerID=? AND teamID=?";

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insert(TeamCompositionVO teamCompositionVO) {
		hibernateTemplate.save(teamCompositionVO);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(TeamCompositionVO teamCompositionVO) {
		hibernateTemplate.update(teamCompositionVO);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void deleteByTeamID(Integer teamID) {
		List<TeamCompositionVO> list = (List<TeamCompositionVO>) hibernateTemplate.find(FIND_BY_TEAMID, teamID);
		hibernateTemplate.deleteAll(list);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void deleteByPlayerID(Integer playerID) {
		List<TeamCompositionVO> list = (List<TeamCompositionVO>) hibernateTemplate.find(FIND_BY_PLAYERID, playerID);
		hibernateTemplate.delete(list);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void deleteByCID(Integer teamID, Integer playerID) {
		List<TeamCompositionVO> list = (List<TeamCompositionVO>) hibernateTemplate.find(FIND_BY_CID, playerID, teamID);
		hibernateTemplate.delete(list);
	}

	@Override
	public Set<TeamCompositionVO> getAll() {
		List<TeamCompositionVO> list = (List<TeamCompositionVO>) hibernateTemplate.find(GET_ALL_STMT);
		return new LinkedHashSet<TeamCompositionVO>(list);
	}

	@Override
	public List<TeamCompositionVO> findByTeamID(Integer teamID) {
		return (List<TeamCompositionVO>) hibernateTemplate.find(FIND_BY_TEAMID, teamID);
	}

	@Override
	public List<TeamCompositionVO> findByPlayerID(Integer playerID) {
		return (List<TeamCompositionVO>) hibernateTemplate.find(FIND_BY_PLAYERID, playerID);
	}

	public static void main(String[] args) {
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("modelConfig1_DataSource.xml");
		TeamCompositionDAO_interface dao = (TeamCompositionDAO_interface) context.getBean("TeamCompositionDAO");

		// Set<TeamCompositionVO> set = dao.getAll();
		// for(TeamCompositionVO vo : set ){
		// System.out.print(vo.getPlayerRole()+", ");
		// System.out.print(vo.getPlayerNo()+", ");
		// System.out.println();
		// }

		 List<TeamCompositionVO> list = dao.findByTeamID(3008);
		 for(TeamCompositionVO vo : list){
		 System.out.println(vo.getPlayersVO().getPlayerName());
		 }

//		dao.deleteByTeamID(3001);
	}

}
