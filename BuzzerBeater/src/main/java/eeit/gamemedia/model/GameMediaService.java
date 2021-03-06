package eeit.gamemedia.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import eeit.games.model.GamesService;
import eeit.games.model.GamesVO;


public class GameMediaService {
	private static final String String = null;
	private GameMediaDAO_Interface dao;
	
	public GameMediaService(){
//		dao = new GameMediaDAO_JNDI();
    	ApplicationContext context = new ClassPathXmlApplicationContext("modelConfig2_JNDI.xml");
    	dao = (GameMediaDAO_Interface) context.getBean("GameMediaDAO");
	}
	public GameMediaVO insertGameMedia(Integer gameID,String mediasName,String gameVideo,String gamePhoto,String mediaType,Timestamp mediaDate,String descriptions,String tag ){
		
		GameMediaVO gameMediaVO = new GameMediaVO();
		GamesService gs = new GamesService();
		GamesVO gamesVO = gs.findByGameID(gameID);
				
		gameMediaVO.setGamesVO(gamesVO);
		gameMediaVO.setMediasName(mediasName);
		gameMediaVO.setGameVideo(gameVideo);
		gameMediaVO.setGamePhoto(gamePhoto);
		gameMediaVO.setMediaType(mediaType);
		gameMediaVO.setMediaDate(mediaDate);
		gameMediaVO.setDescriptions(descriptions);
		gameMediaVO.setTag(tag);
		
		dao.insert(gameMediaVO);
		return gameMediaVO;
	}
	
	public GameMediaVO updateGameMedia(Integer gameID,Integer mediaID,String mediasName,String gameVideo,String gamePhoto,String mediaType,Timestamp mediaDate,String descriptions,String tag){
		GameMediaVO gameMediaVO = new GameMediaVO();
		GamesService gs = new GamesService();
		GamesVO gamesVO = gs.findByGameID(gameID);
		
		gameMediaVO.setGamesVO(gamesVO);
		gameMediaVO.setMediasName(mediasName);
		gameMediaVO.setGameVideo(gameVideo);
		gameMediaVO.setGamePhoto(gamePhoto);
		gameMediaVO.setMediaType(mediaType);
		gameMediaVO.setMediaDate(mediaDate);
		gameMediaVO.setDescriptions(descriptions);
		gameMediaVO.setTag(tag);
		gameMediaVO.setMediaID(mediaID);
		
		dao.update(gameMediaVO);
		return gameMediaVO;	
	}
	
	public void deleteGameMedia(Integer mediaID){
		dao.delete(mediaID);
	}
	public GameMediaVO getOneGameMedia(Integer mediaID) {
		return dao.findByPrimaryKey(mediaID);
	}

	public List<GameMediaVO> getAll() {
		return dao.getAll();
	}
	
	public List<GameMediaVO> getAllVideo() {
		return dao.getAllVideo();
	}
	
	public List<GameMediaVO> tagFunction(String tag){
		return dao.tagFunction(tag);
	}
	
	public List<HashMap<String,Object>> getAllInJsonForm(){
		
		List<GameMediaVO> list = dao.getAll();
		List<HashMap<String,Object>> returnlist = new ArrayList<HashMap<String, Object>>();
		Map<String,Object> map = null;
		
		for(GameMediaVO gameMediaVO:list){
			
			String[] tag = gameMediaVO.getTag().split(",");
			
			map = new HashMap<String,Object>();
			map.put("groupName", gameMediaVO.getGamesVO().getGroupsVO().getGroupName());
			map.put("teamA", gameMediaVO.getGamesVO().getTeamAVO().getTeamName());
			map.put("teamB", gameMediaVO.getGamesVO().getTeamBVO().getTeamName());
			map.put("gameID",gameMediaVO.getGamesVO().getGameID().toString());
			map.put("mediaID",gameMediaVO.getMediaID().toString());
			map.put("mediasName",gameMediaVO.getMediasName());
			map.put("gameVideo",gameMediaVO.getGameVideo());
			map.put("gamePhoto",gameMediaVO.getGamePhoto());
			map.put("mediaType",gameMediaVO.getMediaType());
			map.put("mediaDate",gameMediaVO.getMediaDate().toString());
			map.put("descriptions",gameMediaVO.getDescriptions());
			map.put("tag", tag);
			
			returnlist.add((HashMap<String, Object>) map);
		}
		
		
		return returnlist;
		
	}
	
	public HashMap<String,Object> getOneInJsonForm(Integer mediaID){
		
		GameMediaVO map1 = dao.findByPrimaryKey(mediaID);
		HashMap<String,Object> map = new HashMap<String, Object>();
		String[] tag = map1.getTag().split(",");
		
		
			map.put("groupName", map1.getGamesVO().getGroupsVO().getGroupName());
			map.put("teamA", map1.getGamesVO().getTeamAVO().getTeamName());
			map.put("teamB", map1.getGamesVO().getTeamBVO().getTeamName());
			map.put("gameID",map1.getGamesVO().getGameID().toString());
			map.put("mediaID",map1.getMediaID().toString());
			map.put("mediasName",map1.getMediasName());
			map.put("gameVideo",map1.getGameVideo());
			map.put("gamePhoto",map1.getGamePhoto());
			map.put("mediaType",map1.getMediaType());
			map.put("mediaDate",map1.getMediaDate().toString());
			map.put("descriptions",map1.getDescriptions());
			map.put("tag", tag);
		
		return map;		
	}
	
}
