package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table( name = "T_User" )
@NamedQueries({
    @NamedQuery( name = "User.queryAll", query = "SELECT user FROM User user" ),
    @NamedQuery( name = "User.queryAllByAccount", query = "SELECT user FROM User user where user.account = :account")
})
public class User extends IdEntity {

	
	/**
	 * auto generate
	 */
	private static final long serialVersionUID = 4636077429339629742L;
	
	/**
	 * user information
	 */
	private String account;
	private String username;
	private boolean sex;
	private String password;
	private boolean permission;
	private String profile_photo;
	private String model_code;
	
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public boolean isSex() {
		return sex;
	}
	public void setSex(boolean sex) {
		this.sex = sex;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public boolean isPermission() {
		return permission;
	}
	public void setPermission(boolean permission) {
		this.permission = permission;
	}
	public String getProfile_photo() {
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getModel_code() {
		return model_code;
	}
	public void setModel_code(String model_code) {
		this.model_code = model_code;
	}
	
}
