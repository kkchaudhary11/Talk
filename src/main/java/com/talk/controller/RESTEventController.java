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

import com.talk.dao.EventDAO;
import com.talk.model.Event;
@RestController
public class RESTEventController {
	
	@Autowired
	EventDAO eventdao;
	
	
	@PostMapping("admin/postevent")
	public ResponseEntity<String> postEvent(@RequestBody JSONObject data, Principal p) {
		System.out.println(data);

		Date date = new Date();
		System.out.println(date);

		Event event = new Event();

		event.setTitle(data.get("EventTitle").toString());
		event.setDescription(data.get("EventDesc").toString());
		event.setPostdate(date);

		eventdao.addEvent(event);

		JSONObject json = new JSONObject();

		json.put("status", "Event is Posted");
		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}
	
	@GetMapping("/viewevents")
	public ResponseEntity<List<Event>> events() {

		List<Event> list = eventdao.listEvents();

		return new ResponseEntity<List<Event>>(list, HttpStatus.OK);

	}
	

}
