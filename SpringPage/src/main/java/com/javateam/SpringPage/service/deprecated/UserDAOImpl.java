package com.javateam.SpringPage.service.deprecated;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javateam.SpringPage.mapper.BoardMapper;
import com.javateam.SpringPage.mapper.ProductMapper;
import com.javateam.SpringPage.mapper.UserMapper;
import com.javateam.SpringPage.vo.BoardVO;
import com.javateam.SpringPage.vo.CustomUser;
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

import lombok.extern.java.Log;

@Repository("userDao")
@Log
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public CustomUser loadUserByUsername(String username) {

		log.info("loadUserByUsername : " + username);

		CustomUser user = new CustomUser();
		user.setUsername("kb");
		user.setPassword("1234");
		Role r = new Role();
		r.setUsername("ROLE_USER");
		List<Role> roles = new ArrayList<Role>();
		roles.add(r);
		user.setAuthorities(roles);

		return user;
	}
	/**
	 * @see com.javateam.springSecuritySample1.service.AuthMyBatisService#hasUsername(java.lang.String)
	 */

	@Override
	public boolean hasUsername(String username) {

		log.info("hasUsername");

		return sqlSession.getMapper(UserMapper.class)
				.hasUsername(username) == 1 ? true : false;
	} //

	/**
	 * @see com.javateam.springSecuritySample1.service.AuthMyBatisService#insertUsers(com.javateam.springSecuritySample1.vo.Users, java.lang.String)
	 */
	// 회원정보  입력
	@Override
	public void insertUsers(String password, UserVO userVO, String role) {
		
		log.info("######################## insertUsers #############################");
		
		sqlSession.getMapper(UserMapper.class)
		.insertUsers(userVO);

		UserLogin userlogin = new UserLogin();

		userlogin.setPassword(password);
		userlogin.setUsername(userVO.getUsername());
		userlogin.setEnabled(1);

		sqlSession.getMapper(UserMapper.class)
		.insertUserLogin(userlogin);
		
		sqlSession.getMapper(UserMapper.class)
		.insertUserRoles(userVO.getUsername(), role);
		
		sqlSession.getMapper(UserMapper.class)
		.insertUsers(password, userVO, role);

	} //
	
	@Override
	public void insertUsers(UserVO userVO) {
		
		log.info("######################## insertUsers #############################");

		sqlSession.getMapper(UserMapper.class)
				  .insertUsers(userVO);

	}
	
	@Override
	public void insertUserRoles(String username, String role) {
		
		log.info("######################## insertUserRoles #############################");
		
		sqlSession.getMapper(UserMapper.class)
				  .insertUserRoles(username, role);
	}

	@Override
	public void insertUserLogin(UserLogin userlogin) {
		
		log.info("######################## insertUserLogin #########################");
		
		sqlSession.getMapper(UserMapper.class)
				  .insertUserLogin(userlogin);
	}
	
	@Override
	public void insertUserLogin(String userlogin) {
		
		log.info("############ insertUserLogin(String userlogin) ################");
		
		/*sqlSession.getMapper(UserMapper.class)
				  .insertUserLogin(userlogin);*/
	}
	
	// 회원 아이디 찾기
	@Override
	public String getIdByNameEmail(String name, String email) {

		log.info("############## getIdByNameEmail ###################");
		
		return sqlSession.getMapper(UserMapper.class)
		.getIdByNameEmail(name, email);
	}
	
	// 회원 비밀번호 찾기
	@Override
	public String getWordByNameEmail(String username, String name, String email) {
		
		log.info("################# getWordByNameEmail ####################");
		
		return sqlSession.getMapper(UserMapper.class)
		.getWordByNameEmail(username, name, email);
	}
	
	// 회원정보 수정
	@Override
	public void updateUser(UserUpdateVO userUpdateVO) {

		log.info("######################## updateUser #############################");

		sqlSession.getMapper(UserMapper.class).updateUser(userUpdateVO);
	}
	
	@Override
	public void updateUserLogin(String username, String password) {
		
		log.info("######################## updateUser #############################");

		sqlSession.getMapper(UserMapper.class).updateUserLogin(username, password);
		
	}
	
	@Override
	public UserVO getUserByUsername(String username) {

		return sqlSession.getMapper(UserMapper.class)
				.getUserByUsername(username);
	}

	// 기존 회원정보 불러오기
	@Override
	public UserVO selectUser(String username) {

		return sqlSession.getMapper(UserMapper.class)
		.selectUser(username);
	}
	
	// 회원 상세보기
	@Override
	public UserVO viewUser(String username) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(UserMapper.class)
				.viewUser(username);
	}
	
	// 회원 목록
	@Override
	public List<UserVO> getAllUser() {

		log.info("############ getAllUser ############");
		
		return sqlSession.getMapper(UserMapper.class).getAllUser();
	}
	
	// 회원 목록 페이징
	@Override
	public List<UserVO> getAllUserByPagingVO(PagingVO pagingVO) {

		log.info("############ getAllUser ###############");
		
		return sqlSession.getMapper(UserMapper.class)
				.getAllUserByPagingVO(pagingVO);
	}
	
	// 회원정보 검색
	@Override
	public List<UserVO> getUserByName(String username, String name) {

		log.info("######################## getAllBoard #############################");
		
		return  sqlSession.getMapper(UserMapper.class)
				.getUserByName(username, name);
	}
	
	//회원정보 삭제
	@Override
	public void deleteUser(String username) {
		
		log.info("######################## deleteUser #############################");
/*
		sqlSession.getMapper(UserMapper.class)
		.updateUser(userVO);

		UserLogin userlogin = new UserLogin();

		userlogin.setPassword(password);
		userlogin.setUsername(userVO.getUsername());
		userlogin.setEnabled(1);

		sqlSession.getMapper(UserMapper.class)
		.updateUserLogin(userlogin);

		sqlSession.getMapper(UserMapper.class)
		.updateUserRoles(userVO.getUsername(), role);*/
		
		sqlSession.getMapper(UserMapper.class)
				.deleteUser(username);
	}

	@Override
	public void deleteUserLogin(String username) {
		
		sqlSession.getMapper(UserMapper.class)
				  .deleteUserLogin(username);
	}
	
	@Override
	public void deleteUserRoles(String username) {
		
		sqlSession.getMapper(UserMapper.class)
				  .deleteUserRoles(username);
	}
	
	@Override
	public Role getUserRolesByUsername(String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserLogin getUserLoginByUsername(String username) {

		UserLogin userLogin = sqlSession.getMapper(UserMapper.class).getUserLoginByUsername(username);
		
		log.info("#################### DAO password : " + userLogin.getPassword());
		return userLogin;
	}
	
	/*-----------------------------------------------------------------*/
	
	@Override
	public void writeBoard(BoardVO boardVO) {

		sqlSession.getMapper(BoardMapper.class).writeBoard(boardVO);
	}
	
	@Override
	public BoardVO selectBoard(int boardNum) {

		return sqlSession.getMapper(BoardMapper.class).selectBoard(boardNum);
	}
	
	@Override
	public List<BoardVO> getArticleList(int page, int rowsPerPage) {

		return sqlSession.getMapper(BoardMapper.class).getArticleList(page, rowsPerPage);
	}
	
	@Override
	public int getListCount() {

		return sqlSession.getMapper(BoardMapper.class).getListCount();
	}
	
	@Override
	public void updateReadCount(int boardNum) {

		sqlSession.getMapper(BoardMapper.class).updateReadCount(boardNum);
	}
	
	@Override
	public boolean updateBoard(BoardVO boardVO) {
		
		log.info("dao updateBoard");
		boolean flag = false;
		
		try {
			sqlSession.getMapper(BoardMapper.class).updateBoard(boardVO);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return flag;
	}
	
	@Override
	public boolean replyWriteBoard(BoardVO boardVO) {
		
		log.info("dao replyWriteBoard");
		boolean flag = false; 
		
		try {
			sqlSession.getMapper(BoardMapper.class).replyWriteBoard(boardVO);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	
	@Override
	public void updateBoardByRefAndSeq(int boardReRef, int boardReSeq) {
		
		sqlSession.getMapper(BoardMapper.class)
				  .updateBoardByRefAndSeq(boardReRef, boardReSeq);
	}
	
	/*-----------------------------------------------*/
	
	@Override
	public List<NoticeVO> getNoticeList(int page, int rowsPerPage) {

		return sqlSession.getMapper(BoardMapper.class)
						 .getNoticeList(page, rowsPerPage);
	}
	@Override
	public int getListNotice() {

		return sqlSession.getMapper(BoardMapper.class)
						 .getListNotice();
	}
	@Override
	public void noticeReadCount(int boardNum) {

		sqlSession.getMapper(BoardMapper.class)
				  .noticeReadCount(boardNum);
	}
	
	@Override
	public void writeNotice(NoticeVO noticeVO) {

		sqlSession.getMapper(BoardMapper.class)
				  .writeNotice(noticeVO);
	}
	
	@Override
	public NoticeVO selectNotice(int boardNum) {

		return sqlSession.getMapper(BoardMapper.class)
						 .selectNotice(boardNum);
	}
	
	@Override
	public boolean updateNotice(NoticeVO noticeVO) {

		return sqlSession.getMapper(BoardMapper.class)
						 .updateNotice(noticeVO);
	}
	
	@Override
	public boolean replyWriteNotice(NoticeVO noticeVO) {

		return sqlSession.getMapper(BoardMapper.class)
						 .replyWriteNotice(noticeVO);
	}
	
	@Override
	public void updateNoticeByRefAndSeq(int boardReRef, int boardReSeq) {
		
		sqlSession.getMapper(BoardMapper.class)
				  .updateNoticeByRefAndSeq(boardReRef, boardReSeq);
	}
	/*--------------------------------------------*/
	
	// 상품 등록
	@Override
	public void insertProduct(ProductVO productVO) {

		sqlSession.getMapper(ProductMapper.class)
				  .insertProduct(productVO);
		
	}
	
	// 상품 상세보기
	@Override
	public ProductVO selectProduct(int pnum) {

		return sqlSession.getMapper(ProductMapper.class)
						 .selectProduct(pnum);
	}
	
	// 상품 수정
	@Override
	public void updateProduct(ProductVO productVO) {

		sqlSession.getMapper(ProductMapper.class)
				  .updateProduct(productVO);
	}
	
	// 상품 삭제
	@Override
	public void deleteProduct(int pnum) {

		sqlSession.getMapper(ProductMapper.class)
				  .deleteProduct(pnum);
	}
	
	// 상품 목록
	@Override
	public List<ProductVO> getAllProduct() {

		return sqlSession.getMapper(ProductMapper.class)
						 .getAllProduct();
	}
	
	// 상품목록 페이징
	@Override
	public List<ProductVO> getProductByPagingVO(PagingVO pagingVO) {

		return sqlSession.getMapper(ProductMapper.class)
						 .getProductByPagingVO(pagingVO);
	}
	
	// 상품 검색
	@Override
	public List<ProductVO> getProductByName(String pname) {

		return sqlSession.getMapper(ProductMapper.class)
						 .getProductByName(pname);
	}
	/*--------------------------------------------------*/
	@Override
	public void orderCoffee(OrderVO orderVO) {
		sqlSession.getMapper(ProductMapper.class)
		 .orderCoffee(orderVO);
	}
	
	@Override
	public void deleteCoffee(int pnum) {
		sqlSession.getMapper(ProductMapper.class)
		 .deleteCoffee(pnum);
	}
	
	@Override
	public List<OrderVO> getAllCoffee() {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(ProductMapper.class)
				 			.getAllCoffee();
	}
	
	/*----------------------------------------------*/
	/*@Override
	public void insertWishList(WishListVO wishListVO) {

		sqlSession.getMapper(ProductMapper.class)
				  .insertWishList(wishListVO);
	}
	
	@Override
	public void deleteWishList(int pnum) {

		sqlSession.getMapper(ProductMapper.class)
				  .deleteWishList(pnum);
	}*/
	
	@Override
	public List<ProductVO> getAllCart() {

		return sqlSession.getMapper(ProductMapper.class).getAllCart();
	}
	

} //