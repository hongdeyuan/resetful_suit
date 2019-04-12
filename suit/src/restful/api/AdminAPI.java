package restful.api;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import restful.annotation.Power;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.Clothes;
import restful.entity.User;
import restful.utils.EMClothesValidation;
import restful.utils.EMUserValidation;

@Path( "/admin" )
public class AdminAPI extends NormalAPI{
	
	
	/**********************************服饰类别***************************************/	
	
	@POST
	@Path("/updateCategory/{preValue}")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 更新类别
	 * 
	 * @param user
	 * @return Result
	 */
	public Result updateCategory( Category category, @PathParam("preValue") String preValue ) {

			Result result = EMUserValidation.updateCategoryValidation( category, preValue);
			return result;
	}
	
	@POST
	@Path("/addCategory")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 添加服饰类别
	 * 
	 * @param user
	 * @return Result
	 */
	public Result addCategory( Category category ) {
		
		Result result =  EMUserValidation.addCategoryValidation( category );
		return result;
		
	}
	
	@POST
	@Path("/deleteCategory")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 删除服饰类别
	 * 
	 * @return Result
	 */
	public Result deleteCategory( Category category ) {
		
		Category categoryInfo = EM.getEntityManager().createNamedQuery("Category.queryCategory", Category.class)
											 .setParameter( "category_code", category.getCategory_code() )
											 .getResultList()
											 .get(0);
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge( categoryInfo ));
			EM.getEntityManager().getTransaction().commit();
			return new Result( 606, "删除成功", "", "");
		} catch (Exception e) {
			return new Result( 607, "删除失败", "", "");
		}
		
	}
		/**********************************服饰类别***************************************/
	
	
	/*********************************************用户管理*****************************************/
	@POST
	@Path("/updateAdmin")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 管理员修改用户的信息      权限:管理员
	 * 
	 * @param user
	 * @return Result
	 */
	public Result updataAdmin(User user) {
		
		Result result = EMUserValidation.updateValidation(user);
		return result;
		
	}
	
	@POST
	@Path( "/query" )
	@Consumes( "application/json;charset=UTF-8" )
	@Produces( "application/json;charset=UTF-8" )
	@Power(2)
	/**
	 * 查询当前用户的用户信息
	 * 权限:   管理员
	 * @param user
	 * @return
	 */
	public Result query( User user ) {
		
		User userInfo = new User();
		try {
		
			userInfo = EM.getEntityManager()
						  .createNamedQuery( "User.queryAllByAccount" , User.class)
						  .setParameter( "account" , user.getAccount() )
						  .getSingleResult();			
		} catch ( Exception e ) {
			return new Result( 304, "查询失败", "", "");
		}
		return new Result( 303, "查询成功", userInfo, "");
		//return new Result(0, "查询成功", userInfo, "");
	}

	@POST
	@Path("/deleteUser")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 管理员删除账号 权限:管理员
	 * 
	 * @param user
	 * @return Result
	 */
	public Result deleteUser(User user) {
		
		User userInfo = EM.getEntityManager().createNamedQuery("User.queryAllByAccount", User.class)
											 .setParameter( "account", user.getAccount() )
											 .getResultList()
											 .get(0);
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge( userInfo ));
			EM.getEntityManager().getTransaction().commit();
			return new Result( 500, "删除成功", userInfo, "");
		} catch (Exception e) {
			return new Result( 501, "删除失败", userInfo, "");
		}
		
	}
	@POST
	@Path("/queryAll")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 查询所有存在的用户 权限:管理员
	 * 
	 * @return
	 */
	
	public Result userList() {
		try {
			List<User> userListData = EM.getEntityManager()
										.createNamedQuery("User.queryAll", User.class)
										.getResultList();
			return new Result( 502, "查询成功", userListData, "");
		} catch ( Exception e ) { 
			return new Result( 503, "查询失败", "", "");
		}
	}
	/*********************************************用户管理*****************************************/
	
	
	
	
	
	
	/*********************************************服饰管理*****************************************/
	
	
	
	@POST
	@Path("/addClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 添加服饰
	 * 
	 * @return Result
	 */
	public Result addClothes( Clothes clothes ) {
		
		Result result =  EMClothesValidation.addClothesValidation( clothes );
		return result;
		
	}
	
	
	@POST
	@Path("/updataClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 添加服饰
	 * 
	 * @return Result
	 */
	public Result updataClothes( Clothes clothes ) {
		
		Result result =  EMClothesValidation.updataClothesValidation( clothes );
		return result;
		
	}
	
	
	
	
	@POST
	@Path("/deleteClothes")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	/**
	 * 删除服饰
	 * 
	 * @return Result
	 */
	public Result deleteClothes( Clothes clothes ) {
		System.out.println(clothes.getClothes_code());
		Clothes clothesInfo = EM.getEntityManager().createNamedQuery("Clothes.queryClothesInfo", Clothes.class)
		 .setParameter("clothes_code", clothes.getClothes_code() )
		 .getResultList()
		 .get(0);
		
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge( clothesInfo ));
			EM.getEntityManager().getTransaction().commit();
			return new Result( 500, "删除成功", "", "");
		} catch (Exception e) {
			return new Result( 501, "删除失败", "", "");
		}
		
	}
	
	@SuppressWarnings("deprecation")
	@POST
	@Path("/uploadImage")
	@Produces("application/json;charset=UTF-8")
	@Power(2)
	public Result uploadImage(@QueryParam("code") String suitCode) {	
		System.out.println(suitCode);
		System.out.println(request.getContextPath());
	    // 创建DiskFileItem工厂
		DiskFileItemFactory dFactory = new DiskFileItemFactory();
		// 获取文件保存目录
		String savePath = request.getRealPath("/");
		//String savePath = request.getContextPath();
	    // 设置缓存目录
		dFactory.setRepository(new File(savePath+"images\\"));
	    // 设置缓冲区大小,文件体积超出缓冲区大小将保持至缓存目录然后再进行后续处理，这里设置为1M bytes
		dFactory.setSizeThreshold(1024*1024);
	    // 创建文件上传解析对象
		ServletFileUpload upload=new ServletFileUpload(dFactory);
	    // 按照UTF-8编码格式读取
		upload.setHeaderEncoding("UTF-8");
	    // 设置每个文件最大为5M
		upload.setFileSizeMax(1024*1024*5);		
	    // 一共最多能上传10M
		upload.setSizeMax(1024*1024*10);
	    	
	    try {
	    	//解析请求，将表单中每个输入项封装成一个FileItem对象
            List<FileItem> fileItems = upload.parseRequest(request);
	        // 解析并保存
	        for (FileItem fileItem : fileItems) {
	        	
	        	if (!fileItem.isFormField()) {      
	        		
	        		String fileName = fileItem.getName();
		        	InputStream is=fileItem.getInputStream();
		        	System.out.println(savePath+"images\\data\\suits\\"+fileName);
		        	fileItem.write(new File(savePath+"images\\data\\suits\\"+fileName));
		        	//fileItem.write(new File("D:\\Workspaces\\eclipse-workspace\\suit8\\WebContent\\images\\data\\suits\\"+fileName));
                    is.close();
                    try {            			
            			Clothes clothes = EM.getEntityManager()
            										.createNamedQuery("Clothes.queryClothesInfo", Clothes.class)
            										.setParameter( "clothes_code", suitCode)
            										.getResultList().get(0);
            			clothes.setClothes_path("images/data/suits/"+fileName);
            			clothes = EM.getEntityManager().merge(clothes);
            			EM.getEntityManager().persist(clothes);
            			EM.getEntityManager().getTransaction().commit();
            			return new Result(-1, fileName, "", "");
            		} catch ( Exception e ) { 
            			return new Result( 503, "找不到该服饰", "", "");
            		}   
				}
	        	
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new Result(-1, "服务器文件解析错误", null, "");
	    }
	    return new Result(-1, "未发现可供服务保存的数据", null, "");
	}
	
	
	/*********************************************服饰管理*****************************************/
}
