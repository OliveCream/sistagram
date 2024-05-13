package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.model.UserFile;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("userController")
public class UserController {

	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir']}")		//WEB-INF아래 config아래 env.xml의 업로드저장 디렉토리 가져오기
	private String UPLOAD_SAVE_DIR;

	@RequestMapping(value = "/user/signUp")
	public String signUp(HttpServletRequest request, HttpServletResponse response) {

		String cookiUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		if (!StringUtil.isEmpty(cookiUserId)) {
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}

		return "/user/signUp";
	}

	@RequestMapping(value = "/user/findPwd")
	public String findPwd(HttpServletRequest request, HttpServletResponse response) {

		return "/user/findPwd";
	}

	// 로그인 ajax
	@RequestMapping(value = "/user/login", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();

		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");

		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
			User user = userService.userSelect(userId);

			if (user != null) {

				if (StringUtil.equals(user.getUserPwd(), userPwd)) {

					if (StringUtil.equals(user.getStatus(), "Y")) { // 로그인 성공
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
						res.setResponse(0, "Success");
					} else if (StringUtil.equals(user.getStatus(), "N")) { // 정지
						res.setResponse(-1, "Suspended Member");
					} else if (StringUtil.equals(user.getStatus(), "E")) { // 탈퇴
						res.setResponse(-2, "Withdrawn Member");
					} else if (StringUtil.equals(user.getStatus(), "K")) { // 퇴출
						res.setResponse(-3, "Expelled Member");
					} else {
						res.setResponse(-100, "Unexpected Error");
					}
				} else {
					res.setResponse(-99, "Password Error");
				}
			} else {
				res.setResponse(404, "Not Found");
			}
		} else {
			res.setResponse(400, "Bad Request");
		}

