package egovframework.sample.user.exam.service;

import org.springframework.ui.ModelMap;

import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;

public interface UserExamService {

	public ModelMap getExamData(UserExamVo userExamVo);

	public int getExamResultListDataCnt(UserExamResultVo userExamResultVo);

	public String getExamOnOffCheck(UserExamVo userExamVo);

	public void setExamResultData(UserExamResultVo userExamResultVo);

}
