package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.InsBoard;
import com.sist.web.model.InsBoardFile;
import com.sist.web.model.InsComment;

@Repository("insBoardDao")
public interface InsBoardDao {
	
	//게시물 list 조회
	public List<InsBoard> boardListSelect(String userId);
	
	//게시물 총 갯수 조회
	public long boardTotalCnt(String userId);
	
	//게시물에 대한 첨부파일 조회 select
	public InsBoardFile boardFileSelect(long boardNum);
	
	//게시물 등록 insert
	public int boardInsert(InsBoard insBoard);
	
	//게시물 파일 등록 insert
	public int boardFileInsert(InsBoardFile insBoardFile);
	
	//게시물 단건 조회 
	public InsBoard boardOneSelect(long boardNum);
	
	//게시물의 댓글 list 조회
	public List<InsComment> commentList(long boardNum);
	
	//게시물 삭제 (게시물, 게시물파일, 게시물 좋아요, 게시물 댓글)
	public int boardDelete(long boardNum);
	
	//댓글 등록
	public int commentInsert(InsComment insComment);
	
	//대댓글 등록
	public int replyCommentInsert(InsComment insComment);
	
	//해당 게시물 댓글 총 갯수 조회
	public int commentCnt(long boardNum);
	
}
