package com.javateam.SpringPage;

import java.util.ArrayList;
import java.util.Enumeration;
//import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.CartVO;
import com.javateam.SpringPage.vo.DeliverVO;
import com.javateam.SpringPage.vo.OrderVO;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.ProductVO;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

//@RequestMapping : url mapping
//@RequestParam : get or post방식으로 전달된 변수값
//@SessionAttributes("orders") // 배송정보 저장
@RequestMapping("secured")  
@Controller
@Slf4j
public class ProductSecuredController {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private AuthMyBatisService svc;

	// 상품 등록 페이지
	@RequestMapping("/product/productInsert")
	public void insertProduct(Model model) {

		log.info("########## insertProduct.do ########");

		if(!model.containsAttribute("productVO"))
			model.addAttribute("productVO", new ProductVO());

	}

	// 상품 등록
	@RequestMapping(value="/product/insertProductAction",
					method=RequestMethod.POST)
	public String insertProductAction(@Valid @ModelAttribute("productVO") ProductVO productVO,
									BindingResult result,
									RedirectAttributes ra,   
									Model model) {

		log.info("########## insertProductAction ########");
		log.info("productVO: " + productVO.toString());

		if (result.hasErrors()) {

			log.error("error !");
			log.error("form error redirect page !");

			// 오류값 객체 전송
			ra.addFlashAttribute("org.springframework.validation.BindingResult.productVO",
					result);
			// VO 입력값 전송
			ra.addFlashAttribute("productVO", productVO);
			//svc.insertProduct(productVO);

			return "redirect:/product/productInsert";

		}
		svc.insertProduct(productVO);

		// 성공시
		return "redirect:/product/productlist?curPage=1";
	}

	@RequestMapping("/product/productUpdate")
	public String productView(@RequestParam("pnum") int pnum,
			Model model) {
		log.info("########### productView #############");

		// 회원 정보를 model에 저장
		model.addAttribute("productVO", svc.selectProduct(pnum));

		return "/product/productUpdate";
	}

	@RequestMapping("/updateProduct")
	public String updateProduct(@RequestParam("pnum") int pnum,
			Model model) {
		// 회원 정보를 model에 저장
		model.addAttribute("productVO", svc.selectProduct(pnum));

		// 기존 상품 불러오기
		ProductVO productVO = new ProductVO();

		model.addAttribute("productVO", productVO);
		model.addAttribute("pnum", pnum);

		return "/product/productUpdate?pnum=${productVO.pnum}";
	}

	// 상품 수정
	@RequestMapping(value = "/product/productUpdateAction",
			method = RequestMethod.POST,
			produces = "text/html; charset=UTF-8")
	public String updateProductAction(@ModelAttribute("productVO") ProductVO productVO,
			/*@PathVariable("pnum") int pnum,*/
			Model model) {

		log.info("############ deleteBoard ##############");

		svc.updateProduct(productVO);

		model.addAttribute("productVO: ", productVO);

		return "/product/productlist?curPage=1";
	}

	// 상품 삭제
	@RequestMapping("/product/productDelete")
	public String productDelete(@RequestParam("pnum") int pnum,
			HttpServletRequest request,
			Model model) {

		log.info("############ deleteProduct ##############");
		svc.deleteProduct(pnum);
		
		model.addAttribute("pnum : " + pnum);

		return "/product/productDelete";
	}

