package com.talk.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Type;

@Entity
@Table(schema="kkc")
public final class Blog {
	
	@Id @GeneratedValue(strategy=GenerationType.SEQUENCE)
	private long blogId;
	private String title;
	
	
	private String description;
	
	
	@ManyToOne
	@JoinColumn(name="userId")
	private User userId;
	
	
	private Date blogdate;
	
	private boolean posted=false;
	
	//getters and setters

	public long getBlogId() {
		return blogId;
	}

	public void setBlogId(long blogId) {
		this.blogId = blogId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	public Date getBlogdate() {
		return blogdate;
	}

	public void setBlogdate(Date blogdate) {
		this.blogdate = blogdate;
	}

	public boolean isPosted() {
		return posted;
	}

	public void setPosted(boolean posted) {
		this.posted = posted;
	}
	
	
	
}
