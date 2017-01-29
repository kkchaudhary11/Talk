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

	private long friendId;
	private long userId;

	// if user is logged in goto /groupchat otherwise goto /index
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView viewApplication(Principal p) {

		if (p != null) {
			ModelAndView model = new ModelAndView("groupchat");
			return model;
		}

		ModelAndView model = new ModelAndView("index");
		model.addObject("user", new User());
		return model;
	}
	
	//group chatting
	@MessageMapping("/chat")
	@SendTo("/topic/message")
	public OutputMessage sendMessage(Message message, Principal p) {

		System.out.println("Message: " + message.getMessage());
		User user = userdao.getUserByEmail(p.getName());

		String username = user.getUsername();
		System.out.println(username);
		return new OutputMessage(message, new Date(), username);
	}

	@MessageMapping("/privatechat")
	public void sendMessage(Message message) {
		//pass the items to argument constructor
		PrivateMessage privateMessage = new PrivateMessage(message, new Date(), userId, friendId);
		System.out.println("Calling the method sendMessage");
		System.out.println("Message:" + privateMessage.getMessage());
		System.out.println("Time:" + privateMessage.getTime());
		System.out.println("User ID:" + privateMessage.getUserId());
		System.out.println("Friend ID:" + privateMessage.getFriendId());
		//send privateMessage object to currently logged-in user and to the friend 
		simpMessageTemplate.convertAndSend("/queue/message/" + privateMessage.getUserId(), privateMessage);
		simpMessageTemplate.convertAndSend("/queue/message/" + privateMessage.getFriendId(), privateMessage);

	}

	// get the friend id to whom chat with
	@GetMapping("friendchat/{id}")
	public ModelAndView getFriendId(@PathVariable("id") long id, Principal p) {
		System.out.println("inside getFriendId");

		// if user is logged in goto /privatechat otherwise goto /index
		if (p != null) {
			System.out.println(id);
			// assign local variable to instance variable
			this.friendId = id;
			ModelAndView model = new ModelAndView("privatechat");
			return model;
		}

		ModelAndView model = new ModelAndView("index");
		model.addObject("user", new User());
		return model;
	}

	//get the logged-in userId and send it to angular to subscribe the queue
	@GetMapping("getids")
	public ResponseEntity<String> getIds(Principal p) {

		User user = userdao.getUserByEmail(p.getName());

		long userId = user.getUserId();
		this.userId = userId;

		JSONObject json = new JSONObject();
		json.put("userId", userId);
		json.put("friendId", friendId); //not used only for testing
		System.out.println(json.toString());
		return new ResponseEntity<String>(json.toString(), HttpStatus.OK);
	}

}
