package egovframework.sample.admin.product.model;

import com.system.util.SearchVo;

public class AdminProductVo extends SearchVo{

	String idx = "";
	String image = "";
	String image_change_bool = "";
	String name = "";
	String create_tm = "";
	String update_tm = "";
	
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getImage_change_bool() {
		return image_change_bool;
	}
	public void setImage_change_bool(String image_change_bool) {
		this.image_change_bool = image_change_bool;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreate_tm() {
		return create_tm;
	}
	public void setCreate_tm(String create_tm) {
		this.create_tm = create_tm;
	}
	public String getUpdate_tm() {
		return update_tm;
	}
	public void setUpdate_tm(String update_tm) {
		this.update_tm = update_tm;
	}
	
	
}
