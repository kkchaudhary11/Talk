package com.talk.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.talk.dao.UserDAO;
import com.talk.model.User;

@RestController
public class RESTController {

	@Autowired
	UserDAO userdao;
	
	@RequestMapping(value="/userdata",method=RequestMethod.GET)
	public ResponseEntity<User> UserProfile(){
		
		//authentication
		String username = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			// System.out.println("User present");
			username = auth.getName();
		} 
		
		
		//return if not authorized
		if(username==null){
			return new ResponseEntity<User>(HttpStatus.NETWORK_AUTHENTICATION_REQUIRED);	
		}
		
		//get user data if user is authorized
			User user = userdao.getUserByEmail(username);
			return new ResponseEntity<User>(user, HttpStatus.OK);
		
	}
	
	@RequestMapping(value="/allusers",method=RequestMethod.GET)
		public ResponseEntity<List<User>> allUsers(){
		
		List<User> list = userdao.listUser();
		
		return new ResponseEntity<List<User>>(list, HttpStatus.OK);
		
			}

	
	@RequestMapping(value="/deleteuser",method=RequestMethod.POST)
	public ResponseEntity<List<User>> deleteUser(@RequestBody String inputdata){
		System.out.println(inputdata);
	
		
		userdao.deleteUser(Integer.parseInt(inputdata));
	
		List<User> list = userdao.listUser();
		return new ResponseEntity<List<User>>(list, HttpStatus.OK);
	
		}
	
	
	@RequestMapping(value="/updateuser",method=RequestMethod.POST)
	public ResponseEntity<String> updateUser(@RequestBody JSONObject data){
		System.out.println(data);
		
		int userid = Integer.parseInt(data.get("UserId").toString());
	
		User user = userdao.getUserById(userid);
		
		user.setUserId(userid);
		user.setUsername(data.get("Username").toString());
		user.setPhone(data.get("Phone").toString());
		user.setCity(data.get("City").toString());
		user.setDob(data.get("DOB").toString());
		user.setGender(data.get("Gender").toString());
		
		userdao.updateUser(user);
		
		JSONObject json = new JSONObject();
        
        json.put("status", "UPDATED");
        System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
		}
	
	@RequestMapping(value="/userdata",method=RequestMethod.POST)
	public ResponseEntity<String> UserProfileUpdate(@RequestBody User user,@PathVariable("email") String email){
		
		User u=userdao.getUserByEmail(email);
		u.setCity(user.getCity());
		u.setPassword(user.getPassword());
		u.setPhone(user.getPhone());
		u.setUsername(user.getUsername());
		userdao.updateUser(u);
		
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	
	
	
	/*
	@RequestMapping(value="/userprofile",  method=RequestMethod.GET)
	public ResponseEntity<User> getUsers(Principal principal){
		
		System.out.println(principal.getName());
		
		if(principal.getName()==null){
			return new ResponseEntity<User>(HttpStatus.NOT_FOUND);		
		}
		
		User user = userdao.getUserByEmail(principal.getName());
		
		return new ResponseEntity<User>(user,HttpStatus.OK);	
		
	}*/
}
