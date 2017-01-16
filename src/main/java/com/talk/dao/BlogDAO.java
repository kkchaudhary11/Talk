package com.talk.dao;

import java.util.List;

import com.talk.model.Blog;

public interface BlogDAO {

	public void addBlog(Blog blog);
	public void deleteBlog(Blog blog);
	public Blog getBlogById(int id);
	public List<Blog> listBlogs();
	
}
