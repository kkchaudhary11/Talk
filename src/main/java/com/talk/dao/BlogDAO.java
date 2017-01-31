package com.talk.dao;

import java.util.List;

import com.talk.model.Blog;

public interface BlogDAO {

	public void addBlog(Blog blog);
	
	public Blog getBlogById(int id);
	//for users	
	public List<Blog> listBlogs();
	//for admin
	public List<Blog> listAllBlogs();
}
