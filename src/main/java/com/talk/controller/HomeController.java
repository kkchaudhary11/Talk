package com.talk.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.talk.dao.FriendDAO;
import com.talk.dao.UserDAO;
import com.talk.model.User;

@Controller
public class HomeController {

	@Autowired
	UserDAO userdao;
	
	@Autowired
	FriendDAO frienddao;

	@RequestMapping("/")
	public ModelAndView def() {
		ModelAndView model = index();
		return model;
	}
	
	@RequestMapping("/aboutus")
	public String aboutUs(){
		
		return "aboutus";
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {
		
		String username = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			// System.out.println("User present");
			username = auth.getName();
			ModelAndView m = new ModelAndView("userprofile");
			return m;
		} 
		
		ModelAndView model = new ModelAndView("index");
		model.addObject("user", new User());
		return model;
	}

	@RequestMapping(value = "/adduser", method = RequestMethod.POST)
	public ModelAndView addUser(@Valid @ModelAttribute("user") User user, BindingResult result) {

		ModelAndView model = new ModelAndView("index");

		if (result.hasErrors()) {
			return model;
		} else {
			if (user.getPassword().equals(user.getCpassword())) {

				List<User> listuser = userdao.listUser();

				boolean usermatch = false;

				for (User u : listuser) {
					if (u.getEmail().equals(user.getEmail())) {
						usermatch = true;
						break;
					}
				}
				if (usermatch == false) {
					userdao.addUser(user);
					model.addObject("user", new User());
					model.addObject("success", "success");
				} else {
					model.addObject("useralreadyexists", "useralreadyexists");
				}
			} else {
				model.addObject("passwordmismatch", "passwordmismatch");
			}
		}
		return model;
	}
	
	@RequestMapping("/userprofile")
	public ModelAndView User(Principal p){
		
		if(p!=null){
			
			User user = userdao.getUserByEmail(p.getName());
			long userId = user.getUserId();
			
			frienddao.setOnline(userId);
			
			ModelAndView model = new ModelAndView("userprofile");
			return model;
		}
		
		
		ModelAndView model = new ModelAndView("index");
		model.addObject("user", new User());
		return model;
		
	}
	
	@RequestMapping("/logoutuser")
	public ModelAndView logOut(HttpServletRequest request, HttpServletResponse response, Principal p){

		ModelAndView model = new ModelAndView("index");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (p != null) 
		{
			User user = userdao.getUserByEmail(p.getName());
			long userId = user.getUserId();
			
			frienddao.setOffline(userId);
			System.out.println("User is LogOut");
			new SecurityContextLogoutHandler().logout(request, response, auth);
			model.addObject("status", "true");
		}
	
	model.addObject("user", new User());
	return model;
	}
	
	@RequestMapping("/viewblogs")
	public ModelAndView Blogs(Principal p){
		ModelAndView model = new ModelAndView("blogs");
		model.addObject("currentuser",p.getName());
		return model;
		
	}
	
	@RequestMapping("/allusers")
	public String Users(){
		
		return "people";
		
	}
	
	@RequestMapping("/friends")
	public String Freinds(){
		
		return "friend";
		
	}
	
	@RequestMapping("/jobs")
	public String Jobs(){
		
		return "jobs";
		
	}
	
	
	@RequestMapping("/events")
	public String Events(){
		
		return "events";
		
	}
	
	@RequestMapping("/viewforums")
	public ModelAndView Forums(Principal p){
		ModelAndView model = new ModelAndView("forums");
		model.addObject("currentuser",p.getName());
		return model;
		
	}
	


}
