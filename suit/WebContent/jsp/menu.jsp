<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>  
<html>
	<head>
		<title>menu</title>
		<link rel="stylesheet" href="<%=basePath%>/css/menu.css">
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
	</head>
	<body>
		<div class="container">
		
		    <div class="item self">
		      <a href="<%=basePath%>/jsp/menu/user-edit.jsp" target="content"  >
		     	<img src="<%=basePath%>/images/ui/self.png" alt="self">
		      </a>
		    </div>
		    
		    <div class="item userList">
		        <a href="<%=basePath%>/jsp/menu/user-manage.jsp" target="content"  >
		    		<img src="<%=basePath%>/images/ui/userList.png" alt="userList">
		    	</a>
		    </div>
		    
		    <div class="item catalog">
		        <a href="<%=basePath%>/jsp/menu/suit-category.jsp" target="content"  >
		    		<img src="<%=basePath%>/images/ui/catalog.png" alt="catalog">
		    	</a>
		    </div>
		    
		    <div class="item suits">
		        <a href="<%=basePath%>/jsp/menu/suit-manage.jsp" target="content"  >
		    		<img src="<%=basePath%>/images/ui/suits.png" alt="suits">
	    		</a>
		    </div>
		    
		    <div class="item mySuits">
		        <a href="<%=basePath%>/jsp/menu/suit-fitting.jsp" target="content"  >
		    		<img src="<%=basePath%>/images/ui/mySuits.png" alt="mySuits">
		    	</a>
		    </div>
		    
		    <div class="item exit">
		        <span>
		        	<a href="javascript:void(0);" onclick="exitThis()">
		        		<img src="<%=basePath%>/images/ui/exit.png" alt="exit">
		        	</a>
		        </span>
		    </div>
		    
		</div>		
		<script>
		
			function exitThis() {			
				if(confirm("确实退出吗？")){
					request( "POST", "<%=basePath%>/user/exit", {},exitSuccess,serverError,true );
				}
			}
			function exitSuccess(responseData) {
				showMessage( responseData );
				if(responseData.code==200){
					window.top.location.href = "<%=basePath%>/jsp/login.jsp";
				}
			}
		</script>
	</body>
</html>