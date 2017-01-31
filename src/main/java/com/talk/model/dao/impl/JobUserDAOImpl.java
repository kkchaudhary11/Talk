package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.JobUserDAO;
import com.talk.model.JobUser;

@Repository
@Transactional
@EnableTransactionManagement
public class JobUserDAOImpl implements JobUserDAO{

	@Autowired
	SessionFactory sessionFactory;
	
	
	public List<JobUser> getall() {
		
		Session session = sessionFactory.getCurrentSession();
		List<JobUser> list = session.createQuery("from JobUser ").getResultList();	
		return list;
		// TODO Auto-generated method stub
	}

}
