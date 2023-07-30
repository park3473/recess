package egovframework.sample.user.exam.contorller;

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

import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;
import egovframework.sample.user.exam.service.UserExamService;
import egovframework.sample.user.member.model.UserMemberVo;
import egovframework.sample.user.member.service.UserMemberService;

@Controller
public class UserExamContorller {

	@Autowired
	UserExamService userExamService;
	
	@Autowired
	UserMemberService userMemberService;
	
	
	@RequestMapping(value="/view/exam/login.do" , method = RequestMethod.GET)
	public String UserExamLoginGet(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		return "view/exam/login";
		
	}
	
	@RequestMapping(value="/view/exam/login.do" , method = RequestMethod.POST)
	public int UserExamLoginPOST(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		//해당 기록이 있는지 확인
		System.out.println("NAME : " + UserExamResultVo.getName());
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
	
	@RequestMapping(value="/view/exam/exam.do" , method = RequestMethod.GET)
	public ModelAndView UserExamExam(@ModelAttribute("UserExamVo")UserExamVo UserExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = userExamService.getExamData(UserExamVo);
		
		return new ModelAndView("view/exam/exam" , "model" , model);
		
	}
	
	@RequestMapping(value="/view/exam/insert.do" , method = RequestMethod.POST)
	public String UserExamResultInsert(@ModelAttribute("UserExamResultVo")UserExamResultVo UserExamResultVo , HttpServletRequest request , HttpServletResponse response) {
		
		userExamService.setExamResultData(UserExamResultVo);
		
		return "view/exam/insert";
	}
	
}
