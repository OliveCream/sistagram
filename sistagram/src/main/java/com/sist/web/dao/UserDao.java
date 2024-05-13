package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.User;
import com.sist.web.model.UserFile;

@Repository("userDao")
public interface UserDao {
	
	//사용자 정보 조회
	public User userSelect(String userId);
	
	//회원 중복 조회(아이디,이메일,전화번호)
	public int userCount(String login);
	
	//회원 가입 insert
	public int userInsert(User user);
	
	//email id 검색해 Email찾기 (비밀번호찾기 이메일 보내기)
	
	
	//회원정보수정 update
	public int userUpdate(User user);
	
	//회원프로필사진 select
	public UserFile userFileSelect(UserFile userFile);
	
	//회원프로필사진 insert
	public int userFileInsert(UserFile userFile);
	
	//회원프로필사진 delete
	public int userFileDelete(String userId);
	
	//id -> 회원 조회 (프로필사진 이름까지)
	public User userAllSelect(String userId);
	
	//조건에 대한 회원 조회 (id name intro)
	public List<User> userSearchSelect(User user);
	
	//회원 추천 (본인,팔로잉 제외)
	public List<User> recommendedMembers(String userId);
	
	//유저의 팔로잉 추가 insert
	public int followInsert(User user);
	
	//유저의 팔로우 취소 delete
	public int followCancelDelete(User user);
	
	//유저의 팔로잉 수 조회
	public long followingCnt(String userId);
	
	//팔로잉 list 조회
	public List<User> followingList(String userId);
	
	//팔로워 list 조회
	public List<User> followerList(String userId);

}
