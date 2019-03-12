package com.javateam.SpringPage;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.ProductVO;
import com.javateam.SpringPage.vo.UserVO;
import com.javateam.SpringPage.vo.CartVO;
import com.javateam.SpringPage.vo.OrderVO;

import lombok.extern.slf4j.Slf4j;

//@RequestMapping : url mapping
//@RequestParam : get or post방식으로 전달된 변수값
//@SessionAttributes("cart") // 기존정보 일시적 저장 장바구니에 필요
@Controller
@Slf4j
public class ProductController {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private AuthMyBatisService svc;

	// 관리자 상품 등록 페이지
	@RequestMapping("/admin/product/productInsert")
	public void insertProduct(Model model) {

		log.info("########## insertProduct.do ########");

		if(!model.containsAttribute("productVO"))
			model.addAttribute("productVO", new ProductVO());

	}

	// 관리자 상품 등록
	@RequestMapping(value="/admin/product/insertProductAction",
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

			return "redirect:/admin/product/productInsert";

		}
		svc.insertProduct(productVO);

		// 성공시
		return "redirect:/admin/product/productlist?curPage=1";
	}

	// 관리자 상품 목록
	@RequestMapping("/admin/product/productUpdate")
	public String productView(@RequestParam("pnum") int pnum,
							  Model model) {
		log.info("########### productView #############");

		// 회원 정보를 model에 저장
		model.addAttribute("productVO", svc.selectProduct(pnum));

		return "/admin/product/productUpdate";
	}

	// 상품정보 수정
	@RequestMapping("/admin/product/updateProduct")
	public String updateProduct(@RequestParam("pnum") int pnum,
			Model model) {
		// 회원 정보를 model에 저장
		model.addAttribute("productVO", svc.selectProduct(pnum));

		// 기존 상품 불러오기
		ProductVO productVO = new ProductVO();

		model.addAttribute("productVO", productVO);
		model.addAttribute("pnum", pnum);

		return "/admin/product/productUpdate?pnum=${productVO.pnum}";
	}
	
	// 상품 수정
	@RequestMapping(value = "/admin/product/productUpdateAction",
			method = RequestMethod.POST,
			produces = "text/html; charset=UTF-8")
	public String updateProductAction(@ModelAttribute("productVO") ProductVO productVO,
			/*@PathVariable("pnum") int pnum,*/
			Model model) {

		log.info("############ deleteBoard ##############");

		svc.updateProduct(productVO);

		model.addAttribute("productVO: ", productVO);

		return "/admin/product/productlist?curPage=1";
	}

	// 상품 삭제
	@RequestMapping("/admin/product/productDelete")
	public String productDelete(@RequestParam("pnum") int pnum,
			HttpServletRequest request,
			Model model) {

		log.info("############ deleteProduct ##############");
		svc.deleteProduct(pnum);
		
		model.addAttribute("pnum : " + pnum);

		return "/admin/product/productDelete";
	}

	// 상품 목록 보기
	@RequestMapping("/admin/product/productlist")
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

		path = "/admin/product/productlist";

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
	@RequestMapping(value = "/coffee/buyForm", method=RequestMethod.GET)
	public String buyForm(@RequestParam("pnum") int pnum,
						  Model model) {
		
		log.info("############ buyForm ##############");
	
		if (!model.containsAttribute("cart")) {
			
			model.addAttribute("cart", new ArrayList<ProductVO>());
			
		}
		
		// 회원 정보를 model에 저장
		ProductVO productVO = svc.selectProduct(pnum);
		model.addAttribute("productVO", productVO);
		
		log.info("$$$$$$$$$$$$$$productVO :" + productVO.toString());
		log.info("$$$$$$$$$$$$$$$$$$$$$$$ 분쇄도 : " + productVO.getHardgrove());
		log.info("$$$$$$$$$$$$$$$$$$$$$$$ 용량 : " + productVO.getCapacity());
		
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
		
	// 커피 구매 처리
	@RequestMapping(value="/coffee/buyAction",
					method=RequestMethod.POST)
	public String buyAction(@ModelAttribute("userVO") UserVO userVO,
							Model model) {

		log.info("########## buyAction ########");

		model.addAttribute("userVO", userVO);
		
		// 성공시
		return "redirect:/secured/coffee/orderForm";
	}
	
	// 장바구니 담기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/coffee/cartAction", method= {RequestMethod.POST,RequestMethod.GET})
	public String cartAction(@ModelAttribute("productVO") ProductVO productVO,
							 HttpSession session) {
		
		log.info("############# 장바구니 처리 액션 ######");
		log.info("장바구니 등록 상품  : " + productVO.toString());
		
		log.info("장바구니 등록 ");
		
		List<CartVO> cartList = null;
		
		// 장바구니가 비었을 때
		if(session.getAttribute("cart") == null) {
			
			log.info("장바구니 비었음 ##################");
			cartList = new ArrayList<>();
			// 추가 사항
			
			
		} else { // 장바구니가 있을 때
			
			cartList = (List<CartVO>) session.getAttribute("cart");
		}
		
		log.info("##### 카트 인자 여부 : "+productVO.toString());
		
		// 추가 사항 : 인자 null 여부 점검				
		if (productVO.getPname() != null) {
		
			// 동일상품 여부
			// 동일상품일 경우
			CartVO cartVO = null;
			int idx = svc.hasProduct(productVO.getPnum(), productVO.getCapacity(),
									productVO.getHardgrove(), cartList);
			
			if(idx != -1) {
				
				cartVO = cartList.get(idx);
				// 기존 주문량 + 신규 주문량
				cartVO.setPcount(cartVO.getPcount() + productVO.getPcount());
				cartVO.setPfile(svc.selectProduct(productVO.getPnum()).getPfile()); //상품이미지 추가
				cartList.add(cartVO);
				cartList.remove(idx);
				
			} else { // 동일상품이 없을 때
				
				cartVO = new CartVO(productVO);
				cartVO.setPfile(svc.selectProduct(productVO.getPnum()).getPfile()); //상품이미지 추가
				cartList.add(cartVO);
			}
	
			log.info("장바구니 현황 : " );
			
			for(CartVO cart : cartList) {
				
				log.info(cart.toString());
			}
		
		} //  인자 null 여부 점검 끝
		
		log.info("###########################");
		
		session.setAttribute("cart", cartList);
		
		return "/secured/coffee/buyCart";
	}
	
	// 장바구니 주문량 수정
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/pcountUpdate", method=RequestMethod.GET, 
					produces="text/html; charset=UTF-8")
	@ResponseBody
	public String pcountUpdate(@RequestParam("pnum") int pnum,
								@RequestParam("pcount") int pcount,
								HttpSession session,
								Model model) {

		log.info("############## pcountUpdate ###############");
		
		String msg = "변경실패";
		
		log.info("pnum:" + pnum);
		log.info("pcount: " + pcount);
		
		List<CartVO> cartList = null;
		
		//비었을 때
		if(session.getAttribute("cart") == null) {
			
			log.info("장바구니 비었음 ##################");
			cartList = new ArrayList<>();
			
		} else { // 있을 때
			
			cartList = (List<CartVO>) session.getAttribute("cart");
			
			//CartVO cartVO = null;
			
			for(CartVO cartVO : cartList) {
				
				if(cartVO.getPnum() == pnum) {
					
					cartVO.setPcount(pcount);
					msg = "변경 성공";
				} //if
			} //for
		} //
		
		return msg;
	}
	
	// 장바구니 선택삭제
	@RequestMapping(value= "/coffee/cartDeleteAction", method=RequestMethod.GET)
	public String cartDeleteAction(HttpServletRequest request,
								   HttpSession session,
								   Model model) {

		log.info("############## cartDelete ###############");
		
		String pnums[] = request.getParameterValues("pnum");
		
		@SuppressWarnings("unchecked")
		List<CartVO> carts = (List<CartVO>)session.getAttribute("cart");
		log.info("cartssize:" + carts.size());
		
		// 해당 상품 아이디 삭제
		if(carts.size() > 0) {
			
			for(int i = 0; i < carts.size(); i++) {
				
				for(int j = 0; j < pnums.length; j++) {
					
					if(carts.get(i).getPnum() == new Integer(pnums[j])) {
						carts.remove(i);
					}
				}//
			} //
		}
		session.setAttribute("cart", carts); // 세션갱신
		
		log.info("cartsize2 : " + carts.size());
		/*
		session.removeAttribute("pnum");*/
		
		return "/secured/coffee/buyCart";
		//return "/coffee/buyList";
	}
	
	// 장바구니 전체 삭제
	@RequestMapping(value= "/coffee/cartAllDeleteAction", method=RequestMethod.GET)
	public String cartDeleteAction(HttpSession session,
								   Model model) {

		log.info("############## cartAllDelete ###############");
		
		session.removeAttribute("cart");
		
		return "/secured/coffee/buyCart";
	}
	
	// 관리자 상품배송상태 업데이트
	@RequestMapping(value = "/admin/coffee/orderAdmin",  method=RequestMethod.GET)
	public String orderAdmin(HttpServletRequest request,
							 Model model) {
		
		List<OrderVO> orders = svc.getAllCoffee();
		
		OrderVO orderVO = new OrderVO();
		
		log.info("OrderVO:" + orderVO.toString());
		log.info("orders:" + orders);
		
		model.addAttribute("orders", orders);
		
		return "/admin/coffee/orderAdmin";
	}
	
	/*-------------------------------------------*/
	/*// 관심상품등록
	@RequestMapping(value="/coffee/wishListAction",
					method=RequestMethod.POST)
	public String wishListAction(@ModelAttribute("wishListVO") WishListVO wishListVO,
								 @RequestParam("pnum") int pnum,
								 BindingResult result,
								 RedirectAttributes ra,   
								 Model model) {
		
		log.info("############ wishAction ##############");
		log.info("wishListVO: " + wishListVO.toString());

		svc.insertWishList(wishListVO);

		// 성공시
		return "/coffee/wishListAction";
	}*/
	/*
	// 관심상품목록
	@RequestMapping("/coffee/buyWishList")
	public String buyWishList(HttpServletRequest request,
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

		return "/coffee/buyWishList";
	}*/
	/*
	// 상품 삭제
	@RequestMapping("/coffee/deleteWishList")
	public String deleteWishList(@RequestParam("pnum") int pnum,
								 HttpServletRequest request,
								 Model model) {

		log.info("############ deleteWish ##############");
		svc.deleteWishList(pnum);
		
		model.addAttribute("pnum : " + pnum);

		return "/coffee/deleteWishList";
	}*/
} //