package com.javateam.SpringPage;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.OrderVO;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("secured")  
@Controller
@Slf4j
public class ProductSecuredController3 {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private AuthMyBatisService svc;
	
	// 커피 구매 폼
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/coffee/orderAction", method= {RequestMethod.POST,RequestMethod.GET})
	public String orderAction2( HttpServletRequest request, 
							    Model model,
							    HttpSession session) {
		
		log.info("############# 주문처리 ######");
		Enumeration<String> params = request.getParameterNames();
		
		// 상품 갯수
		int pcountSize = request.getParameter("pcount_size") == null ? 0 
					   : new Integer(request.getParameter("pcount_size"));
			
		int pnum[] = new int[pcountSize];
		
		String temp = null;
		int cnt = 0;
		
		while(params.hasMoreElements()) {
			 temp = params.nextElement();
			if(temp.contains("pnum_")) {
				temp = temp.substring(5);
				pnum[cnt] = new Integer(temp);
				cnt++;
			}
		}
		
		List<OrderVO> orderList = new ArrayList<>();
		
		OrderVO orderVO = null;
		String username = request.getUserPrincipal().getName();
		
		int price = 0;
		int pcount = 0;
		int totshipprice = 0;
		String capacity = "";
		String hardgrove = "";
		
		// 기존 주문 목록 가져오기
		// 세션 미생성 시
		if(session.getAttribute("orders") != null) {
			orderList = (List<OrderVO>)session.getAttribute("orders"); // 기존 세션(주문 목록)
		} 
		
		// 기존 목록 세션 현황
		log.info("-------------------------------------------------------");
		orderList.forEach(x->{ log.info("{} 상품의 기존 재고 현황 : {}", x.getPname(), x.getPcount());});
		log.info("-------------------------------------------------------");
		
		int newPcount = 0; // 변경 수량
		int idxArr[] = new int[pcountSize];
		
		// 동일상품 여부
		// 동일상품일 경우
		if(pcountSize > 1) {
			
			for (int k = 0; k < pcountSize; k++) {
				
				capacity = request.getParameter("goodscapacity_"+pnum[k]);
				hardgrove = request.getParameter("goodshardgrove_"+pnum[k]);
				
				idxArr[k] = svc.hasOrder(pnum[k], capacity, hardgrove, orderList);
				
				log.info("#### idxArr[k] : "+ idxArr[k]);
			}
			
		} else {
			
			capacity = request.getParameter("goodscapacity_"+pnum[0]);
			hardgrove = request.getParameter("goodshardgrove_"+pnum[0]);
			idxArr[0] = svc.hasOrder(new Integer(pnum[0]), capacity, hardgrove, orderList);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////
		
		// for loop
		for (int i = 0; i < idxArr.length; i++ ) {
			
			if(idxArr[i] != -1) {
				
				log.info("######### 동일상품 있을 때");
				log.info("######## idxArr[i] : "+idxArr[i]);
				
				orderVO = orderList.get(idxArr[i]); // 문제되는 곳 !
				
				pcount = new Integer(request.getParameter("pcount_" + pnum[i]));
				
				log.info("{} 기존 수량 : {}", orderVO.getPname(), pcount);
				
				// 기존 주문량 + 신규 주문량
				if(request.getParameter("pcount_"+ pnum[i]) != null) {
					
					log.info("############## 1 : " + pnum[i]);
					
					log.info("###### 기존 수량 : orderVO.getPcount() : "+orderVO.getPcount());
					log.info("###### 유입 수량(인자) : pcount : "+pcount);
					
					newPcount = orderVO.getPcount() + pcount;
					orderVO.setPcount(newPcount);
					
					log.info("{} 신규 수량 : {}", orderVO.getPname(), orderVO.getPcount());
					
				} 
				
				// 문제가 된 곳 !
				// orderList.remove(idxArr[i]);
				// orderList.add(orderVO);
				
			} else { // 동일상품이 없을 때
				
				log.info("######### 동일상품 없을 때");
			
				orderVO = new OrderVO();
				orderVO.setPnum(new Integer(pnum[i]));
				
				if(request.getParameter("goodsfile_" + pnum[i]) != null) {
					orderVO.setPfile(request.getParameter("goodsfile_" + pnum[i]));
				} else {
					orderVO.setPfile(svc.selectProduct(new Integer(pnum[i])).getPfile());
				}
				
				log.info("################## pname:" + request.getParameter("pname"));
				
				if(request.getParameter("goodsname_" + pnum[i]) != null) {
					orderVO.setPname(request.getParameter("goodsname_" + pnum[i]));
				} else {
					orderVO.setPname(request.getParameter("pname"));
				}
				
				if(request.getParameter("goodsprice_" + pnum[i]) != null) {
					orderVO.setPrice(new Integer(request.getParameter("goodsprice_" + pnum[i])));
				} else {
					orderVO.setPrice(new Integer(request.getParameter("price")));
				}
				
				if(request.getParameter("goodscapacity_" + pnum[i]) != null) {
					orderVO.setCapacity(request.getParameter("goodscapacity_" + pnum[i]));
				} else {
					orderVO.setCapacity(request.getParameter("capacity"));
				}
				
				if(request.getParameter("goodshardgrove_" + pnum[i]) != null) {
					orderVO.setHardgrove(request.getParameter("goodshardgrove_" + pnum[i]));
				} else {
					orderVO.setHardgrove(request.getParameter("hardgrove"));
				}
				
				if(request.getParameter("goodstotprice_" + pnum[i]) != null) {
					
					orderVO.setTotprice(new Integer(request.getParameter("goodstotprice_" + pnum[i])));
					
				} else {
					
					price = new Integer(request.getParameter("price"));
					pcount = new Integer(request.getParameter("pcount"));
					orderVO.setTotprice(price * pcount);
				}
				
				log.info("#### {} 의 기존수량2:", orderVO.getPname(), orderVO.getPcount());
				
				if(request.getParameter("pcount_"+ pnum[i]) != null) {
					
					orderVO.setPcount(new Integer(request.getParameter("pcount_" + pnum[i])));
					
				} else {
					
					orderVO.setPcount(new Integer(request.getParameter("pcount")));
				}
				
				if(request.getParameter("goodstotshipprice_" + pnum[i]) != null) {
					
					orderVO.setTotshipprice(new Integer(request.getParameter("goodstotshipprice_" + pnum[i])));
				
				} else {
					
					pcount = new Integer(request.getParameter("pcount_" + pnum[i]));
					price = new Integer(request.getParameter("goodstotprice_" + pnum[i]));
					totshipprice = new Integer(request.getParameter("goodstotprice_" + pnum[i]));
					orderVO.setTotprice(totshipprice);
				}
				
				//배송 정보
				orderVO.setUsername(username);
				orderList.add(orderVO);
				
			} // if(idx)
			
		} // for
		
		UserVO userVO = svc.getUserByUsername(username);
		model.addAttribute("userVO", userVO);
		
		log.info("주문처리 : " + orderVO.toString());
		log.info("상품목록 현황 : " );
		log.info("주문목록 갯수 : " + orderList.size());
		
		session.setAttribute("orders",orderList);
		
		log.info("################ 주문목록 갯수: " + orderList.size());
		
		return "/secured/coffee/orderForm";
	}
	
} //