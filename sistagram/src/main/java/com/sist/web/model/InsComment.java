package com.sist.web.model;

import java.io.Serializable;

public class InsComment implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long commentNum;
	private long boardNum;
	private String userId;
	private String commentContent;
	private long commentGroup;
	private long commentParent;
	private String status;
	private String regDate;
	
	private String fileName;
	
	public InsComment() {
		commentNum = 0;
		boardNum = 0;
		userId = "";
		commentContent = "";
		commentGroup = 0;
		commentParent = 0;
		status = "";
		regDate = "";
		
		fileName = "";
	}

	public long getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(long commentNum) {
		this.commentNum = commentNum;
	}

	public long getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(long boardNum) {
		this.boardNum = boardNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public long getCommentGroup() {
		return commentGroup;
	}

	public void setCommentGroup(long commentGroup) {
		this.commentGroup = commentGroup;
	}

	public long getCommentParent() {
		return commentParent;
	}

	public void setCommentParent(long commentParent) {
		this.commentParent = commentParent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
}
