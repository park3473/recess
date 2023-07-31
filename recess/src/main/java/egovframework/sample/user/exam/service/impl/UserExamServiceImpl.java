package egovframework.sample.user.exam.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import egovframework.sample.admin.product.model.AdminProductListVo;
import egovframework.sample.user.exam.model.UserExamResultVo;
import egovframework.sample.user.exam.model.UserExamVo;
import egovframework.sample.user.exam.service.UserExamService;

@Service("userExamService")
@Transactional
public class UserExamServiceImpl implements UserExamService {

	@Resource(name="userExamMapper")
	UserExamMapper userExamMapper;

	@Override
	public ModelMap getExamData(UserExamVo userExamVo) {
		
		ModelMap model = new ModelMap();
		
		List<HashMap<String, Object>> list = userExamMapper.getExamData(userExamVo);
		
		model.put("list", list);
		
		return model;
	}

	@Override
	public int getExamResultListDataCnt(UserExamResultVo userExamResultVo) {
		
		int cnt = userExamMapper.getExamResultListDataCnt(userExamResultVo);
		
		return cnt;
	}

	@Override
	public String getExamOnOffCheck(UserExamVo userExamVo) {
		
		String result = userExamMapper.getExamOnOffCheck(userExamVo);
		
		return result;
	}

	@Override
	public String setExamResultData(UserExamResultVo userExamResultVo) {
		
		userExamMapper.setExamResultData(userExamResultVo);
		
		String idx = userExamResultVo.getIdx();
		
		return idx;
		
	}

	@Override
	public ModelMap getExamResultList(UserExamResultVo userExamResultVo) {
		
		ModelMap model = new ModelMap();
		
		List<?> list = userExamMapper.getExamResultList(userExamResultVo);
		
		model.put("list", list);
		
		return model;
	}

	@Override
	public ModelMap getExamResultListData(UserExamResultVo userExamResultVo) {
		
		ModelMap model = new ModelMap();
		
		UserExamResultVo view = new UserExamResultVo();
		
		view = userExamMapper.getExamResultListData(userExamResultVo);
		
		model.put("view", view);
		
		return model;
	}

	//상품관련
	@Override
	public List<?> getExamResultProduct(UserExamResultVo userExamResultVo) {
		// TODO Auto-generated method stub
		List<?> list = userExamMapper.getExamResultProduct(userExamResultVo);
		
		return list;
	}

	
	
	
}
