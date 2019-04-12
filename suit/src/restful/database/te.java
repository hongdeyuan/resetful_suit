package restful.database;

import restful.entity.DressView;

public class te {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		DressView dressView2 = EM.getEntityManager().createQuery("SELECT dressView FROM DressView dressView where dressView.account = :account",DressView.class)
				.setParameter("account", "super").getResultList().get(0);
		System.out.println(dressView2.getCategory_code());
	}

}
