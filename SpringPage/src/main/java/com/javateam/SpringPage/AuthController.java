package com.javateam.SpringPage;

//import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.vo.CustomUser;
import com.javateam.SpringPage.vo.PagingVO;
import com.javateam.SpringPage.vo.ProductVO;
import com.javateam.SpringPage.vo.Role;
import com.javateam.SpringPage.vo.UserLogin;
import com.javateam.SpringPage.vo.UserUpdateVO;
import com.javateam.SpringPage.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

//@RequestMapping : url mapping
//@RequestParam : get or post방식으로 전달된 변수값
@SessionAttributes("userVO") // 기존정보 수정할 떄 필요
@Controller
@Slf4j
public class AuthController {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private AuthMyBatisService svc;

	//홈
	@RequestMapping("/home")
	public void welcome() {

		log.info("##################### /home");
		
	}
	
	// 가입 페이지
	@RequestMapping(value="/join")
	public void join(Model model) {

		log.info("join");

		if(!model.containsAttribute("userVO"))
			model.addAttribute("userVO", new UserVO());
		
	}
	
	// 가입 페이지 액션
	@RequestMapping(value = "/joinAction",
					method=RequestMethod.POST, 
					produces="text/html;charset=UTF-8")
	public String joinAction(@RequestParam("password") String password,
							 @Valid @ModelAttribute("userVO") UserVO userVO,
							 BindingResult result,
							 RedirectAttributes ra,
							 Model model ) {
		
		log.info("################################################################");
		log.info("join Action");
		String path = "/joinAction";
		
		log.info("userVO: " + userVO.toString());

		if (result.hasErrors()) {

			log.error("error !");
			log.error("form error redirect page !");

			// 날짜 관련 오류
			log.error("날짜 : "+result.getFieldValue("birthday"));
			log.error("날짜 오류 : "+result.getFieldErrors("birthday"));

			// 생일 필드 에러 메시지
			if (result.hasFieldErrors("birthday")) {

				log.error("생일 정보 에러 있음 !!");

				List<FieldError> birthdayErrList = result.getFieldErrors("birthday");

				log.error("생일 필드 기정(default) 오류값 : "
						+ birthdayErrList.get(birthdayErrList.size()-1).getDefaultMessage());

				String msg = birthdayErrList.get(birthdayErrList.size()-1).getDefaultMessage();

				if (msg.trim().equals("반드시 값이 있어야 합니다.")) {
					log.info("생일 정보 에러 생성");
					ra.addFlashAttribute("birthday_error",
							birthdayErrList.get(birthdayErrList.size()-1).getDefaultMessage());  
				} else {
					log.info("생일 정보 에러 생성");
					ra.addFlashAttribute("birthday_error", "잘못된 생년월일 형식입니다. 다시 입력하십시오");
				} //

			} //if (result.hasFieldErrors("birthday"))

			log.info("##################################################");

			// password 공백에러
			if(password.trim().equals("")) {
				log.info("password 공백");
				ra.addFlashAttribute("password_err","password를 입력하세요.");
			}
			
			// 오류값 객체 전송
			ra.addFlashAttribute("org.springframework.validation.BindingResult.userVO", result);
			// VO 입력값 전송
			ra.addFlashAttribute("userVO", userVO);

			return "redirect:/join";
		} //if (result.hasErrors())

		String returnValue = "password: " + password + ", ";

		returnValue += userVO.toString();

		log.info("msg:" + returnValue);

		String hashedPassword = ""; 
		BCryptPasswordEncoder passwordEncoder 
		= new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode(password);
		
		log.info("hashedPassword : "+hashedPassword);

		try {
			
			svc.insertUsers(hashedPassword, userVO, "ROLE_USER");
		} catch (Exception e) {
			
			log.error("db 에러 발생 : " + e.getMessage());
			model.addAttribute("db_err", e.getMessage());
			path = "/error/db-err";
		} //try

		return path;
	} // 

	// 로그인 페이지
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(ModelMap model) {

		log.info("############ login ####################");
		log.info("login");
		
		return "login";
	}

	// id 유무 점검 : spring security bug patch !
	@RequestMapping("/login/idCheck")
	public String idCheck(@RequestParam("username") String userName,
						Model model) {

		log.info("############ idCheck ########################");
		log.info("userName : "+userName);

		boolean flag = svc.hasUsername(userName);
		log.info("flag:" + flag);
		model.addAttribute("flag", flag);

		return "idCheck";
	} //
	
