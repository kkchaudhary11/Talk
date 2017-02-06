package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.ForumCommentDAO;
import com.talk.model.ForumComment;

@Repository
@Transactional
@EnableTransactionManagement
public class ForumCommentDAOImpl implements ForumCommentDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	public void addForumComment(ForumComment forumComment) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(forumComment);
	}
	


	public List<ForumComment> listForumComment() {
		Session session = sessionFactory.getCurrentSession();
		List<ForumComment> list  = session.createQuery("from ForumComment").getResultList();
		return list;
	}
	

}
