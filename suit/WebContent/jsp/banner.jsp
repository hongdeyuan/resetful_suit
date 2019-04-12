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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>banner</title>
		
		<link rel="stylesheet" href="<%=basePath%>/css/banner.css">
		
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
	</head>
	<body >
		<div class="container">
			<div class="left" id="left"></div>
			<div class="right">梦想试衣间</div>
		</div>
  
	  	<script>
		  
	  		request( "POST","<%=basePath%>/user/inibanner",{},iniBannerSuccess,serverError,true);	
		  
	  		function iniBannerSuccess( responseData ) {	  
			  console.log("registerSuccess",responseData.data);
			  if(responseData.code == 100){
				  $("#left").text("当前用户："+responseData.data);
			  }
			}
		 </script>
  
	</body>
</html>