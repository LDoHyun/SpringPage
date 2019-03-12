package com.javateam.SpringPage.vo;


import java.util.List;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVO {
	
	@NotNull
	private int pnum;	    //상품번호
	
	@NotNull
	@Size(min=2, max=40, 
	  	  message="상품이름은 2-20자로 작성하세요.")
	private String pname;   //이름
	
	@NotNull
	private String pkind;   //카테고리 (원두, 더치, 이벤트 등등)
	
	@NotNull
	private int price;   //가격

	@NotNull
	private String pfile;	//사진
	
	@NotNull
	@Size(min=2, max=20, 
	  	  message="원산지는 2-10자로 작성하세요.")
	private String country; //원산지
	
	private String hardgrove; //원두 분쇄율
	
	private String capacity;  //용량
	
	private int pcount;		  //갯수
	
}
