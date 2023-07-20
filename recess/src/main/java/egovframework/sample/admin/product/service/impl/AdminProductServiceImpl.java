package egovframework.sample.admin.product.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.system.util.PageVO;

import egovframework.sample.admin.product.model.AdminProductVo;
import egovframework.sample.admin.product.service.AdminProductService;

@Service("adminProductService")
@Transactional
public class AdminProductServiceImpl implements AdminProductService {

	@Resource(name="adminProductMapper")
	AdminProductMapper adminProductMapper;

	@Override
	public ModelMap getAllList(AdminProductVo adminProductVo) {
		
		ModelMap modelMap = new ModelMap();
		
		List<?> list = adminProductMapper.getAllList(adminProductVo);
		
		System.out.println("size : " + list.size());
		int itemtotalcount = adminProductMapper.getAllListCnt(adminProductVo);
		int itemcount = adminProductVo.getITEM_COUNT();
		int itempage = adminProductVo.getITEM_PAGE();
		
		PageVO pageVo = new PageVO(itemcount , itemtotalcount , itempage);
		
		if(pageVo.isItempagenext() == true){
			modelMap.put("itempagenext", "true");
		}else {
			modelMap.put("itempagenext", "false");
		}
		
		System.out.println(pageVo.getItempage());
		modelMap.put("itemcount", pageVo.getItemCount());
		modelMap.put("itempagestart", pageVo.getItempagestart());
		modelMap.put("itempageend", pageVo.getItempageend());
		modelMap.put("itemtotalcount", pageVo.getItemtotalcount());
		modelMap.put("itemtotalpage", pageVo.getItemtotalpage());
		
		modelMap.put("list", list);
		
		return modelMap;
	}

	@Override
	public void setProductData(AdminProductVo adminProductVo, String type) {
		
		switch (type) {
		case "insert":
			adminProductMapper.setProductDataInsert(adminProductVo);
			break;
		case "update":
			adminProductMapper.setProductDataUpdate(adminProductVo);
			break;
		case "delete":
			adminProductMapper.setProductDataDelete(adminProductVo);
			break;
		}
		
	}

	@Override
	public ModelMap getProductData(AdminProductVo adminProductVo) {
		
		ModelMap model = new ModelMap();
		
		AdminProductVo view = adminProductMapper.getProductData(adminProductVo);
		
		model.put("view", view);
		
		return model;
	}
	
}
