package com.javateam.SpringPage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.Role;
import com.javateam.SpringPage.vo.UserLogin;
import com.javateam.SpringPage.vo.UserUpdateVO;
import com.javateam.SpringPage.vo.UserVO;

public interface UserMapper {
	
	int hasUsername(String username);
	
	UserVO loadUserByUsername(String username);
	
	// 회원 목록
	List<UserVO> getAllUser();
	
	// 회원 목록 페이징
	List<UserVO> getAllUserByPagingVO(PagingVO pagingVO);
	/*PagingVO getPageInfo(int userNum, PagingVO pagingVO);*/
	
	// 회원정보 상세보기
	UserVO viewUser(@Param("username") String username);
	
	// 회원가입
	void insertUsers(String password, UserVO userVO, String role);
	void insertUsers(UserVO userVO);
	/*void insertUserLogin(String userlogin);*/
	void insertUserLogin(UserLogin userlogin);
	void insertUserRoles(@Param("username") String username, 
						 @Param("role") String role);
	
	UserVO getUserByUsername(String username);
	Role getUserRolesByUsername(String username);
	UserLogin getUserLoginByUsername(String username);
	
	//회원 아이디, 비밀번호 찾기
	String getIdByNameEmail(@Param("name") String name, 
						    @Param("email") String email);
	String getWordByNameEmail(@Param("username") String username,
							  @Param("name") String name, 
		    				  @Param("email") String email);
	
	// 회원정보 검색 코드
	List<UserVO> getUserByName(@Param("username") String username,
							   @Param("name") String name);
	
	// 회원정보 수정
	void updateUser(UserUpdateVO userUpdateVO);
	void updateUserLogin(@Param("username") String username,
					 	 @Param("password") String password);

	// 기존 회원정보 불러오기  
	UserVO selectUser(@Param("username")String username);
	
	// 회원 삭제
	void deleteUserLogin(@Param("username") String username);
	void deleteUserRoles(@Param("username") String username);
	void deleteUser(@Param("username") String username);
	
}
