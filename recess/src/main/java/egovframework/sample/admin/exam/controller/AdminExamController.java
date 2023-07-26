package egovframework.sample.admin.exam.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.system.util.SUtil;

import egovframework.sample.admin.exam.model.AdminExamVo;
import egovframework.sample.admin.exam.service.AdminExamService;
import egovframework.sample.admin.product.model.AdminProductListVo;
import egovframework.sample.admin.product.model.AdminProductVo;
import egovframework.sample.admin.product.service.AdminProductService;
import egovframework.sample.admin.question.model.AdminQuestionListVo;

@Controller
public class AdminExamController {

	@Autowired
	AdminExamService adminExamService;

	@Autowired
	AdminProductService adminProductService;
	
	//EXAM
	@RequestMapping(value="/admin/exam/list.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamListGet(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		System.out.println("PAGE : " + AdminExamVo.getPAGE());
		System.out.println("ITEM_COUNT : " + AdminExamVo.getITEM_COUNT());
		
		String PAGE = request.getParameter("PAGE") != null ? request
				.getParameter("PAGE") : "0";
		String ITEM_COUNT = request.getParameter("ITEM_COUNT") != null ? request
				.getParameter("ITEM_COUNT") : "10";
		
		AdminExamVo.setPAGE(Integer.parseInt(PAGE));
		AdminExamVo.setITEM_COUNT(Integer.parseInt(ITEM_COUNT));
		
		int pagelimit = AdminExamVo.getPAGE() * AdminExamVo.getITEM_COUNT();
		
		AdminExamVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		AdminExamVo.setOFFSET(pagelimit);
		
		ModelMap model = new ModelMap();
		
		model = adminExamService.getAllList(AdminExamVo);
		
		model.put("before", AdminExamVo);
		
		return new ModelAndView("admin/exam/list" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/exam/insert.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamInsertGet(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		
		return new ModelAndView("admin/exam/insert" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/exam/insert.do", method = RequestMethod.POST)
	public void AdminExamInsertPost(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		adminExamService.setAdminExamData(AdminExamVo , "insert");
		
		SUtil.AlertAndPageMove(response, "해당 자가진단이 등록되었습니다.", "/admin/exam/list.do");
	
	}
	
	@RequestMapping(value="/admin/exam/update.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamUpdateGet(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = adminExamService.getExamView(AdminExamVo);
		
		return new ModelAndView("admin/exam/update" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/exam/update.do", method = RequestMethod.POST)
	public void AdminExamUpdatePost(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		adminExamService.setAdminExamData(AdminExamVo , "update");
		
		SUtil.AlertAndPageMove(response, "해당 자가진단이 수정되었습니다.", "/admin/exam/list.do");
		
	}
	
	@RequestMapping(value="/admin/exam/delete.do" , method = RequestMethod.POST)
	public void AdminExamDeletePost(@ModelAttribute("AdminExamVo")AdminExamVo AdminExamVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		//자가진단 폼 삭제 (해당 자가진단 참가한 인원 있을시 삭제 X)
		adminExamService.setAdminExamData(AdminExamVo, "delete");
		
		//해당 문항 및 답안 삭제
		SUtil.AlertAndPageMove(response, "해당 자가진단이 삭제 되었습니다.", "/admin/exam/list.do");
		
	}
	
	
	//QUESTION_LIST 부분
	@RequestMapping(value="/admin/exam/question_list.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamQuestionList(@ModelAttribute("AdminQuestionListVo")AdminQuestionListVo AdminQuestionListVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = adminExamService.getQuestionList(AdminQuestionListVo);
		
		model.put("exam_idx", AdminQuestionListVo.getExam_idx());
		
		return new ModelAndView("admin/exam/question_list" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/exam/question_list/insert.do" , method = RequestMethod.POST)
	public void AdminExamQuestionListInsert(@ModelAttribute("AdminQuestionListVo")AdminQuestionListVo AdminQuestionListVo , HttpServletRequest request , HttpServletResponse response) {
		
		adminExamService.setAdminExamQuestionList(AdminQuestionListVo , "insert");
		
	}
	
	@RequestMapping(value="/admin/exam/question_list/update.do" , method = RequestMethod.POST)
	public void AdminExamQuestionListUpdate(@ModelAttribute("AdminQuestionListVo")AdminQuestionListVo AdminQuestionListVo , HttpServletRequest request , HttpServletResponse response) {
		
		adminExamService.setAdminExamQuestionList(AdminQuestionListVo , "update");
		
	}
	
	@RequestMapping(value="/admin/exam/question_list/delete.do" , method = RequestMethod.POST)
	public void AdminExamQuestionListDelete(@ModelAttribute("AdminQuestionListVo")AdminQuestionListVo AdminQuestionListVo , HttpServletRequest request , HttpServletResponse response) {
		
		adminExamService.setAdminExamQuestionList(AdminQuestionListVo , "delete");
		
	}
	
	//PRODUCT_LIST 부분
	@RequestMapping(value="/admin/exam/product_list.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamProductList(@ModelAttribute("AdminProductListVo")AdminProductListVo AdminProductListVo , HttpServletRequest request , HttpServletResponse response) {
		
		ModelMap model = new ModelMap();
		
		model = adminExamService.getProductList(AdminProductListVo);
		
		model.put("exam_idx", AdminProductListVo.getExam_idx());
		
		return new ModelAndView("admin/exam/product_list" , "model" , model); 
		
	}
	
	@RequestMapping(value="/admin/exam/product_list/select.do" , method = RequestMethod.GET)
	public ModelAndView AdminExamProductSelect(@ModelAttribute("AdminProductVo")AdminProductVo AdminProductVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		System.out.println("PAGE : " + AdminProductVo.getPAGE());
		System.out.println("ITEM_COUNT : " + AdminProductVo.getITEM_COUNT());
		
		String PAGE = request.getParameter("PAGE") != null ? request
				.getParameter("PAGE") : "0";
		String ITEM_COUNT = request.getParameter("ITEM_COUNT") != null ? request
				.getParameter("ITEM_COUNT") : "5";
		
		AdminProductVo.setPAGE(Integer.parseInt(PAGE));
		AdminProductVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		
		int pagelimit = AdminProductVo.getPAGE() * AdminProductVo.getITEM_COUNT();
		
		AdminProductVo.setLIMIT(Integer.parseInt(ITEM_COUNT));
		AdminProductVo.setOFFSET(pagelimit);
		
		ModelMap model = new ModelMap();
		
		model = adminProductService.getAllList(AdminProductVo);
		
		model.put("before", AdminProductVo);
		
		return new ModelAndView("admin/exam/product_select" , "model" , model);
		
	}
	
	@RequestMapping(value="/admin/exam/product_list/insert.do" , method = RequestMethod.POST)
	public void AdminExamProductInsert(@ModelAttribute("AdminProductListVo")AdminProductListVo AdminProductListVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		adminExamService.setAdminProductList(AdminProductListVo , "insert");
		
	}
	
	@RequestMapping(value="/admin/exam/product_list/delete.do" , method = RequestMethod.POST)
	public void AdminExamProductDelete(@ModelAttribute("AdminProductListVo")AdminProductListVo AdminProductListVo , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		adminExamService.setAdminProductList(AdminProductListVo , "delete");
		
		SUtil.AlertAndPageMove(response, "삭제 되었습니다.", "/admin/exam/product.do?pro_idx="+AdminProductListVo.getPro_idx()+"");
		
	}
	
}
