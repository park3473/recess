package egovframework.sample.admin.product.contorller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.system.util.SUtil;

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
	
	@RequestMapping(value="/admin/product/insert.do" , method = RequestMethod.GET)
	public String AdminProductInsertGet(HttpServletRequest request , HttpServletResponse response) {
		
		return "admin/product/insert";
		
	}
	
	@RequestMapping(value="/admin/product/insert.do" , method = RequestMethod.POST)
	public void AdminProductInsertPost(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo , MultipartHttpServletRequest request , HttpServletResponse response) throws IOException {
		
		if(AdminProductVo.getImage_change_bool().equals("ture")) {
			
			String drv = request.getRealPath("");
			drv = drv.substring(0 , drv.length()) + "./resources/" + ((HttpServletRequest) request).getContextPath() + "/upload/product/image/";
			
			String filename = SUtil.setFileUpload(request, drv);
			
			AdminProductVo.setImage(filename);
			
		}
		
		adminProductService.setProductData(AdminProductVo , "insert");
		
		SUtil.AlertAndPageMove(response, "상품이 추가 되었습니다.", "/admin/product/list.do");
		
	}
	
	@RequestMapping(value="/admin/product/update.do" , method = RequestMethod.GET)
	public ModelAndView AdminProductUpdateGet(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = adminProductService.getProductData(AdminProductVo);
		
		return new ModelAndView("admin/product/update" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/product/update.do" , method = RequestMethod.POST)
	public void AdminProductUpdatePost(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo , MultipartHttpServletRequest request , HttpServletResponse response) throws IOException {
		
		if(AdminProductVo.getImage_change_bool().equals("ture")) {
			
			String drv = request.getRealPath("");
			drv = drv.substring(0 , drv.length()) + "./resources/" + ((HttpServletRequest) request).getContextPath() + "/upload/product/image/";
			
			String filename = SUtil.setFileUpload(request, drv);
			
			AdminProductVo.setImage(filename);
			
		}
		
		adminProductService.setProductData(AdminProductVo , "update");
		
		SUtil.AlertAndPageMove(response, "상품이 수정 되었습니다.", "/admin/product/list.do");
		
	}
	
	@RequestMapping(value="/admin/product/delete.do" , method = RequestMethod.POST)
	public void AdminProductDeletePost(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		adminProductService.setProductData(AdminProductVo , "delete");
		
		SUtil.AlertAndPageMove(response, "상품이 삭제 되었습니다.", "/admin/product/list.do");
		
	}
	
	
	
}
