package com.talk.dao;

import java.util.List;

import com.talk.model.Event;

public interface EventDAO {

	public void addEvent(Event event);
	public Event getEventById(long id);
		
	public List<Event> listEvents();
}
