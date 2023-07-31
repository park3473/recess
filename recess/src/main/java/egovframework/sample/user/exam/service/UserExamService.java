package egovframework.sample.user.exam.service;

import java.util.List;

import org.springframework.ui.ModelMap;

import egovframework.sample.admin.product.model.AdminProductListVo;
import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;

public interface UserExamService {

	public ModelMap getExamData(UserExamVo userExamVo);

	public int getExamResultListDataCnt(UserExamResultVo userExamResultVo);

	public String getExamOnOffCheck(UserExamVo userExamVo);

	public String setExamResultData(UserExamResultVo userExamResultVo);

	public ModelMap getExamResultList(UserExamResultVo userExamResultVo);

	public ModelMap getExamResultListData(UserExamResultVo userExamResultVo);

	public List<?> getExamResultProduct(UserExamResultVo userExamResultVo);


}
