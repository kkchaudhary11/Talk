package com.talk.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import com.talk.dao.UserDAO;
import com.talk.model.User;

@Repository
@Transactional
@EnableTransactionManagement
public class UserDAOImpl implements UserDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	public void addUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.save(user);
	}

	public void deleteUser(int id) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(id);
	}

	public void updateUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.update(user);		
	}

	public User getUserById(int id) {
		Session session = sessionFactory.getCurrentSession();
		User user = (User)session.createQuery("from User where userId="+id).getSingleResult();	
		return user;
	}

	public List<User> listUser() {
		Session session = sessionFactory.getCurrentSession();
		List<User> list = session.createQuery("from User").getResultList();	
		return list;
	}

	public User getUserByEmail(String email) {
		Session session = sessionFactory.getCurrentSession();
		User user = (User)session.createQuery("from User where email='"+ email + "'").getSingleResult();	
		return user;
	}
	

}