	// 상품 목록 보기
	@RequestMapping("/product/productlist")
	public String productList(@RequestParam("curPage") int curPage,
			HttpServletRequest request,
			Model model) {
		String path = "";

		log.info("############## productList ###############");
		PagingVO pagingVO = null; // 페이징 객체
		int pnum = 0;

		//페이지 관련 변수
		curPage = 1; // 현재 페이지
		int startPage = 1; // 시작 페이지
		int endPage = 1; // 마지막 페이지
		int rowPerPage = 10; // 페이지별 글수
		int totPage = 0; // 총 페이지
		int prePage = 0; // 이전 페이지
		int nextPage = 0; // 다음 페이지

		List<ProductVO> productVO = null;
		productVO = svc.getAllProduct();
		pnum = productVO.size(); // 총인원수

		log.info("pnum : " + pnum);

		// 인자 전송 여부 점검
		if (request.getParameter("curPage") != null) {

			// 페이지 처리 시작
			if (request.getParameter("curPage") == null) {
				curPage = 1; // 현재 페이지
			} else { // 인자 전송시
				curPage = new Integer(request.getParameter("curPage")); // 현재 페이지
			} //if 

			productVO = svc.getProductByPagingVO(new PagingVO(curPage, rowPerPage));
			// 페이지 처리 끝

		} else { // 첫페이지(무인자)

			productVO = svc.getProductByPagingVO(new PagingVO(1, rowPerPage));
		}
		// 페이징 인자 객체 형성
		pagingVO = new PagingVO(curPage,
				startPage,
				endPage,
				rowPerPage,
				totPage,
				prePage,
				nextPage);
		// 페이징 처리
		pagingVO = svc.getPageProduct(pnum, pagingVO);

		log.info("pnum : "+ pnum);
		// 전송 인자
		model.addAttribute("pagingVO", pagingVO); // 페이징 관련 인자
		model.addAttribute("pnum", pnum); // 총 인원수
		model.addAttribute("productVO", productVO);

		path = "/product/productlist";

		return path;
	}

	/*----------------------상품구입------------------------*/
	// 로스팅원두
	@RequestMapping("/coffee/buy")
	public String buy(HttpServletRequest request,
					  Model model) {

		List<ProductVO> productVO = null;
		productVO = svc.getAllProduct();
		
		model.addAttribute("productVO", productVO);

		return "/coffee/buy";
	}
	// 더치커피
	@RequestMapping("/coffee/buy2")
	public String buy2(HttpServletRequest request,
					   Model model) {

		List<ProductVO> productVO = null;
		productVO = svc.getAllProduct();
		
		model.addAttribute("productVO", productVO);

		return "/coffee/buy2";
	}
	// 커피 이벤트
	@RequestMapping("/coffee/buy3")
	public String buy3(HttpServletRequest request,
			   			Model model) {

		List<ProductVO> productVO = null;
		productVO = svc.getAllProduct();
		
		model.addAttribute("productVO", productVO);
		
		return "/coffee/buy3";
	}
	
	// 커피 구매 페이지
	@RequestMapping("/coffee/buyForm")
	public String buyForm(@RequestParam("pnum") int pnum,
							Model model) {
		log.info("############ buyForm ##############");
	
		// 회원 정보를 model에 저장
		model.addAttribute("productVO", svc.selectProduct(pnum));

		log.info("클릭한 상품: " + pnum);

		return "/coffee/buyForm";
	}
	
	// 커피 구매 페이지2
	@RequestMapping("/coffee/buyForm2")
	public String buyForm2(@RequestParam("pnum") int pnum,
							Model model) {
		log.info("############ buyForm2 ##############");
		
		// 회원 정보를 model에 저장
		model.addAttribute("productVO",svc.selectProduct(pnum));

		log.info("클릭한 상품: " + pnum);

		return "/coffee/buyForm2";
	}
	
	// 커피 구매 폼
	@RequestMapping(value ="/coffee/orderForm", method={RequestMethod.POST,RequestMethod.GET})
	public String orderForm(/*@RequestParam("pnum") int pnum,*/
						   /* @RequestParam("username") String username,*/
							  HttpServletRequest request,
							  Model model,
							  HttpSession session) {

		log.info("############## orderForm ###############");
		
		log.info("SessionID : " + request.getUserPrincipal().getName());
		UserVO userVO = svc.viewUser(request.getUserPrincipal().getName());
		
		model.addAttribute("userVO", userVO);
		
		/*model.addAttribute("userVO",svc.viewUser(username));*/
		/*model.addAttribute("productVO", svc.selectProduct(pnum));*/
		
		return "/secured/coffee/buyList";
		//return "/coffee/buyList";
	}
	
