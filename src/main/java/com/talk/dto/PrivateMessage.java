package com.talk.dto;

import java.util.Date;

public class PrivateMessage extends Message {
	
	private Date time;
	
	private long userId;
	private long friendId;
	 
	
	public PrivateMessage(Message original, Date time, long userId, long friendId) {
		super(original.getId(), original.getMessage());
		this.time = time;
		this.friendId = friendId;
		this.userId = userId;
	}
	
	public Date getTime() {
		return time;
	}
	
	public void setTime(Date time) {
		this.time = time;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getFriendId() {
		return friendId;
	}

	public void setFriendId(long friendId) {
		this.friendId = friendId;
	}
	
	
		
	
}
