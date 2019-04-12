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
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/login.css" />	
			
		<title>登陆页面</title>
	</head>
	
	<body >
		<div id="WebGL-Container">
            <div class="wrap">
                <div id="titleSuit">梦幻试衣间</div>
                <div class="container">
                	<div class="login-input">
                		<input id="account" type="text" placeholder="account"/>
                	</div>
                	<div class="login-input">
                		<input id="password" type="password" placeholder="password"/>
                	</div>
                    <div class="btn">
                        <input type="button" onclick="login()" value="Login"/>
                        <input type="button" onclick="register()" value="Register"/>
                    </div>
                </div>
            </div>
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
			addMy3DScene( -181.8, 96.6, -125.3, 0.1401, 0.4345, "<%=basePath%>");
		</script>
		
		<!-- 界面功能 -->
		<script>
			function login() {
				var account = $( "#account" ).val();
				var password = $( "#password" ).val();
				if(account.trim().length ==0) {
					alert("账号不能为空");
					
				}else if( password.trim().length ==0){
					alert("密码不能为空");
				}else {
					var user = {"account":account,"password":password};
					request( "POST","<%=basePath%>/anonymous/login",user,loginSuccess,serverError,true);
				}
			}
			
			function loginSuccess(responseData) {				
				showMessage(responseData);
				if( responseData.code == 100 ) {					
					var user = {
							"account":responseData.data.account,
							"permission":responseData.data.permission	
					};					
					request( "POST","<%=basePath%>/user/ini",user,iniSuccess,serverError,true);	
				}
			}
			
			function iniSuccess() {
				$(window).attr( "location", "<%=basePath%>/jsp/index.jsp");
			}
			
			function register() {
				$(window).attr( "location", "<%=basePath%>/jsp/register.jsp");
			}
		</script>
		
	</body>
	
</html>