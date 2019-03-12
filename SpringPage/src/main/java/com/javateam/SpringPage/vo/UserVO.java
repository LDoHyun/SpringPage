package com.javateam.SpringPage.vo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.*;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
	
	@Id
	@Size(min=8, max=20, message="아이디는 영문자숫자 혼합 8~20자입니다")
	private String username;
	
	@NotNull
	private String passhint;
	
	@NotNull
	@Size(min=2, max=60, message="비밀번호 확인 질문의 답변을 입력하세요.")
	private String passans;
	
	@NotNull
	@Size(min=2, max=40, message="회원명은 2~20자입니다.")
	private String name;
	
	@NotNull
	private String postcode;
	
	@NotNull
	private String address;
	
	@Size(min=2, max=200, message="상세주소를 입력하세요.")
	@NotNull
	private String address2;
	
	@NotNull
	private String phone;
	
	@Size(min=3, max=4, message="중간번호를 입력하세요")
	@NotNull
	private String phone2;
	
	@Size(min=4, max=4, message="끝번호를 입력하세요")
	@NotNull
	private String phone3;
	
	@Size(min=2, max=30, message="이메일 아이디를 입력하세요")
	@NotNull
	private String email;
	
	@NotNull
	private String email2;
	
	@Past(message="생일은 금일 기준 이전 일이 들어가야 합니다")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
	@NotNull
	private Date birthday;
	
	private Date joindate;
	
	private int chemail; 
	
	private int chphone;

	/*public Users(String username, String password, int enabled) {
		this.username = username;
		this.password = password;
		this.enabled = enabled;
	}*/
	
	/*public Users(String username, String password, String password_hint, String password_ans,
			String name, String postcode, String address, String address2, String phone,
			String email, Date birthday, Date joindate, int check_email, int check_phone, int enabled) {
		this.username = username;
		this.password = password;
		this.password_hint = password_hint;
		this.password_ans = password_ans;
		this.name = name;
		this.postcode = postcode;
		this.address = address;
		this.address2 = address2;
		this.phone = phone;
		this.email = email;
		this.birthday = birthday;
		this.joindate = joindate;
		this.check_email = check_email;
		this.check_phone = check_phone;
		this.enabled = enabled;
	}*/
	
}