	// 커피 구매 폼
	/*@RequestMapping(value = "/coffee/orderAction", method= {RequestMethod.POST,RequestMethod.GET})
	public String orderAction(@ModelAttribute("deliverVO") DeliverVO deliverVO,
							   HttpServletRequest request, 
							   Model model,
							   HttpSession session) {
		
		log.info("############# 주문처리 ######");
		log.info("주문처리  : " + deliverVO.toString());
		Map <String, String[]> map = request.getParameterMap();
		map.forEach((x,y)->{log.info(x + "=" + y[0]);});
		
		List<OrderVO> orderList = new ArrayList<>();
		
		OrderVO orderVO = null;
		
		log.info("################ pnum1: " +  request.getParameter("pnum"));
		String pnum[] = request.getParameterValues("pnum");
		log.info("pnum: " + pnum[0]);
		log.info("pnum.size :" + pnum.length);
		
		String username = request.getUserPrincipal().getName();
		
		int price = 0;
		int pcount = 0;
		int deliverPrice = 0;
		
		for(int i = 0; i < pnum.length; i++) {
			
			orderVO = new OrderVO();
			orderVO.setPnum(new Integer(pnum[i]));
			
			if(request.getParameter("goodsfile_" + pnum[i]) != null) {
				
				orderVO.setPfile(request.getParameter("goodsfile_" + pnum[i]));
				
			} else {
				//if(pnum.length > 1) {
					
					orderVO.setPfile(svc.selectProduct(new Integer(pnum[i])).getPfile());
				//} else {
					
				//	orderVO.setPfile(svc.selectProduct(new Integer(pnum)).getPfile());
				//}
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
			
			if(request.getParameter("pcount_"+ pnum[i]) != null) {
				
				orderVO.setPcount(new Integer(request.getParameter("pcount_" + pnum[i])));
			} else {
				
				orderVO.setPcount(new Integer(request.getParameter("pcount")));
			}
			
			if(request.getParameter("goodstotshipprice_" + pnum[i]) != null) {
				
				orderVO.setTotshipprice(new Integer(request.getParameter("goodstotshipprice_" + pnum[i])));
			} else {
				price = new Integer(request.getParameter("price"));
				pcount = new Integer(request.getParameter("pcount"));
				deliverPrice = new Integer(request.getParameter("deliverPrice"));
				orderVO.setTotprice(price * pcount + deliverPrice);
			}
			
			//배송 정보
			orderVO.setUsername(username);
			
			orderList.add(orderVO);
			
		} // for
		
		UserVO userVO = svc.getUserByUsername(username);
		
		model.addAttribute("userVO", userVO);
		
		log.info("주문처리 : " + orderVO.toString());
		log.info("상품목록 현황 : " );
		
		for(OrderVO order : orderList) {
			
			log.info(order.toString());
		}
		
		log.info("###########################");
		
		// 세션 미생성 시
		if(session.getAttribute("orders") == null) {
			
			session.setAttribute("orders", orderList);
		} else { // 기존 세션 존재 시
			
			List<OrderVO> legacyOrderList = (List<OrderVO>)session.getAttribute("orders"); // 기존 세션(주문 목록)
			orderList.addAll(legacyOrderList);
			
			session.setAttribute("orders", orderList);
			
		}
		log.info("################ 주문목록 갯수: " + orderList.size());
		
		for(OrderVO order:orderList) {
			
			log.info("주문상품: " + order.getPname());
		}
		
		//if (!model.containsAttribute("orders")) {
			
			//model.addAttribute("orders", new ArrayList<OrderVO>());
			
			//svc.orderCoffee(orderVO); // 테이블 저장
		//}
		
		return "/secured/coffee/orderForm";
	}*/
	
