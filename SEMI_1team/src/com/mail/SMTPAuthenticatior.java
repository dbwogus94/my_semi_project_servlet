package com.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticatior extends Authenticator {
	 @Override
	    protected PasswordAuthentication getPasswordAuthentication() {
	        return new PasswordAuthentication("igs99275@naver.com","igs10261026");
	    }






}
