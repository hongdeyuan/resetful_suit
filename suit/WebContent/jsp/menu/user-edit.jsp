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
	
		<title>用户信息</title>
		
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
		
		<link rel="stylesheet" href="<%=basePath%>/css/user-edit.css">
		
	</head>
	<body>
		<table id="message">
			<tr class="first"><td colspan="2" width="100%" class="a">修改信息</td></tr>
			<tr class="second">
				<td width="30%"><lable class="word">用户名称：</lable></td>
				<td width="70%"><input type="text" class="txt" id="account" value=""/></td>
			</tr>
			<tr class="second">
				<td width="30%"><lable class="word">用户实名：</lable></td>
				<td><input type="text" class="txt" id="username" value=""/></td>
			</tr>
			<tr class="second">
				<td width="30%"><lable class="word">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</lable></td>
				<td><input type="password" class="txt" id="password" value=""/></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center; font-size: 10px;">
					密码如果不需要修改则本项不变
				</td>
			</tr>
			<tr class="second">
				<td width="30%"><lable class="word">密码确认：</lable></td>
				<td><input type="password" class="txt" id="confirm_password" value=""/></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center; font-size: 10px;">
					密码如果不需要修改则本项不变
				</td>
			</tr>
			<tr class="second">
				<td width="30%"><lable class="word">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</lable></td>
				<td><input type="radio" value="true" style="margin-left: 20px;" name="gender" />男
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" value="false" name="gender" />女
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" id="ths" value="模型选择">	
				</td>
			</tr>
			<tr class="second" style="height: 15px;"><td colspan="2"></td></tr>
			<tr class="second">
				<td colspan="2" height="60px" style="text-align: center;">
					<img id="model1"/>
					<img id="model2"/>
				</td>
			</tr>
			<tr class="second">
                <td colspan="2" class="button1">
					<button onclick="update()">保存信息</button>
				</td>
			</tr>
		</table>
		<script>
			request( "POST","<%=basePath%>/user/iniUserInfo",{},iniUserInfoSuccess,serverError,true);	
			
		    var json;
	  		function iniUserInfoSuccess( responseData ) {	 
				console.log( responseData.data );
				json = responseData.data ;
				
				$( "#account" ).val(json.account);
				$( "#username" ).val(json.username);
				var model1 = $( "#model1" );
				var model2 = $( "#model2" );
				model1.css("width","50px");
				model1.css("height","60px");
				model1.css("display","inline-block");
				model2.css("width","50px");
				model2.css("height","60px");
				model2.css("display","inline-block");
				
				$("input:radio").each(function() {
					if( eval( $(this).val() ) === json.sex ){
						console.log("sex",json.sex);
						$(this).attr('checked','true');
						return;
					}
				});
				
				if( eval( $('input:radio[name="gender"]:checked').val() ) === true ) {
				    // do something	
					model1.attr("src","<%=basePath%>/images/data/model/mheadA.png");
					model2.attr("src","<%=basePath%>/images/data/model/mheadB.png");
				}else{
					model1.attr("src","<%=basePath%>/images/data/model/wheadA.png");
					model2.attr("src","<%=basePath%>/images/data/model/wheadB.png");
				}
				
				$("img").each(function() {
					if($(this).attr("src").substr($(this).attr("src").lastIndexOf("i")) === json.profile_photo ){
						console.log("img",$(this).attr("src").substr($(this).attr("src").lastIndexOf("i")));
						$(this).addClass('active');
						$(this).addClass('insert');
						return;
					}		
				})		
				
				$("input:radio").click(function(){
				    var value = $(this).val();  //获取选中的radio的值
				    $('#model1').removeClass('active');
					$('#model1').removeClass('insert');
					$('#model2').removeClass('active');
					$('#model2').removeClass('insert');
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
						$('#model2').removeClass('insert');
					});
					 $('#model2').click(function() {
						$(this).addClass('insert');
						$(this).addClass('active');
						$('#model1').removeClass('active');
						$('#model1').removeClass('insert');
					});
				
			}
			
	  		function update() {
				if( $( "#account" ).val().trim().length == 0 || $( "#username" ).val().trim().length == 0 || 
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
					var model_code
					var imgCheck = $( ".active" );
					var suffix = imgCheck.attr("src").substr(imgCheck.attr("src").lastIndexOf("i"));
					var user = {
									"account" : account,
									"username": username,
									"password": password,
									"sex": sexCheck,
									"profile_photo": suffix
								};
					request( "POST","<%=basePath%>/normal/update",user,updateSuccess,serverError,true );
				}			
				
			}
			function updateSuccess (data) {
				console.log("registerSuccess",data);
				showMessage(data);
				if( data.code == 300 ){	
					//parent.topFrame.banner.location.reload();
					parent.parent.banner.location.reload();
					//self.parent.banner.location.reload();
				}
			}
			
		</script>
	</body>
</html>