package egovframework.sample.admin.product.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.sample.admin.product.model.AdminProductVo;

@Mapper("adminProductMapper")
public interface AdminProductMapper {

	List<?> getAllList(AdminProductVo adminProductVo);

	int getAllListCnt(AdminProductVo adminProductVo);

	
	
}
