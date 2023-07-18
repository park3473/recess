package egovframework.sample.admin.product.contorller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.sample.admin.product.model.AdminProductVo;
import egovframework.sample.admin.product.service.AdminProductService;

@Controller
public class AdminProductContorller {

	@Autowired
	AdminProductService adminProductService;
	
	
	@RequestMapping(value="/admin/product/list.do" , method = RequestMethod.GET)
	public ModelAndView AdminProductListGet(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo ,HttpServletRequest request , HttpServletResponse response) {
		
		System.out.println("PAGE : " + AdminProductVo.getPAGE());
		System.out.println("ITEM_COUNT : " + AdminProductVo.getITEM_COUNT());
		
		String PAGE = request.getParameter("PAGE") != null ? request
				.getParameter("PAGE") : "0";
		String ITEM_COUNT = request.getParameter("ITEM_COUNT") != null ? request
				.getParameter("ITEM_COUNT") : "10";
		
		AdminProductVo.setPAGE(Integer.parseInt(PAGE));
		AdminProductVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		
		int pagelimit = AdminProductVo.getPAGE() * AdminProductVo.getITEM_COUNT();
		
		AdminProductVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		AdminProductVo.setOFFSET(pagelimit);
		
		ModelMap model = new ModelMap();
		
		model = adminProductService.getAllList(AdminProductVo);
		
		model.put("before", AdminProductVo);
		
		return new ModelAndView("admin/product/list" , "model" , model);
		
	}
	
	
	
}
