package com.talk.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.talk.dao.JobDAO;
import com.talk.dao.JobUserDAO;
import com.talk.dao.UserDAO;
import com.talk.model.Blog;
import com.talk.model.Job;
import com.talk.model.JobUser;
import com.talk.model.User;

@RestController
public class RESTJobController {
	
	@Autowired
	JobDAO jobdao;
	
	@Autowired
	UserDAO userdao;
	@Autowired
	JobUserDAO jobuserdao;
	
	@PostMapping("admin/postjob")
	public ResponseEntity<String> postBlog(@RequestBody JSONObject data, Principal p) {
		System.out.println(data);

		Date date = new Date();
		System.out.println(date);

		Job job = new Job();

		job.setTitle(data.get("JobTitle").toString());
		job.setDescription(data.get("JobDesc").toString());
		job.setQualification(data.get("JobQual").toString());
		job.setPostdate(date);

		jobdao.addJob(job);

		JSONObject json = new JSONObject();

		json.put("status", "Job is Posted");
		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}
	
	@GetMapping("/viewjobs")
	public ResponseEntity<List<Job>> blogs() {

		List<Job> list = jobdao.listJobs();

		return new ResponseEntity<List<Job>>(list, HttpStatus.OK);

	}
	
	@GetMapping("/applyjob/{jobId}")
	public ResponseEntity<String> applyjob(@PathVariable("jobId") long jobId, Principal p){
		
		System.out.println("Job ID:"+jobId);
		User user = userdao.getUserByEmail(p.getName());

		long userId = user.getUserId();
		System.out.println("User ID:"+userId);
		
		JSONObject json = new JSONObject();

		json.put("status", "Job is Applied");
		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}
	
	@GetMapping("/viewjobapplied")
	public ResponseEntity<List<JobUser>> viewJobsApplied() {

		List<JobUser> list = jobuserdao.getall();

		return new ResponseEntity<List<JobUser>>(list, HttpStatus.OK);

	}

}
