package com.javateam.SpringPage.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PagingVO {

	private int curPage = 1;// 현재 페이지
    private int startPage = 1;// 시작 페이지
    private int endPage = 1;// 마지막 페이지
    private int rowPerPage = 10;// 페이지별 글수
    private int totPage = 0;// 총 페이지
    private int prePage = 0;// 이전 페이지
    private int nextPage = 0;// 다음 페이지
    
    public PagingVO(int curPage, int rowPerPage) {
        this.curPage = curPage;
        this.rowPerPage = rowPerPage;
    }
}
