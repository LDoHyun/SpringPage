package com.javateam.SpringPage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.javateam.SpringPage.vo.BoardVO;
import com.javateam.SpringPage.vo.OrderVO;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.ProductVO;
import com.javateam.SpringPage.vo.UserVO;
import com.javateam.SpringPage.vo.WishListVO;
import com.javateam.SpringPage.vo.CartVO;

public interface ProductMapper {
	
	// 상품등록
	void insertProduct(ProductVO productVO);
	// 상품 상세보기
	ProductVO selectProduct(@Param("pnum") int pnum);
	// 상품수정
	void updateProduct(@Param("product") ProductVO productVO);
	// 상품삭제
	void deleteProduct(@Param("pnum") int pnum);
	// 상품 전체 목록
	List<ProductVO> getAllProduct();
	// 상품 목록 페이징
	List<ProductVO> getProductByPagingVO(PagingVO pagingVO);
	// 상품 검색
	List<ProductVO> getProductByName(@Param("pname") String pname);
	
	/*------------------------------------------*/
	// 상품 주문
	void orderCoffee(OrderVO orderVO);
	// 상품 주문 취소
	void deleteCoffee(@Param("pnum") int pnum);
	// 구매상품 목록
	List<OrderVO> getAllCoffee();
	
	/*------------------------------------------*/
	/*
	// 관심상품 등록
	void insertWishList(WishListVO wishListVO);
	// 관심상품 삭제
	void deleteWishList(@Param("pnum") int pnum);
	*/
	// 장바구니
	List<ProductVO> getAllCart();
	
	
}