		return res;
	}

	// 로그아웃
	@RequestMapping(value = "/user/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {

		if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}

		return "/index";
	}

	// 회원가입시 아이디, 이메일 중복체크 ajax
	@RequestMapping(value = "/user/idEmailCheck")
	@ResponseBody
	public Response<Object> idEmailCheck(HttpServletRequest request, HttpServletResponse response) {

		Response<Object> res = new Response<Object>();

		String userId = HttpUtil.get(request, "userId", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");
		// String userPhone = HttpUtil.get(request, "userPhone", "");

		logger.debug("아이디 이메일 중복 체크 로그 ++++++++++++++++++++++" + userId + " ----- " + userEmail);

		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userEmail)) {
			if (userService.userCount(userId) > 0) {
				res.setResponse(-1, "userId existed");
			} else if (userService.userCount(userEmail) > 0) {
				res.setResponse(-2, "userEmail existed");
			} else {
				res.setResponse(0, "userId Available");
			}
		} else {
			res.setResponse(400, "Bad Request");
		}
		logger.debug("+++++++++++++++++ 중복이메일체크 응답객체코드++++++++++++++++++++" + res.getCode());

		return res;
	}

	// 회원가입 insert
	@RequestMapping(value = "/user/signUpProc")
	@ResponseBody
	public Response<Object> signUpProc(HttpServletRequest request, HttpServletResponse response) {

		Response<Object> res = new Response<Object>();

		String userId = HttpUtil.get(request, "userId", "");
		String userPwd = HttpUtil.get(request, "userPwd", "");
		String userName = HttpUtil.get(request, "userName", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");

		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName)
				&& !StringUtil.isEmpty(userEmail)) {
			if (userService.userSelect(userId) == null) {
				User user = new User();
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setStatus("Y");

				if (userService.userInsert(user) > 0) {
					res.setResponse(0, "Sign Up Success");
				} else {
					res.setResponse(500, "Internal Server Error");
				}
			} else {
				res.setResponse(-1, "userId existed");
			}
		} else {
			res.setResponse(400, "Bad Request");
		}

		return res;
	}
	
	//Email 중복체크 ajax
	@RequestMapping(value="/user/emailChk")
	@ResponseBody
	public Response<Object> EmailChk(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userEmail = HttpUtil.get(request, "userEmail", "");
		User user = userService.userSelect(cookieUserId);
		
		//받아온 email과 쿠키아이디에 대한 email이 같은지 확인 후 다르다면 중복체크
		if(userEmail != null) {
			if(!StringUtil.equals(userEmail, user.getUserEmail())) {
				if(userService.userCount(userEmail) > 0) {
					res.setResponse(1, "Email Duplicated");
				}
				else {
					res.setResponse(0, "Available");
				}
			}
		}
		else {
			res.setResponse(400, "Bad Request");
		}
		
		return res;
	}

	// 비밀번호 찾기 ajax
	@RequestMapping(value = "/user/findPwdProc")
	@ResponseBody
	public Response<Object> findPwdProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();

		String findPwdKey = HttpUtil.get(request, "userEmail", "");

		if (!StringUtil.isEmpty(findPwdKey)) {

		} else {
			res.setResponse(400, "Bad Requset");
		}

		return res;
	}
	
	//회원정보수정 jsp
	@RequestMapping(value = "/user/update")
	public String userUpdate(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		logger.debug("===========================+++++++++++++++++++=======================");
		
		if(cookieUserId != null) {
//			user = userService.userSelect(cookieUserId);
//			
//			if(user != null) {
//				model.addAttribute("user", user);
//
//				UserFile userFile = new UserFile();
//				userFile.setUserId(user.getUserId());
//				
//				UserFile scUserFile = userService.userFileSelect(userFile);
//				
//				if(userFile != null) {
//					model.addAttribute("userFile", userFile);
//				}
//			}
			
			user = userService.userAllSelect(cookieUserId);
			
			model.addAttribute("user", user);
		}
		
		return "/user/update";
	}

	//회원 정보 수정 Proc
	@RequestMapping(value="/user/updateProc")
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId");
		String userName = HttpUtil.get(request, "userName", "");
		String userPwd = HttpUtil.get(request, "userPwd", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");
		String userPhone = HttpUtil.get(request, "userPhone", "");
		String userIntro = HttpUtil.get(request, "userIntro", "");
		
		FileData fileData = HttpUtil.getFile(request, "userFile", UPLOAD_SAVE_DIR);
		
		if(!StringUtil.isEmpty(cookieUserId)) {
			if(StringUtil.equals(userId, cookieUserId)) {
				if(!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userEmail)) {
					
					User user = userService.userSelect(cookieUserId);
					
					if(user != null) {
						user.setUserId(cookieUserId);
						user.setUserName(userName);
						user.setUserPwd(userPwd);
						user.setUserEmail(userEmail);
						user.setUserPhone(userPhone);
						user.setUserIntro(userIntro);
						
						if(fileData != null && fileData.getFileSize() > 0) {
							logger.debug("+++++++++++++++++fileData++++++++++++++++" + fileData.getFileName());
							UserFile userFile = new UserFile();
							
							userFile.setFileName(fileData.getFileName());
							userFile.setFileOrgName(fileData.getFileOrgName());
							userFile.setFileExt(fileData.getFileExt());
							userFile.setFileSize(fileData.getFileSize());
							
							user.setUserFile(userFile);
						}
						
						try {
							if(userService.userUpdate(user) > 0) {
								res.setResponse(200, "Success");
							}
							else {
								res.setResponse(500, "Internal Error");
							}					
						}
						catch(Exception e) {
							logger.error("[UserController] updateProc Exception -- ", e);
							res.setResponse(500, "Internal Server Error");
						}
						
					}
					else {
						res.setResponse(404, "Not found");
					}
				}
				else {
					res.setResponse(400, "Bad Requset");
				}
			}
			else {
				res.setResponse(420, "Unauthorized User Access");
			}
		}
		else {
			res.setResponse(410, "Login Error");
		}
		
		
		return res;
	}
	
	
	// 로그인 한 유저가 팔로잉 추가
	@RequestMapping(value="/user/followingProc")
	@ResponseBody
	public Response<Object> followingProc(HttpServletRequest request, HttpServletResponse response) {
		
		Response<Object> res = new Response<Object>();
		int result = 0;
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String followingId = HttpUtil.get(request, "followingId");
		
		if(!StringUtil.isEmpty(followingId) && !StringUtil.isEmpty(cookieUserId)) {
			User user = new User();
			
			user.setUserId(cookieUserId);
			user.setFollowingId(followingId);
			
			result = userService.followInsert(user);
			logger.debug("팔로잉 결과 -----" + result);
			
			if(result > 0) {
				res.setResponse(200, "Success");
			}
			else {
				res.setResponse(500, "Error");
			}
		}
		else {
			res.setResponse(500, "Error");
		}
		
		
		return res;
	}
	

	// 로그인 한 유저가 팔로잉 취소
	@RequestMapping(value="/user/followingCancelProc")
	@ResponseBody
	public Response<Object> followingCancelProc(HttpServletRequest request, HttpServletResponse response) {
		
		Response<Object> res = new Response<Object>();
		int result = 0;
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String followingId = HttpUtil.get(request, "followingId");
		
		if(!StringUtil.isEmpty(followingId) && !StringUtil.isEmpty(cookieUserId)) {
			User user = new User();
			
			user.setUserId(cookieUserId);
			user.setFollowingId(followingId);
			
			result = userService.followCancelDelete(user);
			logger.debug("팔로잉 취소 결과 -----" + result);
			
			if(result > 0) {
				res.setResponse(200, "Success");
			}
			else {
				res.setResponse(500, "Error");
			}
		}
		else {
			res.setResponse(500, "Error");
		}
		
		return res;
	}
	
	
	
	

}
