package com.javateam.SpringPage.vo;

import java.util.Date;

import javax.persistence.Entity;

import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor

public class NoticeVO {
	private int boardNum;
    private String boardName; // 작성자 이름
    private String boardPass; // 게시글 비밀번호
    private String boardSub; // 게시글 제목
    private String boardContent; // 내용
    private String boardFile; // 첨부파일
    private int boardReRef; // 답글참조번호
    private int boardReLev; // 답글 레벨
    private int boardReSeq; // 답글 시퀀스(번호)
    private int boardReadCount; // 게시글 조회수
    private Date boardDate; //게시글 날짜
    
    public NoticeVO(NoticeDTO notice) {
    	
    	this.boardNum = notice.getBoardNum();
        this.boardName = notice.getBoardName();
        this.boardPass = notice.getBoardPass();
        this.boardSub = notice.getBoardSub();
        this.boardContent = notice.getBoardContent();
        this.boardFile = notice.getBoardFile().getOriginalFilename(); // 파일명 저장
        this.boardReRef = notice.getBoardReRef();
        this.boardReLev = notice.getBoardReLev();
        this.boardReSeq = notice.getBoardReSeq();
        this.boardReadCount = notice.getBoardReadCount();
        this.boardDate = notice.getBoardDate();
    }
}
