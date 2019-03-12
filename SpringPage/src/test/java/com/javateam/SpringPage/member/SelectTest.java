package com.javateam.SpringPage.member;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.javateam.SpringPage.mapper.UserMapper;
import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.service.deprecated.UserDAO;
import com.javateam.SpringPage.vo.UserLogin;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
        "file:src/main/webapp/WEB-INF/spring/root-context.xml"
      })
@WebAppConfiguration // Spring 4.3.x 이후로는 필히 첨부 !
public class SelectTest {
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		log.info("SelectTest");
		log.info("#############################");
		//UserLogin userLogin = userDAO.getUserLoginByUsername("servlet1112");
		UserLogin userLogin = sqlSession.getMapper(UserMapper.class).getUserLoginByUsername("servlet1113");
		//log.info("userLogin : " + userLogin.toString());
		log.info("password : " + userLogin.getPassword());
		
	}
	
}
