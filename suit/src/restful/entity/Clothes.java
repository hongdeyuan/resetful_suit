package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "T_Clothes" )
@NamedQueries( {
	@NamedQuery( name = "Clothes.queryByCategory", 
		     query = " SELECT clothes FROM Clothes clothes where clothes.category_code = :category_code") ,
	@NamedQuery( name = "Clothes.queryClothesInfo", 
			     query = " SELECT clothes FROM Clothes clothes where clothes.clothes_code = :clothes_code ") ,
	@NamedQuery( name = "Clothes.queryByCategoryAndSex", 
    			 query = " SELECT clothes FROM Clothes clothes where clothes.category_code = :category_code and clothes.clothes_sex = :clothes_sex") ,

})
public class Clothes extends IdEntity {

	/**
	 * auto generate
	 */
	private static final long serialVersionUID = -3187877330836090435L;
	
	/**
	 * save Clothes information
	 */
	
	private String clothes_code;
	private String clothes_name;
	private float price;
	private String category_code;
	private String clothes_path;
	private boolean clothes_sex;
	private String clothesobj_path;
	
	public String getClothes_code() {
		return clothes_code;
	}
	public void setClothes_code(String clothes_code) {
		this.clothes_code = clothes_code;
	}
	public String getClothes_name() {
		return clothes_name;
	}
	public void setClothes_name(String clothes_name) {
		this.clothes_name = clothes_name;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getClothes_path() {
		return clothes_path;
	}
	public void setClothes_path(String clothes_path) {
		this.clothes_path = clothes_path;
	}
	public boolean isClothes_sex() {
		return clothes_sex;
	}
	public void setClothes_sex(boolean clothes_sex) {
		this.clothes_sex = clothes_sex;
	}
	public String getClothesobj_path() {
		return clothesobj_path;
	}
	public void setClothesobj_path(String clothesobj_path) {
		this.clothesobj_path = clothesobj_path;
	}
	
}
