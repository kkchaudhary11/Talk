package com.talk.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.talk.dao.ForumDAO;
import com.talk.dao.UserDAO;
import com.talk.model.Forum;
import com.talk.model.User;

@RestController
public class RESTForumController {

	@Autowired
	UserDAO userdao;
	
	@Autowired
	ForumDAO forumdao;
	
	@PostMapping("/postforum")
	public ResponseEntity<String> postForum(@RequestBody JSONObject data, Principal p){
	
		System.out.println(data.get("ForumTitle").toString());
		
		User user = userdao.getUserByEmail(p.getName());
		
		Date date = new Date();
		Forum forum = new Forum();
		
		forum.setTitle(data.get("ForumTitle").toString());
		forum.setUserId(user);
		forum.setForumdate(date);
		
		forumdao.addForum(forum);
		
		JSONObject json = new JSONObject();

		json.put("status", "Forum is posted");
		System.out.println(json.toString());
		
		
		return new ResponseEntity<String>(json.toString(),HttpStatus.OK);
	}
	
	@GetMapping("/getforums")
	public ResponseEntity<List<Forum>> listForum(){
		
		List<Forum> list = forumdao.listForum();
		
		return new ResponseEntity<List<Forum>>(list,HttpStatus.OK);
	}
	
}
