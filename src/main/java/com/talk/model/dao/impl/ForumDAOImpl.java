package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.ForumDAO;
import com.talk.model.Forum;

@Repository
@Transactional
@EnableTransactionManagement
public class ForumDAOImpl  implements ForumDAO{

	@Autowired
	SessionFactory sessionFactory;
	
	
	public void addForum(Forum forum) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(forum);
	}

	
	
	public Forum getForumById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Forum forum = (Forum)session.createQuery("from Forum where forumId="+id).getSingleResult();	
		return forum;
	}


	public List<Forum> listForum() {
		Session session = sessionFactory.getCurrentSession();
		List<Forum> list = session.createQuery("from Forum").getResultList();	
		return list;
	}
	
}
