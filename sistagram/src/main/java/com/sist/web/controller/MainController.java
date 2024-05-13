package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.InsBoard;
import com.sist.web.model.InsBoardFile;
import com.sist.web.model.InsComment;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.InsBoardService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("mainController")
public class MainController {
	
	private static Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private InsBoardService insBoardService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	// /main/home 화면 띄우기
	@RequestMapping(value="/main/home")
	public String home(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		long totalCnt = 0;
		List<InsBoard> boardList = null;
		List<User> recommendUserList = null;
		User user = null;
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = null;
		
		if(cookieUserId != null) {
			user = userService.userSelect(cookieUserId);
//			UserFile userFile = new UserFile();
//			userFile.setUserId(cookieUserId);
//		
//			userFile = userService.userFileSelect(userFile);
			
			recommendUserList = userService.recommendedMembers(cookieUserId);
		}
		
		
		totalCnt = insBoardService.boardTotalCnt(userId);
		
		if(totalCnt > 0) {
			boardList = insBoardService.boardListSelect(userId);
		}
		
		logger.debug("++++++++++++++토탈카운트+++++++++++++++++++" + totalCnt);
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("recommendUserList", recommendUserList);
		model.addAttribute("user", user);
		model.addAttribute("boardList", boardList);
		
		return "/main/home";
	}
	
	
	//게시글 등록 Proc
	@RequestMapping(value="/main/writeProc")
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String CookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FileData fileData = HttpUtil.getFile(request, "boardImg", UPLOAD_SAVE_DIR);
		String boardContent = HttpUtil.get(request, "boardContent", "");
		
		if(!StringUtil.isEmpty(boardContent)) {
			InsBoard insBoard = new InsBoard();
			
			insBoard.setUserId(CookieUserId);
			insBoard.setBoardContent(boardContent);
			
			if(fileData != null && fileData.getFileSize() > 0) {
				InsBoardFile insBoardFile = new InsBoardFile();
				
				insBoardFile.setFileName(fileData.getFileName());
				insBoardFile.setFileOrgName(fileData.getFileOrgName());
				insBoardFile.setFileExt(fileData.getFileExt());
				insBoardFile.setFileSize(fileData.getFileSize());
				
				insBoard.setInsBoardFile(insBoardFile);

				try {
					int cnt = insBoardService.boardInsert(insBoard);
					if(cnt > 0) {
						logger.debug("보드 인서트 cnt ++++++++++++++++++++==" + cnt);
						res.setResponse(200, "Success");
						
					}else {
						res.setResponse(500, "Insert Internal Error");
					}
				}catch(Exception e) {
					res.setResponse(500, "Insert Internal Server Error");
					logger.error("[MainController] writeProc Exception -- ", e);
				}
			}else {
				res.setResponse(400, "Bad Request - File");
			}
		}else {
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}
	
	
	//검색버튼 - 회원 검색 화면 보이기
	@RequestMapping(value="/main/searchUser")
	public String searchUser(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String searchValue = HttpUtil.get(request, "searchValue", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		List<User> list = null;
		
		logger.debug("searchValue ----->" + searchValue);
		
		if(!StringUtil.isEmpty(searchValue)) {
			
			User user = new User();
			user.setUserId(searchValue);
			user.setUserName(searchValue);
			user.setUserIntro(searchValue);
			
			list = userService.userSearchSelect(user);
			
			if(list != null) {
				model.addAttribute("list", list);
			}
			else {
				String error= "에러남 - list:null";
				model.addAttribute("error", error);
			}
		}
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("searchValue", searchValue);
		
		
		return "/main/searchUser";
	}
	
	//프로필 화면 뿌리기
	@RequestMapping(value="/main/profile")
	public String profile(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId", "");
		
		List<InsBoard> list = null;
		List<User> followingList = null;
		List<User> followerList = null;
		User user = null;
		
		
		long followingCnt = 0;
		
		if(cookieUserId != null) {
			list = insBoardService.boardListSelect(cookieUserId);
			user = userService.userAllSelect(cookieUserId);
			followingList = userService.followingList(cookieUserId);
			followerList = userService.followerList(cookieUserId);
		}
		if(list != null) {
			model.addAttribute("list", list);
		}
		if(user != null) {
			model.addAttribute("user", user);
		}
		
		model.addAttribute("followingList", followingList);
		model.addAttribute("followerList", followerList);
		
		return "/main/profile";
	}
	
	//게시물 상세 띄우기
	@RequestMapping(value="/main/boardDetail")
	public String boardDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//, @RequestParam("boardNum") Long boardNum
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		
		logger.debug("boardNum 는 " + boardNum);
		
		InsBoard insBoard = null;
		List<InsComment> commentList = null;
		
		
		if(boardNum > 0) {
			insBoard = insBoardService.boardOneSelect(boardNum);
			commentList = insBoardService.commentList(boardNum);
		}
		if(insBoard != null) {
			model.addAttribute("insBoard", insBoard);
		}
		if(commentList != null) {
			model.addAttribute("commentList", commentList);
		}
		
		User boardUser = userService.userAllSelect(insBoard.getUserId());
		
		if(boardUser != null) {		//해당 게시물 작성한 사용자 정보
			model.addAttribute("boardUser", boardUser);
		}
		
		if(cookieUserId != null) {
			model.addAttribute(cookieUserId);	//로그인한 사용자의 아이디
		}
		
		model.addAttribute("boardNum", boardNum);
		
		return "/main/boardDetail";
	}
	
