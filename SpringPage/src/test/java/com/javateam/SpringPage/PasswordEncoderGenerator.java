package com.javateam.SpringPage;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordEncoderGenerator {
	
	@Test
	public void test() {
		
		log.info("test");
		
		String password = "@abcd1234";
		
		BCryptPasswordEncoder passwordEncorder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncorder.encode(password);
	
		log.info("hashedpassword : " + hashedPassword);
	}
}
