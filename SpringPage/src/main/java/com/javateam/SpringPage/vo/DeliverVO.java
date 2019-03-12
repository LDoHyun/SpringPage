package com.javateam.SpringPage.vo;

import java.util.Date;

import javax.persistence.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeliverVO extends ProductVO{

	//배송정보
	private String username;
	private String name;
	private String postcode;
	private String address;
	private String address2;
	private String phone;
	private String phone2;
	private String phone3;
	private String email;
	private String email2;
	private String memo;
}
