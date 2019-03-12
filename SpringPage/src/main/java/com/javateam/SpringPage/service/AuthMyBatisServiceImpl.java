package com.javateam.SpringPage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javateam.SpringPage.service.deprecated.UserDAO;
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

import lombok.extern.slf4j.Slf4j;

/**
 * @author javateam
 *
 */
@Repository
@Slf4j
public class AuthMyBatisServiceImpl implements AuthMyBatisService {

	@Autowired
	private UserDAO userDAO;

	/**
	 * @see com.javateam.springSecuritySample1.service.AuthMyBatisService#hasUsername(java.lang.String)
	 */

	@Override
	public boolean hasUsername(String username) {

		log.info("hasUsername");

		return userDAO.hasUsername(username);
	} //

	/**
	 * @see com.javateam.springSecuritySample1.service.AuthMyBatisService#insertUsers(com.javateam.springSecuritySample1.vo.Users, java.lang.String)
	 */
	// 회원정보  입력
	@Override
	public void insertUsers(String password, UserVO userVO, String role) {

		log.info("######################## insertUsers #############################");

		userDAO.insertUsers(userVO);

		UserLogin userlogin = new UserLogin();

		userlogin.setPassword(password);
		userlogin.setUsername(userVO.getUsername());
		userlogin.setEnabled(1);

		log.info("1");
		
		userDAO.insertUserLogin(userlogin);

		log.info("2");
		
		userDAO.insertUserRoles(userVO.getUsername(), role);
		
		log.info("3");

	} //
	
	@Override
	public void insertUserLogin(UserLogin userlogin) {

		/*userDAO.insertUserLogin(userlogin);*/
	}
	
	@Override
	public void insertUserRoles(String username, String role) {

		/*userDAO.insertUserRoles(username, role);*/
	}

	@Override
	public void insertUserLogin(String userlogin) {

	}
	
	@Override
	public Role getUserRolesByUsername(String userName) {

		return userDAO.getUserRolesByUsername(userName);
	}

	@Override
	public UserLogin getUserLoginByUsername(String username) {

		return userDAO.getUserLoginByUsername(username);
	}
	
	// 아이디 찾기
	@Override
	public String getIdByNameEmail(String name, String email) {
		
		log.info("############# getIdByNameEmail ######################");
		
		return userDAO.getIdByNameEmail(name, email);
		
	}
	// 비밀번호 찾기
	@Override
	public String getWordByNameEmail(String username, String name, String email) {
		
		log.info("############# getWordByNameEmail ######################");
		
		return userDAO.getWordByNameEmail(username, name, email);
		
	}

	// 회원정보 수정
	@Override
	public void updateUser(UserUpdateVO userUpdateVO) {

		log.info("######################## updateUser #############################");

		userDAO.updateUser(userUpdateVO);

	}

	@Override
	public void updateUserLogin(String username, String password) {
		
		log.info("######################## updateUserLogin #############################");

		userDAO.updateUserLogin(username, password);
	}
	
	@Override
	public UserVO getUserByUsername(String username) {

		return userDAO.getUserByUsername(username);
	}
	
	// 기존 회원정보 불러오기  
	@Override
	public UserVO selectUser(String username) {

		return userDAO.selectUser(username);
	}
	
	// 회원 상세보기
	@Override
	public UserVO viewUser(String username) {
		
		return userDAO.viewUser(username);
	}
	
	// 회원 목록
	@Override
	public List<UserVO> getAllUser() {
		
		log.info("############# getAllUser ######################");  
		
		return userDAO.getAllUser();  
	}
	
	// 회원 목록 페이징
	@Override
	public List<UserVO> getAllUserByPagingVO(PagingVO pagingVO) {

		log.info("################# getAllUserByPagingVO ####################");
		
        return userDAO.getAllUserByPagingVO(pagingVO);
	}
	

