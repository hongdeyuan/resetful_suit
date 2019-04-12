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
		<title>梦想试衣间</title>
		<style>
			* {
				margin: 0;
				padding: 0;
			}
		</style>
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		
		<link rel="stylesheet" href="<%=basePath%>/css/index.css">
		
	</head>
	<body>
		<div id="WebGL-Container">
			<div id="img">
				<img src="<%=basePath%>/images/ui/button.png"/>
			</div>
			
			<iframe id="banner" src="<%=basePath%>/jsp/banner.jsp" name="banner"></iframe>
			<iframe id="menu" src="<%=basePath%>/jsp/menu.jsp" name="menu"></iframe>
			<iframe id="content" src="<%=basePath%>/jsp/workspace.jsp" name="content"></iframe>
		</div>
		
	 	<!-- 渲染3D场景需要的JS -->
		<script src="<%=basePath%>/js/three.js"></script>

        <script src="<%=basePath%>/js/controls/OrbitControls.js"></script>
        <script src="<%=basePath%>/js/objects/Water.js"></script>
        <script src="<%=basePath%>/js/objects/Sky.js"></script>
        <script src="<%=basePath%>/js/WebGL.js"></script>

		<!-- 封装好的渲染3D场景的函数 -->
		<script src="<%=basePath%>/js/WebGL-scene/backgroundScene.js"></script>
		
		<!-- 渲染3D场景 -->
		<script>
			addMy3DScene( 260.7, 40.0, -37.1, 0.5, 0, "<%=basePath%>");
			$('#img').on('click', function() {
				var left = $('#img').css('left');
				console.log(left);
				if(left != '0px'){
					$('#menu').css('left', '-8%');
					$('#img').css('left', '0');
					$('#content').css('width', '100%');					
				}else {
					$('#menu').css('left', '0');
					$('#img').css('left', '8%');
					$('#content').css('width', '88%');		
				}
			})
		</script>
	</body>
</html>