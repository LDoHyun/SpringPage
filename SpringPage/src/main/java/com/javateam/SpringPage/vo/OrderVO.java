package com.javateam.SpringPage.vo;
import java.util.Date;

import javax.validation.constraints.NotNull;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderVO {
	
	private int order_seq; 	  //pk(seq)
	private int pnum;		  //상품번호
	private String pname;	  //이름
	/*private String pkind;*/     //카테고리 (원두, 더치, 이벤트 등등)
	private int price;    	  //가격
	private int totprice;	  //여러 상품 가격
	private int totshipprice; //배송비 포함
	private String pfile;	  //사진
	/*private String country;*/   //원산지
	private String hardgrove; //원두 분쇄율
	private String capacity;  //용량
	private int pcount;		  //갯수
	
	//주문자정보
	private String username;
	
	//배송지정보
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
	
	// 상품 ->  상품목록 등록
	public OrderVO(ProductVO productVO) {
		this.pnum = productVO.getPnum();
		this.pname = productVO.getPname();
		this.pfile = productVO.getPfile();
		this.hardgrove = productVO.getHardgrove();
		this.capacity = productVO.getCapacity();
		this.pcount = productVO.getPcount();
		
	}
	
	/*public OrderVO(DeliverVO deliverVO) {
		this.pnum = deliverVO.getPnum();
		this.pname = deliverVO.getPname();
		this.pfile = deliverVO.getPfile();
		this.hardgrove = deliverVO.getHardgrove();
		this.capacity = deliverVO.getCapacity();
		this.pcount = deliverVO.getPcount();
		
		this.username = deliverVO.getUsername();
		this.name = deliverVO.getName();
		this.postcode = deliverVO.getPostcode();
		this.address = deliverVO.getAddress();
		this.address2 = deliverVO.getAddress2();
		this.phone = deliverVO.getPhone();
		this.phone2 = deliverVO.getPhone2();
		this.phone3 = deliverVO.getPhone3();
		this.email = deliverVO.getEmail();
		this.email2 = deliverVO.getEmail2();
		this.memo = deliverVO.getMemo();
	}*/
	
	public OrderVO(OrderVO orderVO) {
		this.order_seq = orderVO.getOrder_seq();
		this.pnum = orderVO.getPnum();
		this.pname = orderVO.getPname();
		this.totprice = orderVO.getTotprice();
		this.totshipprice = orderVO.getTotshipprice();
		this.pfile = orderVO.getPfile();
		this.hardgrove = orderVO.getHardgrove();
		this.capacity = orderVO.getCapacity();
		this.pcount = orderVO.getPcount();
		
		this.username = orderVO.getUsername();
		this.name = orderVO.getName();
		this.postcode = orderVO.getPostcode();
		this.address = orderVO.getAddress();
		this.address2 = orderVO.getAddress2();
		this.phone = orderVO.getPhone();
		this.phone2 = orderVO.getPhone2();
		this.phone3 = orderVO.getPhone3();
		this.email = orderVO.getEmail();
		this.email2 = orderVO.getEmail2();
		this.memo = orderVO.getMemo();
	}
}
