package com.talk.dao;

import java.util.List;

import com.talk.model.Blog;
import com.talk.model.Job;

public interface JobDAO {

	public void addJob(Job job);
	public Job getJobById(int id);
		
	public List<Job> listJobs();
}
