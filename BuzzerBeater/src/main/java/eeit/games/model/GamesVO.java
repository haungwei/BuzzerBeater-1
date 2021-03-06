package eeit.games.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Set;

import eeit.gamemedia.model.GameMediaVO;
import eeit.groups.model.GroupsVO;
import eeit.locationinfo.model.LocationinfoVO;
import eeit.personaldata.model.PersonalDataVO;
import eeit.teams.model.TeamsVO;

public class GamesVO implements Serializable {

	private static final long serialVersionUID = 380702720062527758L;

	private Integer gameID;// ID

	private GroupsVO groupsVO; // replace groupID

	private LocationinfoVO locationinfoVO;// replace loactionID

	private TeamsVO teamAVO;// replace teamAID
	private TeamsVO teamBVO;// replace teamBID

	private Set<GameMediaVO> gameMediaSet = new LinkedHashSet<GameMediaVO>();
	private Set<PersonalDataVO> personalDataSet = new LinkedHashSet<PersonalDataVO>();
	private Set<TeamsVO> teamsSet = new LinkedHashSet<TeamsVO>();

	private Integer teamAScore;
	private Integer teamBScore;
	private Integer winnerID;
	private Timestamp gameBeginDate;
	private Timestamp gameEndDate;

	public Integer getGameID() {
		return gameID;
	}

	public void setGameID(Integer gameID) {
		this.gameID = gameID;
	}

	public GroupsVO getGroupsVO() {
		return groupsVO;
	}

	public void setGroupsVO(GroupsVO groupsVO) {
		this.groupsVO = groupsVO;
	}

	public LocationinfoVO getLocationinfoVO() {
		return locationinfoVO;
	}

	public void setLocationinfoVO(LocationinfoVO locationinfoVO) {
		this.locationinfoVO = locationinfoVO;
	}

	public TeamsVO getTeamAVO() {
		return teamAVO;
	}

	public void setTeamAVO(TeamsVO teamAVO) {
		this.teamAVO = teamAVO;
	}

	public TeamsVO getTeamBVO() {
		return teamBVO;
	}

	public void setTeamBVO(TeamsVO teamBVO) {
		this.teamBVO = teamBVO;
	}

	public Set<GameMediaVO> getGameMediaSet() {
		return gameMediaSet;
	}

	public void setGameMediaSet(Set<GameMediaVO> gameMediaSet) {
		this.gameMediaSet = gameMediaSet;
	}

	public Set<PersonalDataVO> getPersonalDataSet() {
		return personalDataSet;
	}

	public void setPersonalDataSet(Set<PersonalDataVO> personalDataSet) {
		this.personalDataSet = personalDataSet;
	}

	public Set<TeamsVO> getTeamsSet() {
		return teamsSet;
	}

	public void setTeamsSet(Set<TeamsVO> teamsSet) {
		this.teamsSet = teamsSet;
	}

	public Integer getTeamAScore() {
		return teamAScore;
	}

	public void setTeamAScore(Integer teamAScore) {
		this.teamAScore = teamAScore;
	}

	public Integer getTeamBScore() {
		return teamBScore;
	}

	public void setTeamBScore(Integer teamBScore) {
		this.teamBScore = teamBScore;
	}

	public Integer getWinnerID() {
		return winnerID;
	}

	public void setWinnerID(Integer winnerID) {
		this.winnerID = winnerID;
	}

	public Timestamp getGameBeginDate() {
		return gameBeginDate;
	}

	public void setGameBeginDate(Timestamp gameBeginDate) {
		this.gameBeginDate = gameBeginDate;
	}

	public Timestamp getGameEndDate() {
		return gameEndDate;
	}

	public void setGameEndDate(Timestamp gameEndDate) {
		this.gameEndDate = gameEndDate;
	}

}