	//게시물 삭제
	@RequestMapping(value="/main/deleteBoard")
	public Response<Object> deleteBoard(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		
		InsBoard insBoard = null;
		
		if(boardNum > 0) {
			insBoard = insBoardService.boardOneSelect(boardNum);
			
			if(insBoard != null) {
				
			}
		}
		
		return res;
	}
	
	//아이디 클릭시 프로필 화면
	@RequestMapping(value="/main/profileSomeone")
	public String profileSomeone(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String someId= HttpUtil.get(request, "someId");
		long boardNum;
		
		User user = null;
		List<InsBoard> list = null;
		List<User> followingList = null;
		List<User> followerList = null;
		
		if(!StringUtil.isEmpty(someId)) {
			user = userService.userAllSelect(someId);
			followingList = userService.followingList(someId);
			followerList = userService.followerList(someId);
		}
		
		if(user != null) {
			model.addAttribute("user", user);
		}
		
		list = insBoardService.boardListSelect(someId);
		
		model.addAttribute("someId", someId);
		model.addAttribute("list", list);
		model.addAttribute("followingList", followingList);
		model.addAttribute("followerList", followerList);
		
		return "/main/profileSomeone";
	}
	
	
	// 댓글 등록 Proc
	@RequestMapping(value="/main/commentProc")
	@ResponseBody
	public Response<Object> commentProc(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String userId = HttpUtil.get(request, "userId", "");
		long boardNum = HttpUtil.get(request, "boardNum", 0);
		long commentGroup = HttpUtil.get(request, "commentGroup", 0);
		String comment = HttpUtil.get(request, "comment");
		
		InsComment insComment = new InsComment();
		
		if(StringUtil.equals(cookieUserId, cookieUserId)) {
			User user = userService.userSelect(cookieUserId);
			if(StringUtil.equals(user.getStatus(), "Y")) {
				if(boardNum > 0) {
					
					logger.debug("commentGroup ----- " + commentGroup);
					
					if(commentGroup == 0) {			//이전 그룹이 null일 경우 (기본값 0)
						insComment.setBoardNum(boardNum);
						insComment.setUserId(cookieUserId);
						insComment.setCommentContent(comment);
						insComment.setCommentParent(0);
						insComment.setStatus("Y");
						
						if(insBoardService.commentInsert(insComment) >0) {
							res.setResponse(200, "Success");
						}
						else {
							res.setResponse(500, "Error");
						}
					}
					else {
						insComment.setBoardNum(boardNum);
						insComment.setUserId(cookieUserId);
						insComment.setCommentContent(comment);
						insComment.setCommentGroup(commentGroup);
						insComment.setCommentParent(1);
						insComment.setStatus(comment);
						insComment.setStatus("Y");
						
						if(insBoardService.replyCommentInsert(insComment) > 0) {
							res.setResponse(200, "Success");
						}
						else {
							res.setResponse(500, "Error");
						}
					}
				}
				else {
					res.setResponse(404, "Not Found");
				}				
			}
			else {
				res.setResponse(402, "User Status Incorrect");
			}
		}
		else {
			res.setResponse(401, "User Error");
		}
		

		
		return res;
	}
	
}
