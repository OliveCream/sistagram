//package com.sist.web.service;
//
//import javax.mail.MessagingException;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.stereotype.Service;
//
//import com.sist.web.model.Email;
//
//@Service
//public class EmailSender {
//	
//	private static Logger logger = LoggerFactory.getLogger(UserService.class);
//	
//	@Autowired
//	private JavaMailSender mailSender;	//xml에 추가해야 import가능하다
//	
//	
//	public String sendMail(Email email) {
//		
//		try {
//			MimeMessage msg = mailSender.createMimeMessage();
//			
//			msg.setSubject(email.getSubject());
//			msg.setText(email.getContent());
//			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email.getReceiver()));
//		}
//		catch(MessagingException e) {
//			System.out.println("++++++++++++++++++++++++++++++++++");
//			logger.error("[Service] EmailSender MessagingExeption --- ", e);
//		}
//		
//		return "";
//	}
//	
//	
//	
//}

