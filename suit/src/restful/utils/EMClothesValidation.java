package restful.utils;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.Clothes;

public class EMClothesValidation {

	public static Result addClothesValidation(Clothes clothes) {
		// TODO Auto-generated method stub
		clothes.setId(0);
		clothes.setClothesobj_path("suits/female/" + clothes.getCategory_code() + "/" + clothes.getClothes_code().substring(2) );
		try {
			//通过类别编码去数据库查找，只要编码不同则认为是不同的类别
			//查询成功代表类别已存在
			EM.getEntityManager().createNamedQuery("Clothes.queryClothesInfo", Clothes.class)
								 .setParameter("clothes_code", clothes.getClothes_code() )
								 .getResultList()
								 .get(0);		
		} catch (Exception e) {				
				clothes = EM.getEntityManager().merge( clothes );
				EM.getEntityManager().persist( clothes );
				EM.getEntityManager().getTransaction().commit();
				return new Result( 200, "添加成功", clothes, "");   //need next				
		}
		return new Result( 203, "类别已存在", "", "");	
	}
	
	
	public static Result updataClothesValidation(Clothes clothes) {
		// TODO Auto-generated method stub
		Clothes clothesInfo = new Clothes();
		try {
			clothesInfo = EM.getEntityManager().createNamedQuery("Clothes.queryClothesInfo", Clothes.class)
					 .setParameter("clothes_code", clothes.getClothes_code() )
					 .getResultList()
					 .get(0);			
			clothesInfo.setCategory_code(clothes.getCategory_code());
			clothesInfo.setClothes_name(clothes.getClothes_name());
			clothesInfo.setPrice(clothes.getPrice());
			clothesInfo.setClothes_path(clothes.getClothes_path());
			clothesInfo.setClothes_code(clothes.getClothes_code());
			clothesInfo.setClothes_sex(clothes.isClothes_sex());
			return new Result( 300, "修改成功", clothesInfo, "");
			
		} catch (Exception e) {
			// TODO: handle exception
				return new Result(609, "该服饰不存在", "", "");
		}
		
	}

}
