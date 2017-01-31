package com.talk.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class JobUser {
	
	@Id @GeneratedValue(strategy=GenerationType.SEQUENCE)
	private long JobUserId;
	
	@ManyToOne
	@JoinColumn(name="userId")
	private User userId;
	
	@ManyToOne
	@JoinColumn(name="jobId")
	private Job jobId;

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	public Job getJobId() {
		return jobId;
	}

	public void setJobId(Job jobId) {
		this.jobId = jobId;
	}

	//
	
}
