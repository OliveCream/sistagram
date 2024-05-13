package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.dao.InsBoardDao;
import com.sist.web.model.InsBoard;
import com.sist.web.model.InsBoardFile;
import com.sist.web.model.InsComment;

@Service("insBoardService")
public class InsBoardService {
	
	private static Logger logger = LoggerFactory.getLogger(InsBoardService.class);
	
	@Autowired
	private InsBoardDao insBoardDao;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//총 게시물 수 조회 메서드
	public long boardTotalCnt(String userId) {
		
		long totalCnt = 0;
		
		try {
			totalCnt = insBoardDao.boardTotalCnt(userId);
		}catch(Exception e) {
			logger.error("[InsBoardService] boardTotalCnt -- ", e);
		}
		
		return totalCnt;
	}
	
	//게시물 리스트 불러오기
	public List<InsBoard> boardListSelect(String userId){
		List<InsBoard> list = null;
		
		try {
			list = insBoardDao.boardListSelect(userId);
		}catch(Exception e) {
			logger.error("[InsBoardService] boardListSelect -- ", e);
		}
		
		return list;
	}
	
	//게시물 단건 조회 select
	public InsBoard boardOneSelect(long boardNum) {
		InsBoard insBoard = null;
		
		try {
			insBoard = insBoardDao.boardOneSelect(boardNum);
			
			if(insBoard != null) {
				InsBoardFile insBoardFile = insBoardDao.boardFileSelect(boardNum);
				
				if(insBoardFile != null) {
					insBoard.setInsBoardFile(insBoardFile);
				}
			}
		}catch(Exception e) {
			logger.error("[InsBoardService] boardOneSelect -- ", e);
		}
		
		return insBoard;
	}
	
	//댓글 list 불러오기
	public List<InsComment> commentList(long boardNum){
		List<InsComment> list = null;
		
		try {
			list = insBoardDao.commentList(boardNum);
		}catch(Exception e) {
			logger.error("[InsBoardService] commentList -- ", e);
		}
		
		return list;
	}
	
	//게시물 등록 insert
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(InsBoard insBoard) {
		int cnt = 0;
		
		cnt = insBoardDao.boardInsert(insBoard);
		
		if(cnt > 0 && insBoard.getInsBoardFile() != null) {
			InsBoardFile insBoardFile = insBoard.getInsBoardFile();
			insBoardFile.setBoardNum(insBoard.getBoardNum());
			
			insBoardDao.boardFileInsert(insBoardFile);
		}
		
		return cnt;
	}
	
	
	//댓글 등록 insert
	public int commentInsert(InsComment insCommnet) {
		int cnt = 0;
		
		try {
			cnt = insBoardDao.commentInsert(insCommnet);
		}catch(Exception e) {
			logger.error("[InsBoardService] commentInsert -- ", e);
		}
		
		return cnt;
	}
	
	//대댓글 등록 insert
	public int replyCommentInsert(InsComment insComment) {
		int cnt = 0;
		
		try {
			cnt = insBoardDao.replyCommentInsert(insComment);
		}catch(Exception e) {
			logger.error("[InsBoardService] replyCommentInsert -- ", e);
		}
		
		return cnt;
	}
	
	
	//댓글 갯수 조회 select
	public int commentCnt(long boardNum) {
		int totalCnt = 0;
		
		try {
			totalCnt = insBoardDao.commentCnt(boardNum);
		}catch(Exception e) {
			logger.error("[InsBoardService] commentCnt -- ", e);
		}
		
		return totalCnt;
	}
	
	
}
