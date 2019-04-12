package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "T_Dress" )
@NamedQueries( {
	@NamedQuery( name = "Dress.queryDress", 
			 query = "SELECT dress FROM Dress dress where dress.clothes_code= :clothes_code and dress.account= :account" ),
	@NamedQuery( name = "Dress.queryAllDress", 
	 		 query = "SELECT dress FROM Dress dress" ) ,

})


public class Dress extends IdEntity {

	/**
	 * auto 
	 */
	private static final long serialVersionUID = -2957676990982568693L;
	
	private String clothes_code;
	private String account;
	
	public String getClothes_code() {
		return clothes_code;
	}
	public void setClothes_code(String clothes_code) {
		this.clothes_code = clothes_code;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	
	
}
