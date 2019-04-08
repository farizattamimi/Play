package classes;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

public class Event {
	private int eventID;
	private String name;
	private User creator;
	private float latitude;
	private float longitude;
	private Date createdAt;
	private int upvotes;
	private String description;
	private Timestamp expirationDate;
	private String website;
	private ArrayList<Comment> comments;
	
	
	public Event(
			int eventID,
			String name,
			int creatorID,
			String username,
			String latitude,
			String longitude,
			Timestamp createdAt,
			int upvotes,
			String description,
			Timestamp expirationDate,
			String website) {
		this.eventID = eventID;
		this.name = name;
		this.creator = new User(creatorID, username); // join in username
		this.latitude = Float.parseFloat(latitude);
		this.longitude = Float.parseFloat(longitude);
		this.createdAt = createdAt; // make sure to ask for a timestamp
		this.upvotes = upvotes;
		this.description = description;
		this.expirationDate = expirationDate;
		this.website = website;
		this.comments = DatabaseConnector.getComments(eventID);
	}

	public int getEventID() {
		return eventID;
	}

	public String getName() {
		return name;
	}

	public float getLatitude() {
		return latitude;
	}

	public float getLongitude() {
		return longitude;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public int getUpvotes() {
		return upvotes;
	}

	public String getDescription() {
		return description;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public String getWebsite() {
		return website;
	}

	public User getCreator() {
		return creator;
	}

	public ArrayList<Comment> getComments() {
		return comments;
	}
}
