package com.javateam.SpringPage.service.deprecated;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component("userService")
@Slf4j
public class CustomUserService implements UserDetailsService{
	
	@Autowired
	private UserDAO userDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.info("CustomService : loadUserByUsername");
		return userDao.loadUserByUsername(username);
	}
}
