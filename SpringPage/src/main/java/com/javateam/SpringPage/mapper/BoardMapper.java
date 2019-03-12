package com.javateam.SpringPage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.javateam.SpringPage.vo.BoardVO;
import com.javateam.SpringPage.vo.NoticeVO;
import com.javateam.SpringPage.vo.PagingVO;

public interface BoardMapper {
	
	// 게시판 글 등록
	void writeBoard(BoardVO boardVO);
	// 게시글 조회
	BoardVO selectBoard(int boardNum);
	// 게시판 페이지
	List<BoardVO> getArticleList(@Param("page") int page, 
								 @Param("rowsPerPage") int rowsPerPage);
	// 전체 게시글 수정
	int getListCount();
	// 게시글 조회수 업데이트
	void updateReadCount(int boardNum);
	// 게시글 수정
	void updateBoard(BoardVO boardVO);
	// 댓글 쓰기
	void replyWriteBoard(BoardVO boardVO);
	// 게시글 댓글
	void updateBoardByRefAndSeq(@Param("boardReRef") int boardReRef, 
								@Param("boardReSeq") int boardReSeq);
	
	// 공지사항 페이징
	List<NoticeVO> getNoticeList(@Param("page") int page, 
								 @Param("rowsPerPage") int rowsPerPage);
	// 전체 공지사항 수정
	int getListNotice();
	// 공지사항 조회수 업데이트
	void noticeReadCount(int boardNum);
	// 공지사항 글 등록
	void writeNotice(NoticeVO noticeVO);
	// 공지사항 조회
	NoticeVO selectNotice(int boardNum);
	// 공지사항 수정
	boolean updateNotice(NoticeVO noticeVO);
	// 공지사항 페이징
	boolean replyWriteNotice(NoticeVO noticeVO);
	// 공지사항 댓글
	void updateNoticeByRefAndSeq(@Param("boardReRef") int boardReRef, 
								 @Param("boardReSeq") int boardReSeq);
}
