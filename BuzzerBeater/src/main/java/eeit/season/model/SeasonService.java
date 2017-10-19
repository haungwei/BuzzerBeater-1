package eeit.season.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
<<<<<<< HEAD
=======


>>>>>>> branch 'master' of https://github.com/EEIT9701/BuzzerBeater.git
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

public class SeasonService {

	private SeasonDAO_interface dao;

	public SeasonService() {
		dao = new SeasonDAO_Hibernate();
	}

	public SeasonVO addSeason(String seasonName, Date seasonBeginDate, Date seasonEndDate, Timestamp signUpBegin,
			Timestamp signUpEnd, String descriptions) {

		SeasonVO sVO = new SeasonVO();
		sVO.setSeasonName(seasonName);
		sVO.setSeasonBeginDate(seasonBeginDate);
		sVO.setSeasonEndDate(seasonEndDate);
		sVO.setSignUpBegin(signUpBegin);
		sVO.setSignUpEnd(signUpEnd);
		sVO.setDescriptions(descriptions);

		dao.insert(sVO);

		return sVO;
	}

	public SeasonVO updateSeason(String seasonName, Date seasonBeginDate, Date seasonEndDate, Timestamp signUpBegin,
			Timestamp signUpEnd, Integer seasonID, String descriptions) {

		SeasonVO sVO = new SeasonVO();
		sVO.setSeasonName(seasonName);
		sVO.setSeasonBeginDate(seasonBeginDate);
		sVO.setSeasonEndDate(seasonEndDate);
		sVO.setSignUpBegin(signUpBegin);
		sVO.setSignUpEnd(signUpEnd);
		sVO.setSeasonID(seasonID);
		sVO.setDescriptions(descriptions);

		dao.update(sVO);

		return sVO;
	}

	public Integer deleteSeason(Integer seasonID) {
		return dao.delete(seasonID);
	}

	public Set<HashMap<String, Object>> getAll() {
		// Domain Knowledge 在Service內實作

		// 取得DAO回傳的原始資料
		Set<SeasonVO> set = dao.getAll();

		Set<HashMap<String, Object>> returnSet = new LinkedHashSet<HashMap<String, Object>>();
		Map<String, Object> map = null;

		// 根據需要轉換型態並以字串回傳
		for (SeasonVO sVO : set) {
			map = new HashMap<String, Object>();
			map.put("seasonID", sVO.getSeasonID());
			map.put("seasonName", sVO.getSeasonName());
			map.put("seasonBeginDate", sVO.getSeasonBeginDate());
			map.put("seasonEndDate", sVO.getSeasonEndDate());

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			map.put("signUpBegin", (sVO.getSignUpBegin() != null) ? sdf.format(sVO.getSignUpBegin()) : " ");
			map.put("signUpEnd", (sVO.getSignUpEnd() != null) ? sdf.format(sVO.getSignUpEnd()) : " ");
			map.put("groupsSet", sVO.getGroupsSet());

			returnSet.add((HashMap<String, Object>) map);
		}

		return returnSet;
	}

	public Map<String, Object> findBySeasonID(Integer seasonID) {

		// 取得DAO回傳的原始資料
		SeasonVO sVO = dao.findBySeasonID(seasonID);

		Map<String, Object> map = new HashMap<String, Object>();

		map = new HashMap<String, Object>();
		map.put("seasonID", sVO.getSeasonID());
		map.put("seasonName", sVO.getSeasonName());
		map.put("seasonBeginDate", sVO.getSeasonBeginDate());
		map.put("seasonEndDate", sVO.getSeasonEndDate());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		map.put("signUpBegin", (sVO.getSignUpBegin() != null) ? sdf.format(sVO.getSignUpBegin()) : " ");
		map.put("signUpEnd", (sVO.getSignUpEnd() != null) ? sdf.format(sVO.getSignUpEnd()) : " ");
		map.put("groupsSet", sVO.getGroupsSet());
		
		return map;
	}
}
