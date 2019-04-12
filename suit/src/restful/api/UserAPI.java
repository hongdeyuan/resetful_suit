package restful.api;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.DressView;
import restful.entity.User;

@Path("/user")
public class UserAPI {

	@Context
	HttpServletRequest request;
	
	@POST
	@Path("/ini")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化
	 * 
	 * @param user
	 * @return Result
	 */
	public Result ini(User user) {
		System.out.println(user.getAccount());
		System.out.println(user.isPermission());
		if (user.isPermission()) {
			request.getSession().setAttribute("permission", 2);
		}else {
			request.getSession().setAttribute("permission", 1);
		}		
		request.getSession().setAttribute("account", user.getAccount());		
		return new Result(100,"","","");
//		Result result =  EMUserValidation.registerValidation(user);
//		return result;		
	}
	
	@POST
	@Path("/inibanner")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化banner
	 * 
	 * @param user
	 * @return Result
	 */
	public Result inibanner(User user) {
		String account = (String) request.getSession().getAttribute("account");
		if(account == null) {
			return new Result(101, "请先登录", "", "");
		}else {
			User userInfo = new User();		
			try {
				userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
						.setParameter("account", account).getResultList().get(0);
			} catch (Exception e) {
				// TODO: handle exception
				return new Result(101, "用户不存在", "", "");
			}
			return new Result(100,"",userInfo.getUsername(),"");
		}
		
//		Result result =  EMUserValidation.registerValidation(user);
//		return result;
		
	}
	
	@POST
	@Path("/test")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result test(DressView dressView) {
		System.out.println(dressView.getAccount());
		DressView dressView2 = new DressView();		
			try {
				dressView2 = EM.getEntityManager().createNamedQuery("DressView.queryByAccount",DressView.class)
						.setParameter("account", dressView.getAccount()).getResultList().get(0);
			} catch (Exception e) {
				// TODO: handle exception
				return new Result(101, "用户不存在", "", "");
			}
			return new Result(100,"",dressView2,"");
	}
	
	@POST
	@Path("/iniUserInfo")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化banner
	 * 
	 * @param user
	 * @return Result
	 */
	public Result iniUserInfo( User user ) {
		String account = (String) request.getSession().getAttribute("account");
		if(account == null) {
			return new Result(101, "请先登录", "", "");
		}else {
			User userInfo = new User();		
			try {
				userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
						.setParameter("account", account).getResultList().get(0);
			} catch (Exception e) {
				// TODO: handle exception
				return new Result(101, "用户不存在", "", "");
			}
//			user.setAccount( userInfo.getAccount() );
//			user.setUsername( userInfo.getUsername() );
//			user.setSex( userInfo.isSex() );
//			user.setProfile_photo( userInfo.getProfile_photo() );
			return new Result(100,"",userInfo,"");
		}
	}
	
	@POST
	@Path("/iniCategory")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化所有服饰类别
	 * 
	 * @return Result
	 */
	public Result iniCategory() {
		try {
			
			@SuppressWarnings("rawtypes")
			List categoryList = EM.getEntityManager()
									.createNamedQuery("Category.queryAllCategory", Category.class)
									.getResultList();
			return new Result( 600, "查询成功", categoryList , "");
		} catch (Exception e) {
			// TODO: handle exception
			return new Result( 601, "查询失败，请联系管理员", "", "");   //need next
		}		
	}
	
	@POST
	@Path("/exit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化所有服饰类别
	 * 
	 * @return Result
	 */
	public Result exit() {
		try {
			request.getSession().removeAttribute("account");
			request.getSession().removeAttribute("permission");
			return new Result( 200, "再见", "", "");
		} catch (Exception e) {
			// TODO: handle exception
			return new Result( 201, "退出失败，请联系管理员", "", "");
		}
		
	}
	
//	@POST
//	@Path("/queryModel")
//	@Consumes("application/json;charset=UTF-8")
//	@Produces("application/json;charset=UTF-8")
//	/**
//	 * 查询当前用户的模型信息
//	 * 
//	 * @return Result
//	 */
//	public Result queryModel( UserModel model ) {
//		try {
//			UserModel userModel = EM.getEntityManager().createNamedQuery("Model.queryUserModel", UserModel.class)
//					.setParameter("account", model.getAccount() ).getResultList().get(0);
//			return new Result( 400, "查询成功", userModel , "");
//		} catch (Exception e) {
//			// TODO: handle exception
//			return new Result( 401, "查询失败，请联系管理员", "", "");   //need next
//		}
//		
//	}
//	
//	@POST
//	@Path("/updateModel")
//	@Consumes("application/json;charset=UTF-8")
//	@Produces("application/json;charset=UTF-8")
//	/**
//	 * 用户修改自己的模型信息   权限:当前用户
//	 * 
//	 * @param user
//	 * @return Result
//	 */
//	public Result updateModel( UserModel model ) {
//		
//		UserModel userModelInfo = new UserModel();
//		try {
//			userModelInfo = EM.getEntityManager().createNamedQuery("Model.queryUserModel", UserModel.class)
//								 .setParameter( "account", model.getAccount() )
//								 .getResultList()
//								 .get(0);
//		} catch (Exception e) {
//			// TODO: handle exception
//			return new Result( 404, "未查找到您的模型信息，请联系管理员", "", "");   //need next
//		}
//		
//		model.setId( userModelInfo.getId() );
//		model.setSex( userModelInfo.isSex() );
//		model.setModel_code( userModelInfo.getModel_code() );
//		model.setModel_code( userModelInfo.getModel_name() );
//		
//		model = EM.getEntityManager().merge( model );
//		EM.getEntityManager().persist( model );
//		EM.getEntityManager().getTransaction().commit();
//		
//		return new Result( 403, "保存模型扮成功", model , "");
//		
//	}
//	
//		/**********************************模型***************************************/
//	
//		/**********************************服饰***************************************/
//	@POST
//	@Path("/queryDress")
//	@Consumes("application/json;charset=UTF-8")
//	@Produces("application/json;charset=UTF-8")
//	/**
//	 * 按着装编码查询用户当前的着装信息
//	 * 
//	 * @return Result
//	 */
//	public Result queryClothes( Dress dress ) {
//		Dress dressInfo = new Dress();
//		try {
//			dressInfo = EM.getEntityManager().createNamedQuery("Dress.queryDress", Dress.class)
//											   .setParameter("dress_code", dress.getDress_code() )
//											   .getResultList()
//											   .get(0);
//			return new Result( 400, "查询成功", dressInfo , "");
//		} catch (Exception e) {
//			// TODO: handle exception
//			return new Result( 401, "查询失败，请联系管理员", "", "");   //need next
//		}
//		
//	}
}
