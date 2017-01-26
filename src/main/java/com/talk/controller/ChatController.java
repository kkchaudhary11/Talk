package com.talk.controller;

import java.util.Date;

import org.slf4j.*;

import org.springframework.messaging.handler.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.talk.dto.Message;
import com.talk.dto.OutputMessage;



@Controller
@RequestMapping("/talk")
public class ChatController {

  @RequestMapping(method = RequestMethod.GET)
  public String viewApplication() {
    return "groupchat";
  }

  @MessageMapping("/chat")
  @SendTo("/topic/message")
  public OutputMessage sendMessage(Message message) {
	  System.out.println("message is send");
	 
    return new OutputMessage(message, new Date());
  }
}
