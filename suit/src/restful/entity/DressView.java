package restful.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "V_DressView" )
@NamedQueries( {
	@NamedQuery( name = "DressView.queryByAccount", 
		     query = "SELECT dressView FROM DressView dressView where dressView.account = :account") ,
})

@SuppressWarnings("serial")
public class DressView extends IdEntity implements Serializable{
	private String account;
	private String clothes_code;
	private String clothesobj_path;
	private String category_code;
	private boolean clothes_sex;
	private String clothes_path;
	private String clothes_name;
	private String price;
	
	public DressView() {}
	public DressView(String account,String clothes_code,String clothesobj_path,String category_code,boolean clothes_sex,String clothes_path,String clothes_name) {
		this.account = account;
		this.clothes_code = clothes_code;
		this.clothes_path = clothes_path;
		this.category_code = category_code;
		this.clothes_sex = clothes_sex;
		this.clothes_path = clothes_path;
		this.clothes_name = clothes_name;
	}
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getClothes_code() {
		return clothes_code;
	}
	public void setClothes_code(String clothes_code) {
		this.clothes_code = clothes_code;
	}
	public String getClothesobj_path() {
		return clothesobj_path;
	}
	public void setClothesobj_path(String clothesobj_path) {
		this.clothesobj_path = clothesobj_path;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getClothes_path() {
		return clothes_path;
	}
	public void setClothes_path(String clothes_path) {
		this.clothes_path = clothes_path;
	}
	public String getClothes_name() {
		return clothes_name;
	}
	public void setClothes_name(String clothes_name) {
		this.clothes_name = clothes_name;
	}
	public boolean isClothes_sex() {
		return clothes_sex;
	}
	public void setClothes_sex(boolean clothes_sex) {
		this.clothes_sex = clothes_sex;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
}
