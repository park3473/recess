package egovframework.sample.admin.product.service;

import org.springframework.ui.ModelMap;

import egovframework.sample.admin.product.model.AdminProductVo;

public interface AdminProductService {

	ModelMap getAllList(AdminProductVo adminProductVo);

}
