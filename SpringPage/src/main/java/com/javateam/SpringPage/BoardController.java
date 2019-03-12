package com.javateam.SpringPage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
//import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.javateam.SpringPage.service.AuthMyBatisService;
import com.javateam.SpringPage.service.FileUploadNamingServiceImpl;
import com.javateam.SpringPage.vo.BoardDTO;
import com.javateam.SpringPage.vo.BoardVO;
import com.javateam.SpringPage.vo.NoticeDTO;
import com.javateam.SpringPage.vo.NoticeVO;
import com.javateam.SpringPage.vo.PageVO;

import lombok.extern.slf4j.Slf4j;

//@RequestMapping : url mapping
//@RequestParam : get or post방식으로 전달된 변수값
//@RequestMapping("secured")  
@Controller
@Slf4j
public class BoardController {

	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private FileUploadNamingServiceImpl fileNamingSvc;

	@Autowired
	private AuthMyBatisService svc;
	
	@RequestMapping("/secured/board/writeBoardForm.do")
	public String writeBoardForm(Model model) {

		log.info("writeBoardForm");

		model.addAttribute("boardVO", new BoardDTO());

		return "/secured/board/writeBoardForm";
	}

	@RequestMapping(value="/secured/board/writeBoardProc.do",
			method = RequestMethod.POST,
			produces = "text/plain; charset=UTF-8")
	public String writeBoardProc(@ModelAttribute("boardDTO") BoardDTO boardDTO) {

		log.info("############# writeBoardProc ##################");

		log.info("VO : {}", boardDTO);

		MultipartFile file = boardDTO.getBoardFile(); // 업로드 파일
		FileOutputStream fos = null;
		String fileName = null;

		// 업로드 파일 처리
		if  (!boardDTO.getBoardFile().isEmpty() && file != null) { // 파일 유효성 점검

			fileName = file.getOriginalFilename();

			try {
				byte[] bytes = file.getBytes();

				File outFileName
				= new File(uploadDirResource.getPath() + fileName);
				fos = new FileOutputStream(outFileName);

				fos.write(bytes);

			} catch (IOException e) {
				log.info("BoardController save File writing error ! ");
				e.printStackTrace();
			} finally {
				try {    
					if (fos !=null) fos.close();
				} catch (IOException e) {
					log.info("BoardController save IOE : ");
					e.printStackTrace();
				}
				log.info("File upload success! ");
			} // try

		} // 업로드 파일 처리


		BoardVO boardVO = new BoardVO(boardDTO);
		boardVO.setBoardReRef(boardDTO.getBoardNum());
		boardVO.setBoardFile(!boardDTO.getBoardFile().isEmpty() && file != null ? fileName : "");

		log.info("############### boardVO : {}", boardVO);

		svc.writeBoard(boardVO);

		return "/secured/board/boardList.do/1";
	} //

	@RequestMapping(value="/secured/board/viewBoard.do/{boardNum}",
			method = RequestMethod.GET,
			produces = "text/plain; charset=UTF-8")
	public String writeBoardProc(@PathVariable("boardNum") int boardNum, Model model) {

		BoardVO board = svc.selectBoard(boardNum);
		log.info("############### viewBoard.do : {}", board);

		model.addAttribute("board", board);

		return "/secured/board/viewBoard";
	}

	// 게시판 목록
	@RequestMapping("/secured/board/boardList.do/{page}")
	public String listBoard(@PathVariable("page") int page,
			Model model) {

		int limit = 10; // 페이지당 글수
		List<BoardVO> articleList;

		page = page!=0 ? page : 1; // page 설정

		// 총페이지수
		int listCount = svc.getListCount();

		articleList= svc.getArticleList(page, limit);

		// 총 페이지 수
		int maxPage=(int)((double)listCount/limit+0.95); //0.95를 더해서 올림 처리
		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21,...)
		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		int endPage = startPage + 10 - 1;

		if (endPage> maxPage) endPage= maxPage;

		PageVO pageVO = new PageVO();
		pageVO.setEndPage(endPage);
		pageVO.setListCount(listCount);
		pageVO.setMaxPage(maxPage);
		pageVO.setPage(page);
		pageVO.setStartPage(startPage);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("articleList", articleList);

