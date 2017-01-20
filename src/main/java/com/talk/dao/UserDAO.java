package com.talk.dao;

import java.util.List;

import com.talk.model.User;

public interface UserDAO {
	
	public void addUser(User user);
	public void deleteUser(int id);
	public void updateUser(User user);
	public User getUserById(int id);
	public User getUserByEmail(String email);
	public List<User> listUser();
	public List<User> getAllUserExceptMe(String email);
}
