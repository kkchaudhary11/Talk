package com.talk.dao;

import java.util.List;

import com.talk.model.Blog;
import com.talk.model.BlogData;

public interface BlogDataDAO {

	public void addBlogData(BlogData blogdata);
	
	public List<BlogData> listBlogData();

}
