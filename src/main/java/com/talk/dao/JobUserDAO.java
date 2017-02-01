package com.talk.dao;

import java.util.List;

import com.talk.model.JobUser;

public interface JobUserDAO {
	
	public List<JobUser> getall();
	public void addJobApplied(JobUser jobUser);

}
