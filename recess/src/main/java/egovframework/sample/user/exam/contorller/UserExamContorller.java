package egovframework.sample.user.exam.contorller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import egovframework.sample.user.exam.service.UserExamService;

@Controller
public class UserExamContorller {

	@Autowired
	UserExamService userExamService;
	
	
}