	// 회원 상세 정보
	@RequestMapping("/admin/user/userview")
	public String userView(@RequestParam("username") String username,
							Model model) {
		log.info("############## userview ################");
		// 회원 정보를 model에 저장
		model.addAttribute("userVO",svc.viewUser(username));
		
		log.info("클릭한 이름: " + username);

		return "/admin/user/userview";
	} // userview
	
	// 관리자 회원수정
	@RequestMapping("/admin/user/userUpdate")  
	public String updateForm(@RequestParam("username") String username, 
							 /*@RequestParam("password") String password,*/
							 Model model) {  
		
		log.info("############# userUpdate ############");  
		
		// 기존 회원정보 불러오기  
		model.addAttribute("userVO", svc.selectUser(username));
		log.info("############### username #############" + username);

		// 변경할 회원정보 초기화  
		model.addAttribute("userUpdateVO", new UserUpdateVO()); 
		model.addAttribute("password", svc.getUserLoginByUsername(username).getPassword());
		
		log.info("기존 패스워드 : " + svc.getUserLoginByUsername(username).getPassword());
		log.info("####################### ");

		return "/admin/user/userUpdate";  
	} 
	
	//관리자 회원정보액션
	@RequestMapping(value="/admin/user/updateAction",  
					method=RequestMethod.POST, 
					produces="text/html;charset=UTF-8")  
	public String updateAction(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  
							   @RequestParam("password") String password,
							   BindingResult result,
							   RedirectAttributes ra,
							   HttpSession session, 
							   SessionStatus sessionStatus,
							   Model model) {  

		log.info("############# updateAction ##############");  
		
		log.info("userUpdateVO : {} ", userUpdateVO.toString()); //신규
		log.info("userVO : {} ", session.getAttribute("userVO").toString()); //기존
		log.info("기존 비번 : {}", password);
		log.info("바뀐 비번 : {}", userUpdateVO.getPassword1());
		
		log.info("기존/신규 회원 정보 일치 여부: " + userUpdateVO.equals(session.getAttribute("userVO")));  
         
		// 회원정보가 업데이트 되었을 때 :  
        if(!userUpdateVO.equals(session.getAttribute("userVO"))) {  
            
        	//패쓰워드 교체  
        	userUpdateVO.setPassword(userUpdateVO.getPassword1());  
            
        	String returnValue = "password: " + password + ", ";

    		returnValue += session.getAttribute("userVO").toString();
    		
    		// 패스워드 암호화
    		String hashedPassword = ""; 
    		BCryptPasswordEncoder passwordEncoder 
    		= new BCryptPasswordEncoder();
    		hashedPassword = passwordEncoder.encode(password);
    		
    		log.info("hashedPassword : "+hashedPassword);
    		
        	svc.updateUser(userUpdateVO);
        	svc.updateUserLogin(userUpdateVO.getUsername(), hashedPassword);
        }  
		
		sessionStatus.setComplete();// 기존 정보(세션) 제거  
		
		return "/admin/user/updateAction";
	} 
	
	// 관리자 회원 삭제
	@RequestMapping("/admin/user/userDelete")  
	public String userDelete(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  
							 @RequestParam("username") String username, 
							 /*@RequestParam("password") String password,*/
							 Model model) {  
		
		log.info("############# userDelete ############");  
		// 기존 회원정보 불러오기  
		model.addAttribute("userVO", svc.selectUser(username));
		
		return "/admin/user/userDelete";  
	} 
		
	// 회원 삭제
	@RequestMapping("/admin/user/deleteAction")  
	public String deleteAction(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  
							   @RequestParam("username") String username,
							   Model model) {
		
		log.info("###################### UserDelete ###################");
			
		svc.deleteUser(username);
		svc.deleteUserRoles(username);
		svc.deleteUserLogin(username);
		
		return "/admin/user/deleteAction";
			
	} //

	/*-------------------------------------------------*/
	// 사용자 회원 상세 정보
	@RequestMapping("/secured/user/userview")
	public String secureUserView(@RequestParam("username") String username,
							Model model) {
		log.info("############## userview ################");
		// 회원 정보를 model에 저장
		model.addAttribute("userVO",svc.viewUser(username));
		
		log.info("클릭한 이름: " + username);

		return "/secured/user/userview";
	} // userview
	
