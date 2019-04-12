package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "T_Category" )

@NamedQueries( {
	@NamedQuery( name = "Category.queryCategory", 
			query = " SELECT category FROM Category category where category.category_code = :category_code ") ,
	@NamedQuery( name = "Category.queryAllCategory", 
			query = " SELECT category FROM Category category ")

})

public class Category extends IdEntity {
	
	/**
	 * auto generate
	 */
	private static final long serialVersionUID = 1097908097378841L;
	/**
	 * save clothes category infomation
	 */

	private String category_code;
	private String category_name;
	
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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
	
}
