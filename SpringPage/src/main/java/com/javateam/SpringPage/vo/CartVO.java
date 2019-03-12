package com.javateam.SpringPage.vo;


import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartVO {
	
	private int pnum;		  //상품번호
	private String pname;	  //이름
	private String pkind;     //카테고리 (원두, 더치, 이벤트 등등)
	private int price;     	  //가격
	private String pfile;	  //사진
	private String country;   //원산지
	private String hardgrove; //원두 분쇄율
	private String capacity;  //용량
	private int pcount;		  //갯수
	
	// 상품 ->  장바구니 등록
	public CartVO(ProductVO productVO) {
		this.pnum = productVO.getPnum();
		this.pname = productVO.getPname();
		this.pkind = productVO.getPkind();
		this.price = productVO.getPrice();
		this.pfile = productVO.getPfile();
		this.country = productVO.getCountry();
		this.hardgrove = productVO.getHardgrove();
		this.capacity = productVO.getCapacity();
		this.pcount = productVO.getPcount();
	}
	
	public CartVO(CartVO cartVO) {
		this.pnum = cartVO.getPnum();
		this.pname = cartVO.getPname();
		this.pkind = cartVO.getPkind();
		this.price = cartVO.getPrice();
		this.pfile = cartVO.getPfile();
		this.country = cartVO.getCountry();
		this.hardgrove = cartVO.getHardgrove();
		this.capacity = cartVO.getCapacity();
		this.pcount = cartVO.getPcount();
	}

}