	@Override
	public PagingVO getPageInfo(int userNum, PagingVO pagingVO) {
		
		// 페이징 관련 변수 설정
		pagingVO.setTotPage((int)((userNum-1)
	            / pagingVO.getRowPerPage()) + 1);
	       
        pagingVO.setEndPage((pagingVO.getTotPage() == 1) ?
                1 : pagingVO.getStartPage() +
                pagingVO.getTotPage() - 1); // 마지막 페이지
       
        pagingVO.setPrePage((pagingVO.getCurPage() <= 1) ?
                1 : pagingVO.getCurPage() - 1); // 이전 페이지
       
        pagingVO.setNextPage((pagingVO.getTotPage() == 1) ? 1 :
                     (pagingVO.getCurPage() >= pagingVO.getEndPage()) ?
                      pagingVO.getEndPage() : pagingVO.getCurPage() + 1); // 다음 페이지
       
        pagingVO.setCurPage((pagingVO.getCurPage() >= pagingVO.getEndPage()) ?
        		pagingVO.getEndPage() : pagingVO.getCurPage()); // 현재 페이지

        return pagingVO;
		//return userDAO.getPageInfo(userNum, pagingVO);
	}

	// 회원 정보 검색하기
	@Override
	public List<UserVO> getUserByName(String username, String name) {

		log.info("############# getUserByName ######################");  
		
		return userDAO.getUserByName(username, name);  
	}

	// 회원 삭제
	@Override
	public void deleteUser(String username) {
		
		log.info("######################## deleteUser #############################");

		userDAO.deleteUser(username);
	}
	
	@Override
	public void deleteUserLogin(String username) {
		
		log.info("######################## deleteUser #############################");

		userDAO.deleteUserLogin(username);
	}

	@Override
	public void deleteUserRoles(String username) {
		
		log.info("######################## deleteUser #############################");

		userDAO.deleteUserLogin(username);
	}

	/*-----------------------------------------------------------------*/
	// 게시판
	
	@Override
	public void writeBoard(BoardVO boardVO) {
		
		userDAO.writeBoard(boardVO);
	}

	@Override
	public BoardVO selectBoard(int boardNum) {

		return userDAO.selectBoard(boardNum);
	}

	@Override
	public int getListCount() {

		return userDAO.getListCount();
	}

	@Override
	public List<BoardVO> getArticleList(int page, int rowsPerPage) {

		return userDAO.getArticleList(page, rowsPerPage);
	}

	@Override
	public void updateReadCount(int boardNum) {

		userDAO.updateReadCount(boardNum);
	}

	@Override
	public boolean updateBoard(BoardVO boardVO) {

		return userDAO.updateBoard(boardVO);
	}

	@Override
	public boolean replyWriteBoard(BoardVO boardVO) {

		return userDAO.replyWriteBoard(boardVO);
	}

	@Override
	public void updateBoardByRefAndSeq(int boardReRef, int boardReSeq) {

		userDAO.updateBoardByRefAndSeq(boardReRef, boardReSeq);
	}

	/*------------------------------------------------------------*/


	@Override
	public List<NoticeVO> getNoticeList(int page, int rowsPerPage) {

		return userDAO.getNoticeList(page, rowsPerPage);
	}

	@Override
	public int getListNotice() {

		return userDAO.getListNotice();
	}

	@Override
	public void noticeReadCount(int boardNum) {

		userDAO.noticeReadCount(boardNum);
	}

	@Override
	public void writeNotice(NoticeVO noticeVO) {

		userDAO.writeNotice(noticeVO);
	}

	@Override
	public NoticeVO selectNotice(int boardNum) {

		return userDAO.selectNotice(boardNum);
	}

	@Override
	public boolean updateNotice(NoticeVO noticeVO) {

		return userDAO.updateNotice(noticeVO);
	}

	@Override
	public boolean replyWriteNotice(NoticeVO noticeVO) {

		return userDAO.replyWriteNotice(noticeVO);
	}

	@Override
	public void updateNoticeByRefAndSeq(int boardReRef, int boardReSeq) {

		userDAO.updateNoticeByRefAndSeq(boardReRef, boardReSeq);
	}

	/*---------------------------------------*/
	
	//상품 등록
	@Override
	public void insertProduct(ProductVO productVO) {

		log.info("############### insertProduct #############");
		
		userDAO.insertProduct(productVO);
	}
	
	//상품 상세보기
	@Override
	public ProductVO selectProduct(int pnum) {

		log.info("############## selectProduct ##############");
		
		return userDAO.selectProduct(pnum);
	}
	
