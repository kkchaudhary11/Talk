package com.talk.controller;

import java.security.Principal;
import java.util.Date;

import org.json.simple.JSONObject;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.talk.dao.UserDAO;
import com.talk.dto.Message;
import com.talk.dto.OutputMessage;
import com.talk.dto.PrivateMessage;
import com.talk.model.User;


@Controller
@RequestMapping("/talk")
public class ChatController {

	@Autowired
	UserDAO userdao;
	
	@Autowired
	private SimpMessagingTemplate simpMessageTemplate;
	
	private long friendId ;
	private long userId;

	
  @RequestMapping(method = RequestMethod.GET)
  public ModelAndView viewApplication( Principal p) {
	  
	  if(p!=null){
		  ModelAndView model = new ModelAndView("groupchat");
			return model;
	  }
	  
	ModelAndView model = new ModelAndView("index");
	model.addObject("user", new User());
	return model;
  }
  
  

  @MessageMapping("/chat")
  @SendTo("/topic/message")
  public OutputMessage sendMessage(Message message , Principal p) {
	 
	  System.out.println("Message: "+message.getMessage());
	  	User user = userdao.getUserByEmail(p.getName());
		
		String username = user.getUsername();
		System.out.println(username);
		return new OutputMessage(message, new Date(), username);
  }
  
  @MessageMapping("/privatechat")
  public void sendMessage(Message message){

	  
	  PrivateMessage privateMessage = new PrivateMessage(message, new Date(),userId,friendId);
	  System.out.println("Calling the method sendMessage");
	  System.out.println("Message:" + privateMessage.getMessage());
	  System.out.println("Time:" + privateMessage.getTime());
	  
	  System.out.println("User ID:" + privateMessage.getUserId());

	  System.out.println("Friend ID:" + privateMessage.getFriendId());
	 
	 
	  simpMessageTemplate.convertAndSend("/queue/message/"+privateMessage.getUserId(), privateMessage);
	  simpMessageTemplate.convertAndSend("/queue/message/"+privateMessage.getFriendId(), privateMessage); 
	  
  }
  
 
  @GetMapping("getfriendid/{id}")
  public ModelAndView getFriendId(@PathVariable("id") long id, Principal p) {
	  
	  System.out.println("inside get friend id");
	  
	  if(p!=null){
		  System.out.println(id);
		  this.friendId = id;
		  ModelAndView model = new ModelAndView("privatechat");
		
			return model;
	  }
	  
	ModelAndView model = new ModelAndView("index");
	model.addObject("user", new User());
	return model;
  }
  
  @GetMapping("getids")
  public ResponseEntity<String> getIds(Principal p) {
	  
	User user = userdao.getUserByEmail(p.getName());
		
		long userId = user.getUserId();
		this.userId = userId;
		
	  JSONObject json = new JSONObject();
		json.put("userId", userId);
		json.put("friendId", friendId);
		System.out.println(json.toString());
	 return new ResponseEntity<String>(json.toString(),HttpStatus.OK);
  }
  
}
