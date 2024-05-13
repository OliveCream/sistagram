package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.web.dao.UserDao;
import com.sist.web.model.User;
import com.sist.web.model.UserFile;

@Service("userService")
public class UserService {
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	public User userSelect(String userId) {
		User user = null;
		
		try {
			user = userDao.userSelect(userId);
		}
		catch(Exception e) {
			logger.error("[UserService] userSelect Exception - ", e);
		}
		
		return user;
	}
	
	
	public int userCount(String login) {
		int cnt = 0;
		
		try {
			cnt = userDao.userCount(login);
		}
		catch(Exception e) {
			logger.error("[UserService] userCount Exception - ", e);
		}
		
		return cnt;
	}
	
	
	public int userInsert(User user) {
		int cnt = 0;
		
		try {
			cnt = userDao.userInsert(user);
		}
		catch(Exception e) {
			logger.error("[UserService] userInsert Exception - ", e);
		}
		
		return cnt;
	}
	
	//회원프로필파일 조회 select
	
	public UserFile userFileSelect(UserFile userFile) {
		UserFile userFileResult = null;
		
		try {
			userFileResult = userDao.userFileSelect(userFile);
		}catch(Exception e) {
			logger.error("[UserService] userFileSelect Exception - ", e);
		}
		
		return userFileResult;
	}
	
	//회원정보수정 update
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int userUpdate(User user) {
		int cnt = 0;
		
		
		
//		if(cnt > 0 && user.getUserFile() != null) {
//			UserFile userFile  = user.getUserFile();
//			
//			userFile.setUserId(user.getUserId());
//			userFile.setFileNum((long)1);
//			
//			//해당아이디의 프로필사진있으면 모두 삭제 후 등록
//			if(userDao.userFileSelect(userFile) != null) {
//				if(userDao.userFileDelete(user.getUserId()) > 0) {
//					//FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + userFile.getFileName());
//				}
//			}
//			
//			cnt += userDao.userFileInsert(userFile);
//		}
		
		if(user.getUserFile() != null) {
			
			UserFile userFile  = new UserFile();
			userFile.setUserId(user.getUserId());
			
			//해당아이디의 프로필사진있으면 모두 삭제 후 등록
			if(userDao.userFileSelect(userFile) != null) {
				if(userDao.userFileDelete(user.getUserId()) > 0) {
					FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + userFile.getFileName());
				}
			}
			
			userFile = user.getUserFile();
			userFile.setUserId(user.getUserId());
			userFile.setFileNum((long)1);
			
			
			cnt += userDao.userFileInsert(userFile);
		}
		
		cnt += userDao.userUpdate(user);

		
		return cnt;
	}
	
	
	/// 프로필 / 프로필 수정
	public User userAllSelect(String userId){
		User user = null;
		
		try {
			user = userDao.userAllSelect(userId);
		}catch(Exception e) {
			logger.error("[UserService] userAllSelect Exception - ", e);
		}
		
		return user;
	}
	
	//검색 - 회원 
	public List<User> userSearchSelect(User user){
		List<User> list = null;
		
		try {
			list = userDao.userSearchSelect(user);
		}catch(Exception e) {
			logger.error("[UserService] userSearchSelect Exception - ", e);
		}
		
		return list;		
	}
	
	//회원 추천 (팔로잉, 본인 제외)
	public List<User> recommendedMembers(String userId){
		List<User> list = null;
		
		try {
			list = userDao.recommendedMembers(userId);
		}catch(Exception e) {
			logger.error("[UserService] recommendedMembers Exception - ", e);
		}
		
		return list;
	}
	
	//유저의 팔로우 추가 insert
	public int followInsert(User user) {
		int result = 0;
		
		try {
			result = userDao.followInsert(user);
		}catch(Exception e) {
			logger.error("[UserService] followInsert Exception - ", e);
		}
		
		return result;
	}

	//유저의 팔로우 취소 delete
	public int followCancelDelete(User user) {
		int result = 0;
		
		try {
			result = userDao.followCancelDelete(user);
		}catch(Exception e) {
			logger.error("[UserService] followCancelDelete Exception - ", e);
		}
		
		return result;
	}
	
	//유저의 팔로잉 수 count
	public long followingCnt(String UserId) {
		
		long cnt = 0;
		
		try {
			cnt = userDao.followingCnt(UserId);
		}catch(Exception e) {
			logger.error("[UserService] followingCnt Exception - ", e);
		}
		
		return cnt;
	}
	
	
	//팔로잉 list 조회
	public List<User> followingList(String userId){
		List<User> followingList = null;
		
		try {
			followingList = userDao.followingList(userId);
		}catch(Exception e) {
			logger.error("[UserService] followingList Exception - ", e);
		}
		
		return followingList;
	}
	
	//팔로워 list 조회
	public List<User> followerList(String userId){
		List<User> followerList = null;
		
		try {
			followerList = userDao.followerList(userId);
		}catch(Exception e) {
			logger.error("[UserService] followerList Exception - ", e);
		}
		
		return followerList;
	}
	
}



