package com.talk.dao;

import java.util.List;

import com.talk.model.User;

public interface UserDAO {
	
	public void addUser(User user);
	public void deleteUser(int id);
	public void updateUser(int id);
	public User getUserById(int id);
	public List<User> listUser();
}
