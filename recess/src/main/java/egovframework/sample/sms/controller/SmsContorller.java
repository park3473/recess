package egovframework.sample.sms.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.sample.sms.model.SmsVo;
import egovframework.sample.sms.service.SmsService;

@Controller
public class SmsContorller {

	@Autowired
	SmsService smsService;
	
	@RequestMapping(value="/view/sms/send.do" , method = RequestMethod.POST)
	public void SmsSend(@ModelAttribute("SmsVo")SmsVo SmsVo , HttpServletRequest request , HttpServletResponse response) throws IOException , NoSuchAlgorithmException{
		
		System.out.println("문자 보내기 start");
		System.out.println("문자 보낼 내용 : " + SmsVo.getMESSAGE());
		smsService.SmsSend(SmsVo);
		System.out.println("문자 보내기 종료");
		
	}
	
}
