package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "T_UserModel" )
@NamedQuery( name = "Model.queryUserModel", query = " SELECT model FROM UserModel model where model.model_code = :model_code " )
public class UserModel extends IdEntity {
	
	
	/**
	 * auto generate
	 */
	private static final long serialVersionUID = -7801606523206419238L;
	/**
	 * save user's model information
	 */
	private String model_code;
	private String model_name;
	private String model_path;

	public String getModel_code() {
		return model_code;
	}
	public void setModel_code(String model_code) {
		this.model_code = model_code;
	}
	public String getModel_name() {
		return model_name;
	}
	public void setModel_name(String model_name) {
		this.model_name = model_name;
	}
	public String getModel_path() {
		return model_path;
	}
	public void setModel_path(String model_path) {
		this.model_path = model_path;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