	//사용자 회원수정
	@RequestMapping("/secured/user/userUpdate")  
	public String secureUserUpdate(@RequestParam("username") String username, 
									Model model) {  
		
		log.info("############# userUpdate ############");  
		
		// 기존 회원정보 불러오기  
		model.addAttribute("userVO", svc.selectUser(username));
		log.info("############### username #############" + username);

		// 변경할 회원정보 초기화  
		model.addAttribute("userUpdateVO", new UserUpdateVO()); 
		model.addAttribute("password", svc.getUserLoginByUsername(username).getPassword());
		
		log.info("기존 패스워드 : " + svc.getUserLoginByUsername(username).getPassword());
		log.info("####################### ");

		return "/secured/user/userUpdate";  
	} 
	
	// 사용자 회원수정 액션
	@RequestMapping(value="/secured/user/updateAction",  
					method=RequestMethod.POST, 
					produces="text/html;charset=UTF-8")  
	public String secureUpdateAction(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  @RequestParam("password") String password,
									 BindingResult result,
									 RedirectAttributes ra,
									 HttpSession session, 
									 SessionStatus sessionStatus,
									 Model model) {  
		
		log.info("############# updateAction ##############");  
		
		log.info("userUpdateVO : {} ", userUpdateVO.toString()); //신규
		log.info("userVO : {} ", session.getAttribute("userVO").toString()); //기존
		log.info("기존 비번 : {}", password);
		log.info("바뀐 비번 : {}", userUpdateVO.getPassword1());
		
		log.info("기존/신규 회원 정보 일치 여부: " + userUpdateVO.equals(session.getAttribute("userVO")));  
		
		// 회원정보가 업데이트 되었을 때 :  
		if(!userUpdateVO.equals(session.getAttribute("userVO"))) {  
		
		//패쓰워드 교체  
		userUpdateVO.setPassword(userUpdateVO.getPassword1());  
		
		String returnValue = "password: " + password + ", ";
		
		returnValue += session.getAttribute("userVO").toString();
		
		// 패스워드 암호화
		String hashedPassword = ""; 
		BCryptPasswordEncoder passwordEncoder 
		= new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode(userUpdateVO.getPassword1());
		
		log.info("hashedPassword : "+hashedPassword);
		
		svc.updateUser(userUpdateVO);
		svc.updateUserLogin(userUpdateVO.getUsername(), hashedPassword);
		}  
		
		sessionStatus.setComplete();// 기존 정보(세션) 제거  
		
		return "/secured/user/updateAction";
	} 
	
	// 회원 삭제
	@RequestMapping("/secured/user/userDelete")  
	public String securedUserDelete(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  
							 @RequestParam("username") String username, 
							 /*@RequestParam("password") String password,*/
							 Model model) {  
		
		log.info("############# securedUserDelete ############");  
		// 기존 회원정보 불러오기  
		model.addAttribute("userVO", svc.selectUser(username));
		
		return "/secured/user/userDelete";  
	} 
		
	// 회원 삭제
	@RequestMapping("/secured/user/deleteAction")  
	public String securedDeleteAction(@ModelAttribute("userUpdateVO") UserUpdateVO userUpdateVO,  
									   @RequestParam("username") String username,
									   Model model) {
			
			log.info("###################### securedDeleteAction ###################");
			
			svc.deleteUser(username);
			svc.deleteUserRoles(username);
			svc.deleteUserLogin(username);
			
			return "/secured/user/deleteAction";
			
	} //
		
	/*---------------------------------------------------------*/
	// 아이디 찾기 페이지
	@RequestMapping(value="/idSearch")
	public void idSearch(Model model) {

		log.info("/idSearch");

	}

	// 아이디 찾기
	@RequestMapping("/idSearchAction")
	public String idSearchAction(@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletRequest request,
			Model model) {

		log.info("########### idSearch #############");

		String msg = "";

		request.getParameter("name");
		request.getParameter("email");

		String username = svc.getIdByNameEmail(name, email);

		msg = username.equals("") ? "해당되는 아이디가 없습니다." : username;

		model.addAttribute("name", name);
		model.addAttribute("email", email);

		return "/login";
	} //idSearch

