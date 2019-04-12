package restful.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.annotation.Power;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Clothes;
import restful.entity.Dress;
import restful.entity.DressView;
import restful.entity.User;
import restful.entity.UserModel;
import restful.utils.EMUserValidation;

@Path("/normal")
public class NormalAPI extends AnonymousAPI {
	@Context
	HttpServletRequest request;

	/********************************************** 登陆用户*****************************************/
	/*********************************** 用户信息***************************************/
	@POST
	@Path("/update")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(1)
	/**
	 * 用户修改自己的信息 权限:当前用户
	 * 
	 * @param user
	 * @return Result
	 */
	public Result update(User user) {
		String account = (String) request.getSession().getAttribute("account");
		System.out.println(account);
		System.out.println(user.getAccount());
		if (!account.equals(user.getAccount())) {
			return new Result(301, "账号不允许修改", "", ""); // need next
		} else {
			Result result = EMUserValidation.updateValidation(user);
			return result;
		}
	}
	
	@POST
	@Path("/queryAllClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(1)
	/**
	 * 查询所有服饰 权限:当前用户
	 * 
	 * @return
	 */	
	public Result queryAllClothes(  ) {
		try {
			
			List<Clothes> clothesListData = EM.getEntityManager()
										.createNamedQuery("Clothes.queryAllClothes", Clothes.class)
										.getResultList();
			return new Result( 888, "查询成功", clothesListData, "");
		} catch ( Exception e ) { 
			return new Result( 889, "查询失败", "", "");
		}
	}
	
	@POST
	@Path("/queryClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(1)
	/**
	 * 按性别和服饰类别查询服饰 权限:当前用户
	 * 
	 * @return
	 */	
	public Result queryClothes(Clothes clothes) {
		try {
			
			List<Clothes> clothesListData = EM.getEntityManager()
										.createNamedQuery("Clothes.queryByCategoryAndSex", Clothes.class)
										.setParameter( "category_code", clothes.getCategory_code())
										.setParameter( "clothes_sex",clothes.isClothes_sex())
										.getResultList();
			return new Result( 502, "查询成功", clothesListData, "");
		} catch ( Exception e ) { 
			return new Result( 503, "查询失败", "", "");
		}
	}
	
	@POST
	@Path("/queryClothesInfo")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(1)
	/**
	 * 按服饰类别查询服饰 权限:当前用户
	 * 
	 * @return
	 */	
	public Result queryClothesInfo( Clothes clothes) {		
		String account = (String) request.getSession().getAttribute("account");		
		User userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
								 .setParameter( "account",account )
								 .getResultList()
								 .get(0);
		System.out.println(userInfo.isSex()+clothes.getCategory_code());
		try {			
			List<Clothes> clothesListData = EM.getEntityManager()
										.createNamedQuery("Clothes.queryByCategoryAndSex", Clothes.class)
										.setParameter( "category_code", clothes.getCategory_code())
										.setParameter( "clothes_sex",userInfo.isSex())
										.getResultList();
			return new Result( 333, "查询成功", clothesListData, "");
		} catch ( Exception e ) { 
			return new Result( 334, "查询失败", "", "");
		}
	}
	
	@POST
	@Path("/iniUserModel")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(1)
	/**
	 * 初始化用户模型 权限:当前用户
	 * 
	 * @return
	 */	
	public Result iniUserModel(  ) {		
		String account = (String) request.getSession().getAttribute("account");		
		User userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
								 .setParameter( "account", account )
								 .getResultList()
								 .get(0);
		UserModel userModel = EM.getEntityManager().createNamedQuery("Model.queryUserModel", UserModel.class)
							 .setParameter( "model_code", userInfo.getModel_code() )
							 .getResultList()
							 .get(0);
		return new Result( 6666, "加载成功", userModel, "");
	}
	
	@POST
	@Path("/saveDress")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 保存装扮  权限:当前用户
	 * 
	 * @return
	 */	
	public Result saveDress( Dress dress ) {
		String account = (String) request.getSession().getAttribute("account");
		dress.setId(0);
		dress.setAccount(account);
		System.out.println( dress );
		try {
			dress = EM.getEntityManager().merge(dress);
			EM.getEntityManager().persist(dress);
			EM.getEntityManager().getTransaction().commit();
			return new Result( 200, "保存成功", dress, "");   //need next	
		} catch (Exception e) {
			// TODO: handle exception
			return new Result( 99, "装扮已经穿在身上", "", "");   //need next	
		}
	}
	
	@POST
	@Path("/deleteDress")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 脱下装扮  权限:当前用户
	 * 
	 * @return
	 */	
	public Result deleteDress( Dress dress ) {	
		String account = (String) request.getSession().getAttribute("account");
		Dress dressInfo = EM.getEntityManager().createNamedQuery("Dress.queryDress", Dress.class)
				 .setParameter( "clothes_code", dress.getClothes_code() )
				 .setParameter( "account", account )
				 .getResultList()
				 .get(0);
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge( dressInfo ));
			EM.getEntityManager().getTransaction().commit();
			return new Result( 0, "删除成功", "", "");
		} catch (Exception e) {
			return new Result( 0, "删除失败", "", "");
		}
	}
	
	
	@POST
	@Path("/iniUserDress")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	/**
	 * 初始化用户着装  权限:当前用户
	 * 
	 * @return
	 */	
	public Result iniUserDress(  ) {
		
		String account = (String) request.getSession().getAttribute("account");		
		List<DressView> dressView = EM.getEntityManager().createNamedQuery("DressView.queryByAccount", DressView.class)
							 .setParameter( "account", account )
							 .getResultList();
		
		System.out.println(dressView.size());
		return new Result( 6666, "加载成功", dressView, "");
	}
}
