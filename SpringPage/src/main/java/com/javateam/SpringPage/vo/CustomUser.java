package com.javateam.SpringPage.vo;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class CustomUser implements UserDetails {

	private static final long serialVersionUID = 1L;
	
	private String username;
	private String password;
	
	private List<Role> authorities;
	private boolean accountNonExpired = true;
	private boolean accountNonLocked = true;
	private boolean credentialsNonExpired = true;
	private boolean enabled = true;
	
	public CustomUser(UserLogin userLogin) {
		this.username = userLogin.getUsername();
		this.password = userLogin.getPassword();
		this.enabled = userLogin.getEnabled() == 1 ? true : false;
	}
	
}
