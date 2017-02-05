package com.talk.dao;

import java.util.List;

import com.talk.model.Blog;
import com.talk.model.Forum;

public interface ForumDAO {

	public void addForum(Forum forum);
	
	public Forum getForumById(int id);
	//for users	
	public List<Forum> listForum();

}
