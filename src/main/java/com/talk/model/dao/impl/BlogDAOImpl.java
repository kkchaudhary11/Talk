package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.BlogDAO;
import com.talk.model.Blog;

@Repository
@Transactional
@EnableTransactionManagement
public class BlogDAOImpl  implements BlogDAO{

	@Autowired
	SessionFactory sessionFactory;
	
	
	public void addBlog(Blog blog) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(blog);
	}

	public void deleteBlog(Blog blog) {
		
	}
	
	public Blog getBlogById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Blog blog = (Blog)session.createQuery("from Blog where blogId="+id).getSingleResult();	
		return blog;
	}


	public List<Blog> listAllBlogs() {
		Session session = sessionFactory.getCurrentSession();
		List<Blog> list = session.createQuery("from Blog").getResultList();	
		return list;
	}
	
	public List<Blog> listBlogs() {
		Session session = sessionFactory.getCurrentSession();
		List<Blog> list = session.createQuery("from Blog where posted="+1).getResultList();	
		return list;
	}

	
	
}
