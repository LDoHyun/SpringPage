package com.javateam.SpringPage;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.OrderVO;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("secured")  
@Controller
@Slf4j
public class ProductSecuredController2 {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private AuthMyBatisService svc;

	// 커피 구매 폼
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/coffee/orderOneAction", method= {RequestMethod.POST,RequestMethod.GET})
	public String orderOneAction( OrderVO orderVO,
								  HttpServletRequest request, 
								  Model model,
								  HttpSession session ) {
		
		log.info("############# 개별 상품 주문처리 ######");
		
		List<OrderVO> orderList = new ArrayList<>();
		log.info(orderVO.toString());
		
		int price = orderVO.getPrice();
		int pcount = orderVO.getPcount();
		int pnum = orderVO.getPnum();
		String capacity = orderVO.getCapacity();
		String hardgrove = orderVO.getHardgrove();
		String username = request.getUserPrincipal().getName();
		
		// 기존 주문목록 가져오기
		// 세션 미생성 시
		if(session.getAttribute("orders") != null) {
			orderList = (List<OrderVO>)session.getAttribute("orders"); // 기존 세션(주문 목록)
		} 
		
		log.info("주문목록 갯수: " + orderList.size());
		
		int idx = -1; // index
		idx = svc.hasOrder(pnum, capacity, hardgrove, orderList);
			
		if(idx != -1) {
			
			log.info("######### 동일상품 있을 때");
			
			OrderVO legacyOrderVO = orderList.get(idx);
			
			// 기존 주문량 + 신규 주문량
			orderVO.setPcount(legacyOrderVO.getPcount() + pcount);
			orderVO.setTotprice(price * pcount);
			orderVO.setTotshipprice(price * pcount + orderVO.getTotshipprice());
			
			orderList.remove(idx);
			orderList.add(orderVO);
			
		} else { // 동일상품이 없을 때
			
			log.info("######### 동일상품 없을 때");
		
			orderVO.setTotprice(price * pcount);
			orderVO.setTotshipprice(price * pcount + orderVO.getTotshipprice());
			
			// 배송 정보
			orderVO.setUsername(username);
			orderList.add(orderVO);

		} // if(idx)
		
		UserVO userVO = svc.getUserByUsername(username);
		model.addAttribute("userVO", userVO);
		
		log.info("주문처리 : " + orderVO.toString());
		log.info("주문목록 갯수 : " + orderList.size());
		
		// 세션 미생성 시
		if(session.getAttribute("orders") == null) {
			
			session.setAttribute("orders", orderList);
			
		} else { // 기존 세션 존재 시
			
			session.setAttribute("orders", orderList);
		}
		
		log.info("상품결제  : " + orderVO.toString());
		log.info("상품결제  : " + userVO.toString());
		
		log.info("################ 주문목록 갯수: " + orderList.size());
		
		return "/secured/coffee/orderForm";
	}
	
} //