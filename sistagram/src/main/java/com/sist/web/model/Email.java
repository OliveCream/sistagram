package com.sist.web.model;

import java.io.Serializable;

public class Email implements Serializable {

	private static final long serialVersionUID = 1L;

	private String subject;
	private String content;
	private String receiver;
	
	public Email() {
		subject = "";
		content = "";
		receiver = "";
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	
	
	
}
