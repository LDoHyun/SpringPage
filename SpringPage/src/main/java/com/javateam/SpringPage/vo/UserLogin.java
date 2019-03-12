package com.javateam.SpringPage.vo;

import javax.validation.constraints.*;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserLogin {
	
	private String username;
	
	@NotNull
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z]).{8,20}",
			 message="패스워드는 숫자, 영문자를 혼합하여 8~20자로 입력합니다.")
	private String password;
	
	private int enabled;

}
