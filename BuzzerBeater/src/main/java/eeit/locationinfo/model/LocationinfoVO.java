package eeit.locationinfo.model;

import java.io.Serializable;
import java.sql.Blob;
import java.util.LinkedHashSet;
import java.util.Set;

import eeit.games.model.GamesVO;

public class LocationinfoVO implements Serializable {
<<<<<<< HEAD
	private static final long serialVersionUID = -461347740362010759L;

	private Integer locationID;// PK

	private Set<GamesVO> gamesSet = new LinkedHashSet<GamesVO>();

	private String locationName;
	private String locationAddr;
	private Blob locationPhoto;

	public Integer getLocationID() {
		return locationID;
	}

	public void setLocationID(Integer locationID) {
		this.locationID = locationID;
	}

	public Set<GamesVO> getGamesSet() {
		return gamesSet;
	}

	public void setGamesSet(Set<GamesVO> gamesSet) {
		this.gamesSet = gamesSet;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getLocationAddr() {
		return locationAddr;
	}

	public void setLocationAddr(String locationAddr) {
		this.locationAddr = locationAddr;
	}

	public Blob getLocationPhoto() {
		return locationPhoto;
	}

	public void setLocationPhoto(Blob locationPhoto) {
		this.locationPhoto = locationPhoto;
	}
=======
	private static final long serialVersionUID = -4613477403462010759L;

	private Integer locationID;// PK

	private Set<GamesVO> gamesSet = new LinkedHashSet<GamesVO>();

	private String locationName;
	private String locationAddr;

	public Integer getLocationID() {
		return locationID;
	}

	public void setLocationID(Integer locationID) {
		this.locationID = locationID;
	}

	public Set<GamesVO> getGamesSet() {
		return gamesSet;
	}

	public void setGamesSet(Set<GamesVO> gamesSet) {
		this.gamesSet = gamesSet;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getLocationAddr() {
		return locationAddr;
	}

	public void setLocationAddr(String locationAddr) {
		this.locationAddr = locationAddr;
	}

>>>>>>> branch 'master' of https://github.com/EEIT9701/BuzzerBeater.git

}
