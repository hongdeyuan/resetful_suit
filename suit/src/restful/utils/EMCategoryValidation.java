package restful.utils;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;

public class EMCategoryValidation {

	public static Result addCategoryValidation(Category category) {
		// TODO Auto-generated method stub
		
		category.setId(0);
			
		try {
			//通过类别编码去数据库查找，只要编码不同则认为是不同的类别
			//查询成功代表类别已存在
			EM.getEntityManager().createNamedQuery("Category.queryClothesCategory", Category.class)
								 .setParameter("category_code", category.getCategory_code() )
								 .getResultList()
								 .get(0);
		
		} catch (Exception e1) {
			// TODO: handle exception
//			try {
				
				category = EM.getEntityManager().merge( category );
				EM.getEntityManager().persist( category );
				EM.getEntityManager().getTransaction().commit();
				return new Result( 200, "添加成功", category, "");   //need next
//				
//			} catch (Exception e2) { 
//				
//				return new Result( 200, "添加失败，有空数据", category, "");
//				
//			}
				
		}
		return new Result( 203, "类别已存在", "", "");	
		
	}
	/**
	 * 对类别提交的相关数据进行验证
	 * 符合要求存入数据库并且返回状态
	 *
	 */
}
