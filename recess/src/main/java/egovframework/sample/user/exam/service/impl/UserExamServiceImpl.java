package egovframework.sample.user.exam.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.sample.user.exam.service.UserExamService;

@Service("userExamService")
@Transactional
public class UserExamServiceImpl implements UserExamService {

	@Resource(name="userExamMapper")
	UserExamMapper userExamMapper;
	
	
	
}
