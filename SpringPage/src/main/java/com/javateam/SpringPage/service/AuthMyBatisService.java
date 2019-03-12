package com.javateam.SpringPage.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.javateam.SpringPage.vo.BoardVO;
import com.javateam.SpringPage.vo.NoticeVO;
import com.javateam.SpringPage.vo.OrderVO;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.ProductVO;
import com.javateam.SpringPage.vo.Role;
import com.javateam.SpringPage.vo.UserLogin;
import com.javateam.SpringPage.vo.UserUpdateVO;
import com.javateam.SpringPage.vo.UserVO;
import com.javateam.SpringPage.vo.WishListVO;
import com.javateam.SpringPage.vo.CartVO;

public interface AuthMyBatisService {
	
	boolean hasUsername(String username);
	
	UserVO getUserByUsername(String username);
	Role getUserRolesByUsername(String username);
	UserLogin getUserLoginByUsername(String username);
	
	
	// 회원 목록 페이징
	List<UserVO> getAllUser();
	List<UserVO> getAllUserByPagingVO(PagingVO pagingVO);
	// 페이징 관련 변수 설정
	PagingVO getPageInfo(int userNum, PagingVO pagingVO);
	
	// 회원정보 검색
	List<UserVO> getUserByName(String username, String name);
	
	// 회원정보 상세보기
	UserVO viewUser(String username);
	
	// 회원정보  입력
	void insertUsers(String password, UserVO userVO, String role);
	void insertUserLogin(String userlogin);
	void insertUserLogin(UserLogin userlogin); //로그인 입력
	void insertUserRoles(String username,  String role); //회원 권한
	
	//회원 아이디, 비밀번호 찾기
	String getIdByNameEmail(String name, String email);
	String getWordByNameEmail(String username, String name, String email);
	
	// 회원정보 수정
	void updateUser(UserUpdateVO userUpdateVO);
	void updateUserLogin(String username, String password);
	
	// 기존 회원정보 불러오기  
	UserVO selectUser(String username);
	
	// 회원 삭제
	/*void deleteUsers(UserVO userVO, UserLogin userlogin, Role role);*/
	void deleteUser(String username);
	void deleteUserLogin(String username);
	void deleteUserRoles(String username); //회원 권한
	
	/*---------------------------------------------------------------*/
	
	void writeBoard(BoardVO boardVO);
	
	BoardVO selectBoard(int boardNum);
	
	int getListCount();
	
	List<BoardVO> getArticleList(int page, int rowsPerPage);
	
	void updateReadCount(int boardNum);
	
	boolean updateBoard(BoardVO boardVO);
	
	boolean replyWriteBoard(BoardVO boardVO);
	
	void updateBoardByRefAndSeq(int boardReRef, int boardReSeq);
	
	/*---------------------------------------------------------------*/
	
	List<NoticeVO> getNoticeList(int page, int rowsPerPage);
	
	int getListNotice();
	
	void noticeReadCount(int boardNum);

	void writeNotice(NoticeVO noticeVO);
	
	NoticeVO selectNotice(int boardNum);
	
	boolean updateNotice(NoticeVO noticeVO);
	
	boolean replyWriteNotice(NoticeVO noticeVO);
	
	void updateNoticeByRefAndSeq(int boardReRef, int boardReSeq);
	
	/*---------------------------------------------------------------*/
	// 상품등록
	void insertProduct(ProductVO productVO);
	// 상품 상세보기
	ProductVO selectProduct(int pnum);
	// 상품수정
	void updateProduct(ProductVO productVO);
	// 상품삭제
	void deleteProduct(int pnum);
	// 상품 전체 목록
	List<ProductVO> getAllProduct();
	// 상품 목록 페이징
	List<ProductVO> getProductByPagingVO(PagingVO pagingVO);
	// 페이징 관련 변수 설정
	PagingVO getPageProduct(int pnum, PagingVO pagingVO);
	// 상품 검색
	List<ProductVO> getProductByName(String pname);
	
	/*-------------------------------------------------------*/
	// 구입 상품
	void orderCoffee(OrderVO orderVO);
	// 구입 상품 삭제
	void deleteCoffee(int pnum);
	// 구입 목록
	List<OrderVO> getAllCoffee();
	
	/*
	// 관심상품 등록
	void insertWishList(WishListVO wishListVO);
	// 관심상품 삭제
	void deleteWishList(int pnum);
	*/
	// 장바구니
	List<ProductVO> getAllCart();
	
	//장바구니내 동일 상품 여부 검색
	// 동일 상품이 없을 때 -1, 있을 때 list::index
	int hasProduct(int pnum, String capacity, String hardgrove, List<CartVO> list);

	// 주문목록내 동일 상품 여부 검색
	// 동일 상품이 없을 때 -1, 있을 때 list::index 
	// 추가한 부분
	int hasOrder(int pnum, String capacity, String hardgrove, List<OrderVO> list);

}
