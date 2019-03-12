package com.javateam.SpringPage.db;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.service.deprecated.UserDAO;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
        "file:src/main/webapp/WEB-INF/spring/root-context.xml"
      })
@WebAppConfiguration // Spring 4.3.x 이후로는 필히 첨부 !
public class DbTest {
	
	@Autowired
	private AuthMyBatisService svc;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		
		log.info("########## MapperTest #################");
		
		/*for(PagingVO pagingVO: svc.getAllUserByPagingVO(pagingVO)) {
			log.info(pagingVO.toString());
		}
		
		UserDAO dao = sqlSession.getMapper(UserDao.class); 
		*/

		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setCurPage(1);
		pagingVO.setEndPage(1);
		pagingVO.setNextPage(0);
		pagingVO.setPrePage(0);
		pagingVO.setRowPerPage(10);
		pagingVO.setStartPage(1);
		pagingVO.setTotPage(0);
		
		log.info("############ pagingVO ####### : " + pagingVO.toString());
		//svc.insertUsers(hashedPassword, userVO, "ROLE_USER");
	}
	
	
}