	// 주문목록 주문량 수정
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/orderPcountUpdate", method=RequestMethod.GET, 
					produces="text/html; charset=UTF-8")
	@ResponseBody
	public String orderPcountUpdate(@RequestParam("pnum") int pnum,
								@RequestParam("pcount") int pcount,
								HttpSession session,
								Model model) {

		log.info("############## orderpcountUpdate ###############");
		
		String msg = "변경실패";
		
		log.info("pnum:" + pnum);
		log.info("pcount: " + pcount);
		
		List<OrderVO> orderList = null;
		
		//비었을 때
		if(session.getAttribute("orders") == null) {
			
			log.info("주문목록 비었음 ##################");
			orderList = new ArrayList<>();
			
		} else { // 있을 때
			
			orderList = (List<OrderVO>) session.getAttribute("orders");
			
			for(OrderVO orderVO : orderList) {
				
				if(orderVO.getPnum() == pnum) {
					
					orderVO.setPcount(pcount);
					msg = "변경 성공";
				} //if
			} //for
		} //
		
		return msg;
	}
	
	//최종결제처리
	@RequestMapping(value= "/coffee/paymentAction", method= {RequestMethod.POST,RequestMethod.GET})
	public String paymentAction(OrderVO orderVO,
								HttpServletRequest request,
								   HttpSession session,
								   Model model) { 
		
		log.info("결제처리 ######################");
		
		Map <String, String[]> map = request.getParameterMap(); 
		
		map.forEach((x,y)->{log.info(x + "=" + y[0]);});
		
		//orderList = (List<OrderVO>)session.getAttribute("orders");
		//session.getAttribute("orders");
		
		svc.orderCoffee(orderVO);
		
		return "/secured/coffee/paymentAction";
	}
	
	// 주문목록 삭제
	@RequestMapping(value= "/coffee/orderDeleteAction", method=RequestMethod.GET)
	public String orderDeleteAction(HttpServletRequest request,
								   HttpSession session,
								   Model model) {

		log.info("############## orderDelete ###############");
		
		String pnums[] = request.getParameterValues("pnum");
		
		@SuppressWarnings("unchecked")
		List<OrderVO> orders = (List<OrderVO>)session.getAttribute("orders");
		
		log.info("orders size:" + orders.size());
		
		// 해당 상품 아이디 삭제
		if(orders.size() > 0) {
			
			for(int i = 0; i < orders.size(); i++) {
				
				for(int j = 0; j < pnums.length; j++) {
					
					if(orders.get(i).getPnum() == new Integer(pnums[j])) {
						orders.remove(i);
					}
				}//
			} //
		}
		session.setAttribute("orders", orders); // 세션갱신
		
		log.info("order size2 : " + orders.size());
		
		return "/secured/coffee/orderForm";
	}
	
	/*// 구입상품 삭제
	@RequestMapping("/coffee/coffeeDelete")
	public String coffeeDelete(@RequestParam("pnum") int pnum,
								HttpServletRequest request,
								Model model) {
		
		log.info("############ coffeeDelete ##############");
		svc.deleteCoffee(pnum);

		model.addAttribute("pnum : " + pnum);
		
		return "/coffee/coffeeDelete";
	}*/

	/*
	@RequestMapping(method = RequestMethod.GET)
	public String getCart(Model model) {
		if (!model.containsAttribute("cart")) {
			model.addAttribute("cart", new ArrayList<ProductVO>());
		}
		return "/coffee/buyCart";
	}
	
	@RequestMapping(value="add", method = RequestMethod.POST)
	public String add(@ModelAttribute ProductVO product,
			          @ModelAttribute("cart") List<ProductVO> cart) {
		cart.add(product);
		return "redirect:/coffee/buyCart";
	}
	*/
	/*// 관심상품등록
	@RequestMapping(value="/coffee/wishAction",
					method=RequestMethod.POST)
	public String wishAction(@ModelAttribute("wishListVO") WishListVO wishListVO,
							 BindingResult result,
							 RedirectAttributes ra,   
							 Model model) {
		
		log.info("############ wishAction ##############");
		log.info("wishListVO: " + wishListVO.toString());

		svc.insertWishList(wishListVO);

		// 성공시
		return "/coffee/wishAction";
	}*/
	/*
	// 관심상품목록
	@RequestMapping("/coffee/buyWish")
	public String buyWish(HttpServletRequest request,
						  Model model) {
		
		log.info("############ buyWish ##############");
		
		int pnum = 0;

		List<WishListVO> wishListVO = null;
		wishListVO = svc.getAllWishList();
		pnum = wishListVO.size(); // 총 갯수
		
		log.info("pnum : " + pnum);

		// 전송 인자
		model.addAttribute("pnum", pnum); // 총 갯수
		model.addAttribute("wishListVO", wishListVO);

		return "/coffee/buyWish";
	}*/
	
	/*// 상품 삭제
	@RequestMapping("/coffee/deleteWish")
	public String deleteWish(@RequestParam("pnum") int pnum,
							 HttpServletRequest request,
							 Model model) {

		log.info("############ deleteWish ##############");
		svc.deleteWishList(pnum);
		
		model.addAttribute("pnum : " + pnum);

		return "/coffee/deleteWish";
	}*/
} //