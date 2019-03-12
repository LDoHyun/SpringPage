package com.javateam.SpringPage.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class UserUpdateVO extends UserVO {
	
	@NotNull
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z]).{8,20}",
			 message="패스워드는 숫자, 영문자를 혼합하여 8~20자로 입력합니다.")
	private String password;
	
	@NotNull
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z]).{8,20}",
			 message="패스워드는 숫자, 영문자를 혼합하여 8~20자로 입력합니다.")
	private String password1;
	
	@NotNull
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z]).{8,20}",
			 message="패스워드는 숫자, 영문자를 혼합하여 8~20자로 입력합니다.")
	private String password2;
	
}