	// 상품 수정
	@Override
	public void updateProduct(ProductVO productVO) {

		log.info("############# updateProduct #################");
		
		userDAO.updateProduct(productVO);
	}

	// 상품 삭제
	@Override
	public void deleteProduct(int pnum) {

		log.info("########### deleteProduct ##############");
		
		userDAO.deleteProduct(pnum);
	}

	// 상품 목록
	@Override
	public List<ProductVO> getAllProduct() {
		
		log.info("########### getAllProduct #############");
		
		return userDAO.getAllProduct();
	}
	
	// 상품 페이징
	@Override
	public List<ProductVO> getProductByPagingVO(PagingVO pagingVO) {

		log.info("############ getProductByPagingVO ############");
		
		return userDAO.getProductByPagingVO(pagingVO);
	}
	
	@Override
	public PagingVO getPageProduct(int pnum, PagingVO pagingVO) {
		// 페이징 관련 변수 설정
		pagingVO.setTotPage((int)((pnum-1)
	            / pagingVO.getRowPerPage()) + 1);
	       
        pagingVO.setEndPage((pagingVO.getTotPage() == 1) ?
                1 : pagingVO.getStartPage() +
                pagingVO.getTotPage() - 1); // 마지막 페이지
       
        pagingVO.setPrePage((pagingVO.getCurPage() <= 1) ?
                1 : pagingVO.getCurPage() - 1); // 이전 페이지
       
        pagingVO.setNextPage((pagingVO.getTotPage() == 1) ? 1 :
                     (pagingVO.getCurPage() >= pagingVO.getEndPage()) ?
                      pagingVO.getEndPage() : pagingVO.getCurPage() + 1); // 다음 페이지
       
        pagingVO.setCurPage((pagingVO.getCurPage() >= pagingVO.getEndPage()) ?
        		pagingVO.getEndPage() : pagingVO.getCurPage()); // 현재 페이지

        return pagingVO;
	}

	// 상품 검색
	@Override
	public List<ProductVO> getProductByName(String pname) {

		log.info("########### getProductByName #############");
		
		return userDAO.getProductByName(pname);
	}
	/*--------------------------------------------------*/
	@Override
	public void orderCoffee(OrderVO orderVO) {
		
		log.info("########### orderCoffee #############");
		
		userDAO.orderCoffee(orderVO);
	}

	@Override
	public void deleteCoffee(int pnum) {
		
		log.info("########### deleteCoffee #############");
		
		userDAO.deleteCoffee(pnum);
	}

	@Override
	public List<OrderVO> getAllCoffee() {
		
		log.info("########### getAllCoffee #############");
		
		return userDAO.getAllCoffee();
	}

	/*--------------------------------------------*/
	/*@Override
	public void insertWishList(WishListVO wishListVO) {

		userDAO.insertWishList(wishListVO);
	}

	@Override
	public void deleteWishList(int pnum) {

		userDAO.deleteWishList(pnum);
	}*/

	@Override
	public List<ProductVO> getAllCart() {

		return userDAO.getAllCart();
	}

	@Override
	public int hasProduct(int pnum, String capacity, String hardgrove, List<CartVO> list) {

		log.info("######### hasProduct ###########");
		
		CartVO cartVO = null;
		int result = -1;
		
		for(int i = 0; i < list.size(); i++) {
				
			cartVO = list.get(i);
			if (cartVO.getPnum() == pnum &&
				cartVO.getCapacity().equals(capacity) &&
				cartVO.getHardgrove().equals(hardgrove)) {
				result = i;
				break;
			} else {
				result = -1;
			}
		}
		return result;
	}

	@Override
	public int hasOrder(int pnum, String capacity, String hardgrove, List<OrderVO> list) {
		
		log.info("######### hasProduct ###########");
		
		OrderVO orderVO = null;
		int result = -1;
		
		for(int i = 0; i < list.size(); i++) {
				
			orderVO = list.get(i);
			// 추가된 부분 
			if (orderVO.getPnum() == pnum &&
				orderVO.getCapacity().equals(capacity) &&
				orderVO.getHardgrove().equals(hardgrove)) {
				
				result = i;
				break;
			} else {
				result = -1;
			}
		}
		return result;
	}

	


}
