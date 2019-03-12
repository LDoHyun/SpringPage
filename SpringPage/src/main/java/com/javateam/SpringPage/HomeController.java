package com.javateam.SpringPage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	@RequestMapping("/")
	public String home() {
		
		log.info("##################################### home");
	
		return "redirect:/home";
	}
	
}
