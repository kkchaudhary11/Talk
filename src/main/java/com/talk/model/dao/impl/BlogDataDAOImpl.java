package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.BlogDataDAO;
import com.talk.model.BlogData;

@Repository
@Transactional
@EnableTransactionManagement
public class BlogDataDAOImpl implements BlogDataDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	public void addBlogData(BlogData blogdata) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(blogdata);
	}

	public List<BlogData> listBlogData() {
		Session session = sessionFactory.getCurrentSession();
		List<BlogData> list  = session.createQuery("from BlogData").getResultList();
		return list;
	}

}
