package com.talk.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(schema="kkc")
public class BlogData {
	
	@Id @GeneratedValue(strategy=GenerationType.SEQUENCE)
	private long BlogDataId;
	
	@ManyToOne
	@JoinColumn(name="blogId")
	private Blog BlogId;
	
	@Type(type="text")
	private String blogData;

	


	public long getBlogDataId() {
		return BlogDataId;
	}

	public void setBlogDataId(long blogDataId) {
		BlogDataId = blogDataId;
	}

	public String getBlogData() {
		return blogData;
	}

	public void setBlogData(String blogData) {
		this.blogData = blogData;
	}

	public Blog getBlogId() {
		return BlogId;
	}

	public void setBlogId(Blog blogId) {
		BlogId = blogId;
	}



	//
	
}
