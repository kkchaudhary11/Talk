package com.talk.dao;

import java.util.List;

import com.talk.model.Friend;

public interface FriendDAO {

	public void addFriend(Friend friend);
	public void updateFriend(Friend friend);
	public Friend getFriend(long loggedInUserId, long friendId);
	public List<Friend> getFriendRequsts(long userId);
	public List<Friend> listFriends(long userId);
	
	public int countFriendRequset(long userId);
	
}
