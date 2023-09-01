package egovframework.sample.user.exam.contorller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.sample.sms.model.SmsVo;
import egovframework.sample.sms.service.SmsService;
import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;
import egovframework.sample.user.exam.service.UserExamService;
import egovframework.sample.user.member.service.UserMemberService;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@Controller
public class UserExamContorller {

	@Autowired
	UserExamService userExamService;
	
	@Autowired
	UserMemberService userMemberService;
	
	@Autowired
	SmsService smsService;
	
	
	@RequestMapping(value="/view/exam/login.do" , method = RequestMethod.GET)
	public String UserExamLoginGet(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		return "view/exam/login";
		
	}
	
	@RequestMapping(value="/view/exam/login.do" , method = RequestMethod.POST)
	public int UserExamLoginPOST(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		//해당 기록이 있는지 확인
		System.out.println("PHONE" +UserExamResultVo.getPhone());
		
		int cnt = userExamService.getExamResultListDataCnt(UserExamResultVo);
		
		return cnt;
		
	}
	
	//해당 자가진단 ONOFF 확인
	@ResponseBody
	@RequestMapping(value="/view/exam/check.do" , method = RequestMethod.POST , produces = "application/json; charset=utf8" )
	public String UserExamCheck(@ModelAttribute("UserExamVo")UserExamVo UserExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		String result = userExamService.getExamOnOffCheck(UserExamVo);
		
		return result;
		
	}
	
	//자가진단
	@RequestMapping(value="/view/exam/exam.do" , method = RequestMethod.GET)
	public ModelAndView UserExamExam(@ModelAttribute("UserExamVo")UserExamVo UserExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = userExamService.getExamData(UserExamVo);
		
		model.put("idx", UserExamVo.getIdx());
		
		return new ModelAndView("view/exam/exam" , "model" , model);
		
	}
	
	//진단 내용 저장
	@RequestMapping(value="/view/exam/insert.do" , method = RequestMethod.POST)
	public ModelAndView UserExamResultInsert(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		String idx = userExamService.setExamResultData(UserExamResultVo);
		
		UserExamResultVo.setIdx(idx);
		
		model.put("before", UserExamResultVo);
		
		return new ModelAndView("view/exam/result_check" , "model" , model);
	}
	
	//점수 추가 부분
	@RequestMapping(value="/view/exam/score_plus.do" , method = RequestMethod.POST)
	public void UserExamResultScorePlus(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		userExamService.setExamResultScorePlus(UserExamResultVo);
		
	}
	
	//진단 결과 내용 보기 - 휴식 시간  , 인센티브 선택
	@RequestMapping(value="/view/exam/result_view.do" , method = RequestMethod.POST)
	public ModelAndView UserExamResultListData(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		//결과 내용
		model = userExamService.getExamResultListData(UserExamResultVo);
		
		//진단 상품
		List<?> ProductList = userExamService.getExamResultProduct(UserExamResultVo);
		
		model.put("ProductList", ProductList);
		
		return new ModelAndView("view/exam/result_view" , "model" , model);
		
	}
	
	//진단 결과 상품 문자 수령
	@RequestMapping(value="/view/exam/result_select.do" , method = RequestMethod.POST)
	public void UserExamResultSelectPost(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , @ModelAttribute("SmsVo")SmsVo SmsVo , HttpServletRequest request , HttpServletResponse response) throws NoSuchAlgorithmException, IOException {
	
		System.out.println("문자 메세지 : " + SmsVo.getMESSAGE());
		System.out.println("문자 수신 번호 : " + SmsVo.getPHONE());
		System.out.println("문자 타입 : " + SmsVo.getSMS_TYPE() + SmsVo.getTYPE());
		System.out.println("휴식 시간(분) : " + SmsVo.getRESERVATION_TM());
		
		//보낼 시간 설정
        // 현재 날짜와 시간을 가져옴
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

        // RESERVATION_TM 값
        String RESERVATION_TM = SmsVo.getRESERVATION_TM();

        // 분을 더할 값 (RESERVATION_TM)을 Integer로 변환
        int Add = Integer.parseInt(RESERVATION_TM);

        // 현재 시간에 분을 더함
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MINUTE, Add);

        // 더해진 시간을 가져옴
        Date newDate = calendar.getTime();

        // 더해진 날짜와 시간을 문자열로 변환
        String newDateString = dateFormat.format(newDate);
        String newTimeString = timeFormat.format(newDate);
        
        //변경된 날짜 및 시간
        System.out.println("새로운 날짜: " + newDateString);
        System.out.println("새로운 시간: " + newTimeString);
    
        //Sms 담기전 폼 변환 ( - , : 제거)
        newDateString = newDateString.replaceAll("-", "");
        newTimeString = newTimeString.replaceAll(":", "");
        
        //Sms 담기
        SmsVo.setRESERVATION_DT(newDateString);
        SmsVo.setRESERVATION_TM(newTimeString);
        
        //문자 전송
        smsService.SmsSend(SmsVo);
		
	}
	
	@RequestMapping(value="/view/exam/resultcnt.do" , method = RequestMethod.POST , produces = "application/json; charset=utf8")
	@ResponseBody
	public String ExamResultcnt(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo ,HttpServletRequest request , HttpServletResponse response) {
		
		String result = "";
		
		result = userExamService.getExamResultCnt(UserExamResultVo);
		
		return result;
		
	}
	
	
	
}
