/**
 * 
 */
package com.javateam.SpringPage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.SpringPage.service.AuthMyBatisService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author javateam
 *
 */
@Service
@Slf4j
public class FileUploadNamingServiceImpl implements FileUploadNamingService {
	
	/**
	 * @see com.javateam.springBoard.util.FileUploadNamingService
	 * #parseFilePostfix(int, java.lang.String)
	 */
	@Override
	public String parseFilePostfix(int boardNum, String file) {

		log.info("파일 접미어 처리");
		// 본 파일명과 확장자 분리 처리
		String[] fileStr = file.split("\\."); 
		String fileName = fileStr[0];
		String fileExt = fileStr[1];
		
		// 업로드 파일명 형성
		return fileName + "_" 
			   + boardNum  
			   + "." + fileExt;
	} //

}
