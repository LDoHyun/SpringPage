package com.javateam.SpringPage.member;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
        "file:src/main/webapp/WEB-INF/spring/root-context.xml"
      })
@WebAppConfiguration // Spring 4.3.x 이후로는 필히 첨부 !
public class InsertTest {
	
	@Autowired
	private AuthMyBatisService svc;
	
	@Test
	public void test() {
		log.info("insertTest");
		log.info("#############################");
		UserVO userVO = new UserVO();
		
		userVO.setUsername("spring1234"); 
		userVO.setPasshint("hint05"); 
		userVO.setPassans("fdsfsd"); 
		userVO.setName("홍길동"); 
		userVO.setPostcode("06000"); 
		userVO.setAddress("서울 강남구 강남대로 708 (압구정동  한남대교레인보우카폐)"); 
		userVO.setAddress2("aad"); 
		userVO.setPhone("010"); 
		userVO.setPhone2("2134"); 
		userVO.setPhone3("8965"); 
		userVO.setEmail("fdsafg"); 
		userVO.setEmail2("nate.com"); 
		/*userVO.setBirthday("Mon Dec 03 00:00:00 KST 2018"); 
		userVO.setJoindate("null"); 
		userVO.setChemail("0"); 
		userVO.setChphone("0");*/
		log.info("1");
		//userVO.setBirthday(Date.valueOf(new SimpleDateFormat("yyyy-MM-dd").format("Mon Dec 03 00:00:00 KST 2018"))); 
		userVO.setBirthday(Date.valueOf("2000-11-11"));
		//userVO.setJoindate(null); 
		userVO.setChemail(0); 
		userVO.setChphone(0);
		// userVO: UserVO(username=spring1234, passhint=hint05, passans=fdsfsd, name=홍길동, postcode=06000, address=서울 강남구 강남대로 708 (압구정동, 한남대교레인보우카폐), address2=aad, phone=010, phone2=2134, phone3=8965, email=fdsafg, email2=nate.com, birthday=Mon Dec 03 00:00:00 KST 2018, joindate=null, chemail=0, chphone=0)
		log.info("################# userVO ####### : " + userVO.toString());
		
		String hashedPassword = ""; 
		BCryptPasswordEncoder passwordEncoder 
			= new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode("#abcd1234");

		log.info("################## hashedPassword ################# : "+hashedPassword);
		
		svc.insertUsers(hashedPassword, userVO, "ROLE_USER");
	}
	
}