	// 비밀번호 찾기 페이지
	@RequestMapping(value="/wordSearch")
	public void wordSearch(Model model) {

		log.info("/wordSearch");

	}
	
	// 비밀변호 찾기
	@RequestMapping("/wordSearchAction")
	public String wordSearchAction(@RequestParam("username") String username,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletRequest request,
			Model model) {

		log.info("########### idSearch #############");

		String msg = "";

		request.getParameter("username");
		request.getParameter("name");
		request.getParameter("email");

		String password = svc.getWordByNameEmail(username, name, email);

		msg = password.equals("") ? "해당되는 비밀번호가 없습니다." : password;

		model.addAttribute("username", username);
		model.addAttribute("name", name);
		model.addAttribute("email", email);

		return "/login";
	} //passwordSearch

	// 관리자 페이지
	@RequestMapping(value="/admin/home", method = RequestMethod.GET)
	public String securedAdminHome(ModelMap model) {

		log.info("/admin/home");

		Object principal = SecurityContextHolder.getContext()
				.getAuthentication()
				.getPrincipal();

		CustomUser user = null;

		if (principal instanceof CustomUser) {
			user = ((CustomUser)principal);
		} //if

		log.info("user : " +user);

		String name = user.getUsername();
		model.addAttribute("username", name);
		model.addAttribute("message", "관리자 페이지에 들어오셨습니다.");

		return "/admin/home";
	} // AdminHome

	// 회원 페이지
	@RequestMapping(value="/secured/home", method = RequestMethod.GET)
	public String securedHome(ModelMap model) {

		log.info("/secured/home");

		Object principal = SecurityContextHolder.getContext()
						.getAuthentication()
						.getPrincipal();

		CustomUser user = null;

		if (principal instanceof CustomUser) {
			user = ((CustomUser)principal);
		}
			
		log.info("user : "+user);

		String name = user.getUsername();
		model.addAttribute("username", name);
		model.addAttribute("message", "일반 사용자 페이지에 들어오셨습니다.");

		return "/secured/home";
	} //securedHome

