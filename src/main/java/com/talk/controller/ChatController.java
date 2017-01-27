package com.talk.controller;

import java.security.Principal;
import java.util.Date;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.talk.dao.UserDAO;
import com.talk.dto.Message;
import com.talk.dto.OutputMessage;
import com.talk.model.User;


@Controller
@RequestMapping("/talk")
public class ChatController {

	@Autowired
	UserDAO userdao;

	
  @RequestMapping(method = RequestMethod.GET)
  public ModelAndView viewApplication( Principal p) {
	  
	  if(p!=null){
		  ModelAndView model = new ModelAndView("groupchat");
			model.addObject("user", new User());
			return model;
	  }
	  
	ModelAndView model = new ModelAndView("index");
	model.addObject("user", new User());
	return model;
  }

  @MessageMapping("/chat")
  @SendTo("/topic/message")
  public OutputMessage sendMessage(Message message , Principal p) {
	  System.out.println("message is send");
	  
	  User user = userdao.getUserByEmail(p.getName());
		
		String username = user.getUsername();
		System.out.println(username);
		return new OutputMessage(message, new Date(), username);
  }
}
