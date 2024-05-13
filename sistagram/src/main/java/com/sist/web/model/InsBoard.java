package com.sist.web.model;

import java.io.Serializable;

public class InsBoard implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long boardNum;
	private String userId;
	private String boardContent;
	private long likeCnt;
	private String regDate;
	
	private long fileNum;
	private String fileName;
	
	private String userFileName;
	
	private long commentCnt;

	private InsBoardFile insBoardFile;
	
	public InsBoard() {
		boardNum = 0;
		userId = "";
		boardContent = "";
		likeCnt = 0;
		regDate = "";
		
		fileNum = 0;
		fileName = "";
		
		userFileName = "";
		
		commentCnt = 0;
		
		insBoardFile = null;
	}

	
	
	public InsBoardFile getInsBoardFile() {
		return insBoardFile;
	}

	public void setInsBoardFile(InsBoardFile insBoardFile) {
		this.insBoardFile = insBoardFile;
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

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public long getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(long likeCnt) {
		this.likeCnt = likeCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public long getFileNum() {
		return fileNum;
	}

	public void setFileNum(long fileNum) {
		this.fileNum = fileNum;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}



	public String getUserFileName() {
		return userFileName;
	}

	public void setUserFileName(String userFileName) {
		this.userFileName = userFileName;
	}



	public long getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(long commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	
	
	

	
	
	
}