	// 페이징
	@RequestMapping("/admin/user/userlistpaging")
	/*public String userPaging(@RequestParam("curPage") int curPage,
							 @RequestParam("startPage") int startPage,
						 	 @RequestParam("endPage") int endPage,
						  	 @RequestParam("rowPerPage") int rowPerPage,
							 @RequestParam("totPage") int totPage,
							 @RequestParam("prePage") int prePage,
							 @RequestParam("nextPage") int nextPage,
							 //@ModelAttribute("pagingVO")PagingVO pagingVO,
							 Model model) {*/
	public String userPaging(@RequestParam("curPage") int curPage,
							 HttpServletRequest request,
							 Model model) {
		String path = "";

		log.info("############## userPaging ###############");
		PagingVO pagingVO = null; // 페이징 객체
		int userNum = 0;

		//페이지 관련 변수
		curPage = 1; // 현재 페이지
		int startPage = 1; // 시작 페이지
		int endPage = 1; // 마지막 페이지
		int rowPerPage = 10; // 페이지별 글수
		int totPage = 0; // 총 페이지
		int prePage = 0; // 이전 페이지
		int nextPage = 0; // 다음 페이지

		List<UserVO> users = null;
		users = svc.getAllUser();
		userNum = users.size(); // 총인원수

		log.info("userNumber : " + userNum);

		// 인자 전송 여부 점검
		if (request.getParameter("curPage") != null) {

			// 페이지 처리 시작
			if (request.getParameter("curPage") == null) {
				curPage = 1; // 현재 페이지
			} else { // 인자 전송시
				curPage = new Integer(request.getParameter("curPage")); // 현재 페이지
			} //if 

			users = svc.getAllUserByPagingVO(new PagingVO(curPage, rowPerPage));
			// 페이지 처리 끝

		} else { // 첫페이지(무인자)

			users = svc.getAllUserByPagingVO(new PagingVO(1, rowPerPage));
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
		pagingVO = svc.getPageInfo(userNum, pagingVO);

		log.info("userNum : "+ userNum);
		// 전송 인자
		model.addAttribute("pagingVO", pagingVO); // 페이징 관련 인자
		model.addAttribute("userNum", userNum); // 총 인원수
		model.addAttribute("users", users);

		path = "/admin/user/userlistpaging";

		return path;
	}

	// 회원 검색
	@RequestMapping("/admin/user/userlistsearch")
	public String userSearch(HttpServletRequest request,
			Model model) {

		log.info("############## userSearch ###############");
		String page = "";
		String msg = "";
		String username = null;
		String name = null;

		// 인자 점검
		if (request.getParameter("searchWord") == null ||
				request.getParameter("searchWord").trim().equals("")) {

			msg = "검색 키워드를 입력하십시오 !";
			page = "/admin/user/result_msg";
			model.addAttribute("msg", msg);

		} else { // 아이디 인자 입력시(시작)
			log.info("인자입력시");
			String searchKey = request.getParameter("searchKey");

			// 검색키가 "아이디"인 경우 시작
			if (searchKey.equals("username")) {

				log.info("아이디 검색");

				username = request.getParameter("searchWord").trim();

				List<UserVO> users = svc.getUserByName(username, name);
				int num = users.size();

				log.info("name : " + username);
				log.info("num : "+num);

				model.addAttribute("users", users);   
				page = "/admin/user/namesearch";	

			} else if (searchKey.equals("name")) {

				log.info("이름 검색");

				name = request.getParameter("searchWord").trim();

				List<UserVO> users = svc.getUserByName(username, name);
				int num = users.size();

				log.info("name : " + name);
				log.info("num : "+num);

				model.addAttribute("users", users);   
				page = "/admin/user/namesearch";	
				//page = "member/viewAllMembersPaging.jsp";

			} else { // 결과 없음

				model.addAttribute("msg", "회원 조회 결과 없음");
				model.addAttribute("return_page");
				page = "/admin/user/result_msg";

			} // if (searchKey.equals("id")) {
		}
		return page;
	}

	// 로그아웃
	@RequestMapping(value="/logoutProc", method = RequestMethod.GET)
	public String logout(ModelMap model,
			HttpServletRequest request,
			HttpServletResponse response) {

		log.info("logout");

		Authentication auth 
		= SecurityContextHolder.getContext()
		.getAuthentication();

		log.info("auth : "+auth);

		// logout !
		if (auth != null) {    
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}

		return "logout";
	} //

	// 상품 이름 검색
	@RequestMapping("/search")
	public String Search(HttpServletRequest request,
			Model model) {

		log.info("############## productSearch ###############");
		String page = "";
		String msg = "";
		String pname = null; // 이름

		// 인자 점검
		if (request.getParameter("searchWord") == null ||
				request.getParameter("searchWord").trim().equals("")) {

			msg = "검색 키워드를 입력하십시오 !";
			page = "/user/result_msg";
			model.addAttribute("msg", msg);

		} else { // 제목 입력시(시작)
			log.info("인자입력시");
			String searchKey = request.getParameter("searchKey");

			if (searchKey.equals("pname")) {

				log.info("이름 검색");

				pname = request.getParameter("searchWord").trim();

				List<ProductVO> productVO = svc.getProductByName(pname);
				int num = productVO.size();

				log.info("name : " + pname);

				model.addAttribute("productVO", productVO);   
				page = "/product/productsearch";	
				//page = "member/viewAllMembersPaging.jsp";

			} else { // 결과 없음

				model.addAttribute("msg", "회원 조회 결과 없음");
				model.addAttribute("return_page");
				page = "/user/result_msg";

			} // if (searchKey.equals("id")) {
		}
		return page;
	}

	// 로그인 아이디 에러
	@RequestMapping(value="/loginError", method = RequestMethod.GET)
	public String loginError(ModelMap model) {

		model.addAttribute("error", "true");
		model.addAttribute("msg", "로그인 인증 정보가 잘못되었습니다.");
		
		return "login";
	} //

	// id 유무 점검 : spring security bug patch !
	@RequestMapping("/idCheck")
	public String idCk(@RequestParam("username") String username,
			Model model) {

		log.info("username : "+ username);

		boolean flag = svc.hasUsername(username);
		log.info("flag:" + flag);
		model.addAttribute("flag", flag);

		return "idCheck";
	} //

	// 에러 페이지
	@RequestMapping("/access-denied")
	public String accessDenied() {

		log.info("403");

		return "redirect:/login";
	}

} //