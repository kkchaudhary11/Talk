package com.talk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.talk.dao.UserDAO;
import com.talk.model.User;

@Controller
public class HomeController {
	
	@Autowired
	UserDAO userdao;

	
	@RequestMapping("/")
	public String def(){		
		return "index";
	}
	
	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView logIn(){
		ModelAndView model = new ModelAndView("index");
		model.addObject("user",new User());
		return model;
	}
	
	@RequestMapping(value="/adduser", method=RequestMethod.POST)
	public String addUser(@ModelAttribute("user") User user){
		
		userdao.addUser(user);
		
		return "index";
	}
	
}
