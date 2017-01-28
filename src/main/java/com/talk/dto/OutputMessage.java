package com.talk.dto;

import java.util.Date;

public class OutputMessage extends Message {
	
	private Date time;
	
	private String username; 
	
	public OutputMessage(Message original, Date time, String username) {
		super(original.getId(), original.getMessage());
		this.time = time;
		this.username = username;
	}
	
	public Date getTime() {
		return time;
	}
	
	public void setTime(Date time) {
		this.time = time;
	}
	
	public String getUserName() {
		return username;
	}
	
	public void setUserName(String username){
		
		this.username = username;
	}
	
	
}
