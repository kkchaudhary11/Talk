package com.talk.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(schema="kkc")
public class ForumComment {
	
	@Id @GeneratedValue(strategy=GenerationType.SEQUENCE)
	private long forumCommentId;
	
	private String forumcomment;
	
	@ManyToOne
	@JoinColumn(name="forumId")
	private Forum forumId;
	

	@ManyToOne
	@JoinColumn(name="userId")
	private User userId;
	
	private Date commentDate;
	
	//getters and setters

	public long getForumCommentId() {
		return forumCommentId;
	}

	public void setForumCommentId(long forumCommentId) {
		this.forumCommentId = forumCommentId;
	}
	


	public String getForumcomment() {
		return forumcomment;
	}

	public void setForumcomment(String forumcomment) {
		this.forumcomment = forumcomment;
	}

	public Forum getForumId() {
		return forumId;
	}

	public void setForumId(Forum forumId) {
		this.forumId = forumId;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	
	
}
