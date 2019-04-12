package restful.utils;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.bean.ViewData;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.User;

/**
 * 对用户提交的用户信息相关数据进行验证
 * 符合要求存入数据库并且返回状态
 *
 */
public class EMUserValidation {
	
	@Context
	HttpServletRequest request;
	
	/**
	 * 用户登陆，对用户输入的信息进行验证
	 * @return Result
	 */
	public static Result loginValidation( User user ) {
		
		System.out.println(user.getAccount());
		System.out.println(user.getPassword());
		
		User userInfo = new User();		
		try {
			userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
					.setParameter("account", user.getAccount()).getResultList().get(0);
		} catch (Exception e) {
			// TODO: handle exception
			return new Result(101, "账号不存在", "", "");
		}
		if (userInfo.getAccount().equals(user.getAccount()) && userInfo.getPassword().equals(user.getPassword())) {
			
			System.out.println(userInfo.getAccount() + "," + userInfo.getPassword());
//			request.getSession().setAttribute("account", userInfo.getAccount());
			ViewData viewData = new ViewData();
			viewData.setAccount(userInfo.getAccount());
			viewData.setPermission(userInfo.isPermission());
			
			return new Result(100, "登陆成功",viewData, "");			
		}
		return new Result(102, "密码错误", "", "");
		
	}
	
	/**
	 * 用户注册，对用户输入的信息进行验证
	 * @return Result
	 */
	public static Result registerValidation( User user ) {
		
		user.setId(0);
		user.setPermission(false);
		if( user.isSex() )	{
			user.setModel_code( "01" );
		} else {
			user.setModel_code( "02" );
		}
		try {
			//通过账号去数据库查找，只要账号不同则认为是不同的用户
			//查询成功代表用户已存在
			EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
								 .setParameter("account", user.getAccount())
								 .getResultList()
								 .get(0);
		
		} catch (Exception e) {
			// TODO: handle exception
			if (!user.getAccount().matches("[a-zA-Z0-9]+")) {
				
				return new Result( 201, "账号只能为数字和字母组合", "", "");
				
			}else if(user.getPassword().length()<6 || user.getPassword().length()>14 || !user.getPassword().matches("[a-zA-Z0-9]+")){
				
				return new Result( 202, "密码长度应在6~14位之间且只能为数字和字母组合", "", "");
				
			}else {
				
				user = EM.getEntityManager().merge(user);
				EM.getEntityManager().persist(user);
				EM.getEntityManager().getTransaction().commit();
				return new Result( 200, "注册成功", user, "");   //need next				
			}
		}
		return new Result( 203, "账号已存在", "", "");	
		
	}
	
	/**
	 * 用户修改，对用户输入的信息进行验证
	 * 非法的数据系统应予以拒绝并且提示
	 * @return Result
	 */
	public static Result updateValidation( User user ) {
		
		User userInfo = new User();
		try {
			 userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
								 .setParameter( "account", user.getAccount() )
								 .getResultList()
								 .get(0);
		} catch (Exception e) {
			// TODO: handle exception
			return new Result(101, "用户不存在", "", "");   //need next
		}
		boolean k = userInfo.isPermission();
		user.setId(userInfo.getId());
		user.setPermission(user.isPermission());
		if( user.isSex() )	{
			user.setModel_code( "01" );
		} else {
			user.setModel_code( "02" );
		}
		if (!k&&user.isPermission()) {
			user.setPermission(true);			
		}else if(k&&!user.isPermission()){			
			user.setPermission(k);	
		}
		
		if (user.getPassword() == null || user.getPassword().trim().equals("")) {
			user.setPassword(userInfo.getPassword());			
		}else if(user.getPassword().length()<6 || user.getPassword().length()>14  || !user.getPassword().matches("[a-zA-Z0-9]+") ){			
			return new Result( 302, "密码长度应在6~14位之间且只能为数字和字母组合", "", "");		
		}
		
		user = EM.getEntityManager().merge(user);
		EM.getEntityManager().persist(user);
		EM.getEntityManager().getTransaction().commit();		
		return new Result( 300, "修改成功", user, "");			
		
	}

	public static Result addCategoryValidation(Category category) {
		
		// TODO Auto-generated method stub
		if( category.getCategory_code().trim() == "" || category.getCategory_name().trim() == "" ) {
			return new Result( 602, "添加失败,不能有空值", "" , "");
		}
		
		try {
			
			EM.getEntityManager()
				.createNamedQuery( "Category.queryCategory" , Category.class)
				.setParameter( "category_code" , category.getCategory_code() )
				.getResultList()
				.get(0);
			return new Result( 603, "添加失败,类别已存在", "", "");  
			
		} catch (Exception e) {
			// TODO: handle exception
			
			category.setId( 0 );
			System.out.println(category.getCategory_code()+","+category.getCategory_name()+","+category.getId());			
			try {
				
				category = EM.getEntityManager().merge(category);
				EM.getEntityManager().persist(category);
				EM.getEntityManager().getTransaction().commit();
				return new Result( 605, "添加成功", "", "");   //need next
				
			}catch (Exception e2) {
				// TODO: handle exception
				return new Result( 604, "添加失败，请联系管理员", "" , "");
			}
		}
	}

	public static Result updateCategoryValidation(Category category , String preValue) {
		System.out.println(preValue == category.getCategory_code());
		Category categoryInfo = EM.getEntityManager().createNamedQuery("Category.queryCategory", Category.class)
				 .setParameter( "category_code", preValue)
				 .getResultList()
				 .get(0);
		if( preValue.equals(category.getCategory_code()) ) {
				categoryInfo.setCategory_name(category.getCategory_name());
				categoryInfo = EM.getEntityManager().merge( categoryInfo );
				EM.getEntityManager().persist( categoryInfo );
				EM.getEntityManager().getTransaction().commit();
				return new Result(611, "修改成功",categoryInfo, "");
		}else {
			try {
				categoryInfo = EM.getEntityManager().createNamedQuery("Category.queryCategory", Category.class)
						 .setParameter( "category_code", category.getCategory_code() )
						 .getResultList()
						 .get(0);
				System.out.println(categoryInfo.getId());
				return new Result(612, "类别已存在", "", "");
			} catch (Exception e) {				
				categoryInfo.setCategory_code(category.getCategory_code());
				categoryInfo.setCategory_name(category.getCategory_name());
				categoryInfo = EM.getEntityManager().merge( categoryInfo );
				EM.getEntityManager().persist( categoryInfo );
				EM.getEntityManager().getTransaction().commit();
				return new Result(611, "修改成功", categoryInfo, "");
			}
		}
		
	}

}
