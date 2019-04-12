

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html> 

<html>
	<head>
		<title>注册页面</title>
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/register.css" />	
	</head>
	<body>
		<div id="WebGL-Container">
			<div class="register-div">
				<div id="title">注册</div>
				<div class="container">
					<div class="register-input">
						<input type="text" id="account" placeholder="account"/>
					</div>
					<div class="register-input">
						<input type="text" id="username" placeholder="username" />
					</div>
					<div class="register-input">
						<input type="password" id="password" placeholder="password" />
					</div>
					<div class="register-input">
						<input type="password" id="confirm_password" placeholder="confirm_password" />
					</div>
					<div class="gender">	
						<input type="radio" value="true" name="gender" />男
				 		<input type="radio" value="false" name="gender" />女
					</div>
					<div>
						<div id="ths" >模型选择</div>
						<img id="model1">
						<img id="model2">
					</div>
					<div class="reg_btn">
						<input type="button" onclick="register()" value="注册"/>
						<input type="button" onclick="window.location.href='<%=basePath%>/jsp/login.jsp'" value="返回登陆"/>
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
			addMy3DScene( 206.7, 71.7,  247.8, 0.4764, 0.225, "<%=basePath%>");
		</script>
			
		
		<script>
			$("input:radio").click(function(){
			    var value = $(this).val()  //获取选中的radio的值
			    var model1 = $( "#model1" );
				var model2 = $( "#model2" );
				var btns = $("btns");
				model1.css("width","50px");
				model1.css("height","60px");
	
				model2.css("width","50px");
				model2.css("height","60px");
				
				$(".reg_btn").css({"margin":"70px 0px 0px 0px"});
				$(".register-div").css({"height":"500px"});
				$(".container").css({"height":"440px"});


				
			    if( value == "true" ) {
					model1.attr("src","<%=basePath%>/images/data/model/mheadA.png");
					model2.attr("src","<%=basePath%>/images/data/model/mheadB.png");
				} else {
					model1.attr("src","<%=basePath%>/images/data/model/wheadA.png");
					model2.attr("src","<%=basePath%>/images/data/model/wheadB.png");
				}
			});
			
			 
				$('#model1').click(function() {
					$(this).addClass('insert');
					$(this).addClass('active');
					$('#model2').removeClass('active');
					$('#model2').removeClass('no_insert');
				});
				 $('#model2').click(function() {
					$(this).addClass('no_insert');
					$(this).addClass('active');
					$('#model1').removeClass('active');
					$('#model1').removeClass('insert');
				});
	
			function register() {
				
				if( $( "#account" ).val().trim().length == 0 || $( "#username" ).val().trim().length == 0 || 
						$( "#password" ).val().trim().length == 0 || $( "#confirm_password" ).val().trim().length == 0 || 
						$( "input[name=gender]:checked" ) == "false" || ! $( "img" ).hasClass("active") ) {
					alert("信息不完整");	
				}else if( $( "#confirm_password" ).val() != $( "#password" ).val() ) {
					alert("两次密码输入不一致");
				} else {
					var account = $( "#account" ).val();
					var username = $( "#username" ).val();
					var password = $( "#password" ).val();
					var confirm_password = $( "#confirm_password" ).val();
					var sexCheck = $( "input[name=gender]:checked" ).val();
					var imgCheck = $( ".active" );
					var suffix = imgCheck.attr("src").substr(imgCheck.attr("src").lastIndexOf("i"));
					var user = {
									"account" : account,
									"username": username,
									"password": password,
									"sex": sexCheck,
									"profile_photo": suffix
								};
					request( "POST","<%=basePath%>/anonymous/register",user,registerSuccess,serverError,true );
				}			
			}
	
			function registerSuccess (data) {		
				console.log("registerSuccess",data);
				showMessage(data); 
				if(data.code==200){
					$(window).attr( "location", "<%=basePath%>/jsp/login.jsp");
					<%-- request( "POST","<%=basePath%>"+data.nextAction,{},showMessage,serverError,true ); --%>
				}
			}
		</script>
	</body>
</html>