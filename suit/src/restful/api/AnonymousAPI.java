package restful.api;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.entity.User;
import restful.utils.EMUserValidation;

@Path("/anonymous")
public class AnonymousAPI {
	
	@Context
	HttpServletRequest request;
	
	/*********************************************匿名用户*****************************************/
	@POST
	@Path("/register")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 用户注册 权限:匿名
	 * 
	 * @param user
	 * @return Result
	 */
	public Result register(User user) {
		
		Result result =  EMUserValidation.registerValidation(user);
		return result;
		
	}

	@POST
	@Path("/login")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 用户登陆 权限:匿名
	 * 
	 * @param user
	 * @return
	 */
	public Result login(User user) {
		Result result = EMUserValidation.loginValidation(user);
		return result;
		
	}

	/*********************************************匿名用户*****************************************/
}
