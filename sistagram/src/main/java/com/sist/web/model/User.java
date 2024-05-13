package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String userId;		//회원 아이디
	private String userPwd;		//회원 비밀번호
	private String userName;	//회원명
	private String userPhone;	//회원 전화번호
	private String userEmail;	//회원 이메일
	private String userIntro;	//회원 소개
	private String regDate;		//회원 가입일
	private String status;		//회원 상태 (Y:정상 N:정지 E:탈퇴 K:퇴출)
	
	private String fileName;	//회원 프로필 파일이름
	
	private UserFile userFile;	//회원 프로필
	
	private String followingId;	//팔로잉 아이디
	
	public User() {
		userId = "";
		userPwd = "";
		userName = "";
		userPhone = "";
		userEmail = "";
		userIntro = "";
		regDate = "";
		status = "Y";
		
		fileName = "";
		
		userFile = null;
		
		followingId = "";
		
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserIntro() {
		return userIntro;
	}

	public void setUserIntro(String userIntro) {
		this.userIntro = userIntro;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public UserFile getUserFile() {
		return userFile;
	}

	public void setUserFile(UserFile userFile) {
		this.userFile = userFile;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFollowingId() {
		return followingId;
	}

	public void setFollowingId(String followingId) {
		this.followingId = followingId;
	}
	
	
	
	
	
	
	
}
