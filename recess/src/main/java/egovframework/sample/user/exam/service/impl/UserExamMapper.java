package egovframework.sample.user.exam.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.ModelMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.sample.admin.product.model.AdminProductListVo;
import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;

@Mapper("userExamMapper")
public interface UserExamMapper {

	List<HashMap<String, Object>> getExamData(UserExamVo userExamVo);

	int getExamResultListDataCnt(UserExamResultVo userExamResultVo);

	String getExamOnOffCheck(UserExamVo userExamVo);

	void setExamResultData(UserExamResultVo userExamResultVo);

	List<?> getExamResultList(UserExamResultVo userExamResultVo);

	UserExamResultVo getExamResultListData(UserExamResultVo userExamResultVo);

	List<?> getExamResultProduct(UserExamResultVo userExamResultVo);

	void setExamResultScorePlus(UserExamResultVo userExamResultVo);

	int getExamResultCnt(UserExamResultVo userExamResultVo);

	
}
