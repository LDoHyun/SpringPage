package com.javateam.SpringPage.service.deprecated;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import com.javateam.SpringPage.service.deprecated.CustomAuthenticationProvider;
import com.javateam.SpringPage.service.deprecated.UserDAO;
import com.javateam.SpringPage.vo.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Service("customAuthenticationProvider")
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

	/*@Autowired
	private AuthJdbcService authJdbcService;
	
	@Autowired
	private CustomUserService userService;*/
	
	@Autowired
	private UserDAO userDao;
    
    @Override
    public Authentication authenticate(Authentication authentication) 
    			throws AuthenticationException {
       
    	String username = authentication.getName();
        String password = (String) authentication.getCredentials();
        
        log.info("username : "+username);
        log.info("password : "+password);
 
       /* CustomUser user = new CustomUser();
        user.setFirstName("kb");
        user.setLastName("gc");
        user.setUsername("kb");
        user.setPassword("1234");
        Role r = new Role();
        r.setName("ROLE_USER");
        List<Role> roles = new ArrayList<Role>();
        roles.add(r);
        user.setAuthorities(roles);*/
       // CustomUser user = userService.loadUserByUsername(username);
        CustomUser user = userDao.loadUserByUsername(username);
       // CustomUser user = getUser(username);
        
        log.info("user : "+user);
 
        if (user == null || !user.getUsername().equalsIgnoreCase(username)) {
            throw new BadCredentialsException("Username not found.");
        }
 
        if (!password.equals(user.getPassword())) {
            throw new BadCredentialsException("Wrong password.");
        }
 
        Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
 
        return new UsernamePasswordAuthenticationToken(user, password, authorities);
    } //
 
    @Override
    public boolean supports(Class<?> arg0) {
        return true;
    } //

} //