package com.talk.dao;

import java.util.List;

import com.talk.model.ForumComment;

public interface ForumCommentDAO {

	public void addForumComment(ForumComment forumComment);
	
	public List<ForumComment> listForumComment();
	
	

}