		return "/secured/board/boardList";
	} //

	// JSON Feed Service : 개별 게시글 보기
	@RequestMapping(value="/secured/board/boardDetailJSON.do/boardNum/{boardNum}",
			produces="application/json; charset=UTF-8")
	@ResponseBody
	public String boardDetailFeed(@PathVariable("boardNum") int boardNum) 
	{
		log.info("boardDetailFeed");

		// 조회수 업데이트
		svc.updateReadCount(boardNum);

		String json="";
		ObjectMapper mapper = new ObjectMapper();
		BoardVO board = svc.selectBoard(boardNum);

		try {
			json = mapper.writeValueAsString(board);

		} catch (JsonProcessingException e) {
			log.debug("json exception !");
			e.printStackTrace();
		}

		return json;
	} //

	@RequestMapping("/secured/board/replyWriteBoardProc.do")
	@ResponseBody
	public String replyWriteBoardProc(BoardVO boardVO) { 

		log.info("############## replyWriteBoardProc.do ################");

		log.info("########### boardVO : "+boardVO.toString());

		boolean msg = false;

		// 답글 등록 관련 변수
		int reRef = boardVO.getBoardReRef(); // 댓글의 원 게시글 번호
		int reLev = boardVO.getBoardReLev(); // 댓글의 레벨
		int reSeq = boardVO.getBoardReSeq(); // 댓글의 순서

		svc.updateBoardByRefAndSeq(reRef, reSeq);

		// 답글 관련 인자 계산
		reSeq = reSeq + 1;
		reLev = reLev + 1;

		boardVO.setBoardReSeq(reSeq);
		boardVO.setBoardReLev(reLev);

		msg = svc.replyWriteBoard(boardVO);

		return msg+"";
	}

	// 게시판 수정
	@RequestMapping(value="/secured/board/updateBoard.do/{boardNum}", 
			produces="text/html; charset=UTF-8")
	@ResponseBody
	public String updateBoard(@PathVariable("boardNum") int boardNum,
			@RequestParam(value="update_boardFile_new", required=false) MultipartFile file,
			HttpServletRequest req) {

		log.info("########### updateBoard ############");

		String msg = "";
		boolean flag = false; // 업데이트 성공여부 플래그 추가

		if (req.getParameter("update_boardSubject") == null || 
				req.getParameter("update_boardSubject").equals(""))
			msg += "글제목을 입력하십시오.\n";

		if (req.getParameter("update_boardContent") == null || 
				req.getParameter("update_boardContent").equals(""))
			msg += "글내용을 입력하십시오.";

		if (!msg.equals("")) return msg; // 오류 있으면 메시지 전송

		log.info("msg : {}", msg);

		// 인자 출력
		log.info("update_boardNum : {}", req.getParameter("update_boardNum"));
		log.info("update_boardName : {}", req.getParameter("update_boardName"));
		log.info("update_boardSub : {}", req.getParameter("update_boardSub"));
		log.info("update_boardContent : {}", req.getParameter("update_boardContent"));

		// log.info("fileName : {}", file.getOriginalFilename());

		// 기존 정보 가져오기
		BoardVO boardVO = new BoardVO(); // 갱신할 VO
		BoardVO oldBoardVO = svc.selectBoard(boardNum);
		boardVO = oldBoardVO; // 

		// 게시글 수정
		boardVO.setBoardNum(boardNum);
		boardVO.setBoardName(req.getParameter("update_boardName"));
		boardVO.setBoardSub(req.getParameter("update_boardSub"));
		boardVO.setBoardContent(req.getParameter("update_boardContent"));

		// 주의) 편의상 다른 게시글에서도 동일한 첨부가 있을 경우 문제가 되므로 
		//      기존 파일 삭제는 생략하였습니다. 이러한 경우는 파일 업로드시 계정별 폴더 세분화     
		//      혹은 업로드 파일마다 접미사(순번 등) 등을 이용하여 처리할 수 있습니다.
		// 기존 파일과 비교
		// 추가) 첨부 파일 없을 경우(답글 수정시) 조건 추가 
		if (file==null ||
				file.getOriginalFilename()==null || 
				file.getOriginalFilename().equals("")) {

			log.info("############ 신규 첨부 파일 없을 때 ############");

			// 기존 파일 저장
			boardVO.setBoardFile(oldBoardVO.getBoardFile());

			// 추가 : 첨부 파일이 애시당초 없을 경우
			if (file==null) boardVO.setBoardFile("");

		} else {

			log.info("fileName : {}", file.getOriginalFilename());

			boardVO.setBoardFile(file.getOriginalFilename());

			// 파일 저장소에 새 파일 저장(시작)
			if  (!boardVO.getBoardFile().isEmpty() && file != null) { // 파일 유효성 점검

				String fileName = file.getOriginalFilename();

				FileOutputStream fos = null;

				try {
					// 업로드 파일 형식 변환(시작)
					fileName = fileNamingSvc.parseFilePostfix(boardNum, fileName);
					log.info("실제 업로드 파일명 : {}", fileName);

					boardVO.setBoardFile(fileName);
					// 업로드 파일 형식 변환(끝)

					byte[] bytes = file.getBytes();

					File outFileName
					= new File(uploadDirResource.getPath() + fileName);
					fos = new FileOutputStream(outFileName);

					fos.write(bytes);

				} catch (IOException e) {
					log.info("BoardUpdateController update File writing error ! ");
					e.printStackTrace();
				} finally {
					try {    
						if (fos !=null) fos.close();
					} catch (IOException e) {
						log.info("BoardUpdateController update IOE : ");
						e.printStackTrace();
					}
					log.info("File upload success! ");
				} // try

			} // 업로드 파일 처리
			// 파일 저장소에 새 파일 저장(끝)
		} //

		// 게시글 갱신 등록일 : 12시간 기준 hh: -> 24시간 기준으로 변경 HH:
		String dateString 
		= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		.format(new Date(System.currentTimeMillis())).toString();

		log.info("등록일 {}", dateString);
		boardVO.setBoardDate(new Date(System.currentTimeMillis()));

		log.info("##########  boardVO : {}", boardVO);

		flag = svc.updateBoard(boardVO);

		if (flag == false) {
			msg+="글 수정에 실패하였습니다.";
		} else {
			msg+="글수정에 성공하였습니다.";
		}

		return msg;
	} //

	/*------------------ 공지사항 게시판 --------------------*/
	@RequestMapping("/notice/writeNoticeForm.do")
	public String writeNoticeForm(Model model) {

		log.info("writeNoticeForm");

		model.addAttribute("noticeVO", new NoticeDTO());

		return "/notice/writeNoticeForm";
	}

	@RequestMapping(value="/notice/writeNoticeProc.do",
			method = RequestMethod.POST,
			produces = "text/plain; charset=UTF-8")
	public String writeNoticeNoticeProc(@ModelAttribute("noticeDTO") NoticeDTO noticeDTO) {

		log.info("############# writeNoticeProc ##################");

		log.info("VO : {}", noticeDTO);

		MultipartFile file = noticeDTO.getBoardFile(); // 업로드 파일
		FileOutputStream fos = null;
		String fileName = null;

		// 업로드 파일 처리
		if  (!noticeDTO.getBoardFile().isEmpty() && file != null) { // 파일 유효성 점검

			fileName = file.getOriginalFilename();

			try {
				byte[] bytes = file.getBytes();

				File outFileName
				= new File(uploadDirResource.getPath() + fileName);
				fos = new FileOutputStream(outFileName);

				fos.write(bytes);

			} catch (IOException e) {
				log.info("BoardController save File writing error ! ");
				e.printStackTrace();
			} finally {
				try {    
					if (fos !=null) fos.close();
				} catch (IOException e) {
					log.info("BoardController save IOE : ");
					e.printStackTrace();
				}
				log.info("File upload success! ");
			} // try

		} // 업로드 파일 처리

		NoticeVO noticeVO = new NoticeVO(noticeDTO);
		noticeVO.setBoardReRef(noticeDTO.getBoardNum());
		noticeVO.setBoardFile(!noticeDTO.getBoardFile().isEmpty() && file != null ? fileName : "");

		log.info("############### noticeVO : {}", noticeVO);

		svc.writeNotice(noticeVO);

		return "/home";
	} //

	@RequestMapping(value="/notice/viewNotice.do/{boardNum}",
			method = RequestMethod.GET,
			produces = "text/plain; charset=UTF-8")
	public String writeNoticeProc(@PathVariable("boardNum") int boardNum, Model model) {
	
		NoticeVO notice = svc.selectNotice(boardNum);
		log.info("############### viewNotice.do : {}", notice);
	
		model.addAttribute("notice", notice);
	
		return "/notice/viewNotice";
	}

	// 공지사항 목록
	@RequestMapping("/notice/noticeList.do/{page}")
	public String listNotice(@PathVariable("page") int page,
							 Model model) {
	
		int limit = 10; // 페이지당 글수
		List<NoticeVO> articleList;
	
		page = page!=0 ? page : 1; // page 설정
	
		// 총페이지수
		int listCount = svc.getListNotice();
	
		articleList= svc.getNoticeList(page, limit);
	
		// 총 페이지 수
		int maxPage=(int)((double)listCount/limit+0.95); //0.95를 더해서 올림 처리
		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21,...)
		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		int endPage = startPage + 10 - 1;
	
		if (endPage> maxPage) endPage= maxPage;
	
		PageVO pageVO = new PageVO();
		pageVO.setEndPage(endPage);
		pageVO.setListCount(listCount);
		pageVO.setMaxPage(maxPage);
		pageVO.setPage(page);
		pageVO.setStartPage(startPage);
	
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("articleList", articleList);
	
		return "/notice/noticeList";
	} //

	// JSON Feed Service : 개별 게시글 보기
	@RequestMapping(value="/notice/noticeDetailJSON.do/boardNum/{boardNum}",
			produces="application/json; charset=UTF-8")
	@ResponseBody
	public String noticeDetailFeed(@PathVariable("boardNum") int boardNum) 
	{
		log.info("noticeDetailFeed");

		// 조회수 업데이트
		svc.noticeReadCount(boardNum);

		String json="";
		ObjectMapper mapper = new ObjectMapper();
		NoticeVO notice = svc.selectNotice(boardNum);

		try {
			json = mapper.writeValueAsString(notice);

		} catch (JsonProcessingException e) {
			log.debug("json exception !");
			e.printStackTrace();
		}

		return json;
	} //

	@RequestMapping("/notice/replyWriteNoticeProc.do")
	@ResponseBody
	public String replyWriteNoticeProc(NoticeVO noticeVO) { 

		log.info("############## replyWriteNoticeProc.do ################");

		log.info("########### noticeVO : "+ noticeVO.toString());

		boolean msg = false;

		// 답글 등록 관련 변수
		int reRef = noticeVO.getBoardReRef(); // 댓글의 원 게시글 번호
		int reLev = noticeVO.getBoardReLev(); // 댓글의 레벨
		int reSeq = noticeVO.getBoardReSeq(); // 댓글의 순서

		svc.updateNoticeByRefAndSeq(reRef, reSeq);

		// 답글 관련 인자 계산
		reSeq = reSeq + 1;
		reLev = reLev + 1;

		noticeVO.setBoardReSeq(reSeq);
		noticeVO.setBoardReLev(reLev);

		msg = svc.replyWriteNotice(noticeVO);

		return msg+"";
	}

	@RequestMapping(value="/notice/updateNotice.do/{boardNum}", 
			produces="text/html; charset=UTF-8")
	@ResponseBody
	public String updateNotice(@PathVariable("boardNum") int boardNum,
							   @RequestParam(value="update_boardFile_new", required=false) MultipartFile file,
							   HttpServletRequest req) {

		log.info("########### updateNotice ############");

		String msg = "";
		boolean flag = false; // 업데이트 성공여부 플래그 추가

		if (req.getParameter("update_boardSubject") == null || 
				req.getParameter("update_boardSubject").equals(""))
			msg += "글제목을 입력하십시오.\n";

		if (req.getParameter("update_boardContent") == null || 
				req.getParameter("update_boardContent").equals(""))
			msg += "글내용을 입력하십시오.";

		if (!msg.equals("")) return msg; // 오류 있으면 메시지 전송

		log.info("msg : {}", msg);

		// 인자 출력
		log.info("update_boardNum : {}", req.getParameter("update_boardNum"));
		log.info("update_boardName : {}", req.getParameter("update_boardName"));
		log.info("update_boardSub : {}", req.getParameter("update_boardSub"));
		log.info("update_boardContent : {}", req.getParameter("update_boardContent"));

		// log.info("fileName : {}", file.getOriginalFilename());

		// 기존 정보 가져오기
		NoticeVO noticeVO = new NoticeVO(); // 갱신할 VO
		NoticeVO oldNoticeVO = svc.selectNotice(boardNum);
		noticeVO = oldNoticeVO; // 

		// 게시글 수정
		noticeVO.setBoardNum(boardNum);
		noticeVO.setBoardName(req.getParameter("update_boardName"));
		noticeVO.setBoardSub(req.getParameter("update_boardSub"));
		noticeVO.setBoardContent(req.getParameter("update_boardContent"));

		// 주의) 편의상 다른 게시글에서도 동일한 첨부가 있을 경우 문제가 되므로 
		//      기존 파일 삭제는 생략하였습니다. 이러한 경우는 파일 업로드시 계정별 폴더 세분화     
		//      혹은 업로드 파일마다 접미사(순번 등) 등을 이용하여 처리할 수 있습니다.
		// 기존 파일과 비교
		// 추가) 첨부 파일 없을 경우(답글 수정시) 조건 추가 
		if (file==null ||
				file.getOriginalFilename()==null || 
				file.getOriginalFilename().equals("")) {

			log.info("############ 신규 첨부 파일 없을 때 ############");

			// 기존 파일 저장
			noticeVO.setBoardFile(oldNoticeVO.getBoardFile());

			// 추가 : 첨부 파일이 애시당초 없을 경우
			if (file==null) noticeVO.setBoardFile("");

		} else {

			log.info("fileName : {}", file.getOriginalFilename());

			noticeVO.setBoardFile(file.getOriginalFilename());

			// 파일 저장소에 새 파일 저장(시작)
			if  (!noticeVO.getBoardFile().isEmpty() && file != null) { // 파일 유효성 점검

				String fileName = file.getOriginalFilename();

				FileOutputStream fos = null;

				try {
					// 업로드 파일 형식 변환(시작)
					fileName = fileNamingSvc.parseFilePostfix(boardNum, fileName);
					log.info("실제 업로드 파일명 : {}", fileName);

					noticeVO.setBoardFile(fileName);
					// 업로드 파일 형식 변환(끝)

					byte[] bytes = file.getBytes();

					File outFileName
					= new File(uploadDirResource.getPath() + fileName);
					fos = new FileOutputStream(outFileName);

					fos.write(bytes);

				} catch (IOException e) {
					log.info("BoardUpdateController update File writing error ! ");
					e.printStackTrace();
				} finally {
					try {    
						if (fos !=null) fos.close();
					} catch (IOException e) {
						log.info("BoardUpdateController update IOE : ");
						e.printStackTrace();
					}
					log.info("File upload success! ");
				} // try

			} // 업로드 파일 처리
			// 파일 저장소에 새 파일 저장(끝)
		} //

		// 게시글 갱신 등록일 : 12시간 기준 hh: -> 24시간 기준으로 변경 HH:
		String dateString 
		= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		.format(new Date(System.currentTimeMillis())).toString();

		log.info("등록일 {}", dateString);
		noticeVO.setBoardDate(new Date(System.currentTimeMillis()));

		log.info("##########  noticeVO : {}", noticeVO);

		flag = svc.updateNotice(noticeVO);

		if (flag == false) {
			msg+="글 수정에 실패하였습니다.";
		} else {
			msg+="글수정에 성공하였습니다.";
		}

		return msg;
	} //
	
}