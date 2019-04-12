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
		<meta charset="utf-8">
		<title>用户管理界面</title>
		
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
		
		<link rel="stylesheet" href="<%=basePath%>/css/user-manage.css">
		
	</head>
	<body>
		<table id="tip">
			<tr id="first">
			   <td width="64px" class="a">id</td>
			   <td width="154px" class="a">用户名称</td>
			   <td width="154px" class="a">用户实名</td>
			   <td width="90px" class="a">性别</td>
			   <td width="154px" class="a">模型选择</td>
			   <td width="192px" class="a">是否管理员</td>
			   <td width="192px" class="a">操作</td>
			</tr>
			<tr id="userInfo">
			   <td width="64px"   class="b"></td>
			   <td id="2" width="154px"  class="b"></td>
			   <td width="154px"  class="b"></td>
			   <td width="90px"  class="b"></td>
			   <td width="154px"  class="b"></td>
			   <td width="192px"  class="b"></td>
			   <td width="192px"  class="b">
				   <button id= "update">修改</button>
				   <button id="delete">删除</button>
			   </td>
			</tr>
		</table>
		
		<table id="message">
			<tr class="first"><td colspan="2" width="100%" class="a2">修改信息</td></tr>
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
				<td width="30%"><lable class="word2">是否为管理员?</lable>
				<td>
					<input type="radio" style="margin-left:35px;" value="true" name="permission" />是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 	<input type="radio" value="false" name="permission" />否
				</td>
			</tr>
			<tr class="second">
                <td colspan="2" class="button1">
					<button onclick="updateAdmin()">保存信息</button>
					<button onclick="closecontents()">关闭窗口</button>
				</td>
			</tr>
		</table>
		
		
		
	    <script>	    
	    	$(document).ready(function(){
				//管理员查询所有账户				
				request( "POST", "<%=basePath%>/admin/queryAll", {},queryAllSuccess,serverError,true );				
	    		function queryAllSuccess( responseData ) {	
	    			console.log(responseData);
					showMessage( responseData );					
					if( responseData.code == 502 ) {
						$.each( responseData.data , function(key, user) {
			    			var str="";
			    			var Sex ="";
			    			var Ifsuper ="";
			    			//性别
			    			if( user.sex ){
			    				Sex = "男";
			    			} else {
			    				Sex = "女";
			    			}
			    			//是否管理员
			    			if( user.permission ){
			    				Ifsuper = "是";
			    			} else {
			    				Ifsuper = "否";
			    			}
			    			//其他信息
			    			var userInfo = $("#userInfo").clone(true).css("display","table-row");
			    			userInfo.find("td:eq(0)").html( user.id);
			    			userInfo.find("td:eq(1)").text( user.account);
			    			userInfo.find("td:eq(2)").html( user.username);
			    			userInfo.find("td:eq(3)").html( Sex );
			    			userInfo.find("td:eq(5)").html( Ifsuper );			    			
			    			//显示头像
			    			var basePath = "<%=basePath%>" ;
			    			var profile_photo_path = user.profile_photo;
			    			var imgPath = basePath + "/" + profile_photo_path;
			    			var img = new Image();
			    			img.src = imgPath;
			    			img.style.width = "50px";
			    			img.style.height = "60px";
			    			userInfo.find("td:eq(4)").html( img );							
			    			$("#tip").append( userInfo );
			    		});
						
					}
				}
				
	    		//管理员修改某一账户
	    		$('#update').click(function(){	    			
	    			var deleteDiv = $( this ).parent().parent();	
					var user = {
		    			"account" : deleteDiv.find("td:eq(1)").text() 
		    		};
					request( "POST","<%=basePath%>/admin/query",user,querySuccess,serverError,true);
					$('#message').css('display','block');
/* 					$('#update').css('disabled':'disabled');
					$('#delete').css('disabled':'disabled'); */
				})
	    		
	    		function querySuccess( responseData ) {							
	    			//showMessage( responseData );							
					if( responseData.code == 303 ) {								
						var json = responseData.data;
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
						
						$("input[name=gender]").each(function() {
							if( eval( $(this).val() ) === json.sex ){
								console.log("sex",json.sex);
								$(this).attr('checked','true');
								return;
							}
						});
						$("input[name=permission]").each(function() {
							if( eval( $(this).val() ) === json.permission ){
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
						
						$("input[name=gender]").click(function(){
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
				}
				
				
				
				
				
				
				
	    		//管理员删除账户
				$('#delete').click(function(){
					var deleteDiv = $( this ).parent().parent();	
					if(confirm("确认删除账户吗？")){
						var user = {
			    			"account" : deleteDiv.find("td:eq(1)").text() 
			    		};			    		
			    		request( "POST", "<%=basePath%>/admin/deleteUser", user,deleteSuccess,serverError,true );			    		
					}
					function deleteSuccess( responseData ) {
						showMessage( responseData );						
						if( responseData.code == 500 ) {								
							deleteDiv.remove();
						}						
					}
				})
	    	});
	    	
	    	function updateAdmin() {
	    		if( $("#account" ).val().trim().length == 0 || $( "#username" ).val().trim().length == 0 || 
						$( "input[name=gender]:checked" ) == "false" || ! $( "img" ).hasClass("active") || 
						$( "input[name=permission]:checked" ) == "false") {
						alert("信息不完整");	
					}else if( $( "#confirm_password" ).val() != $( "#password" ).val() ) {
						alert("两次密码输入不一致");
					} else {
						var account = $( "#account" ).val();
						var username = $( "#username" ).val();
						var password = $( "#password" ).val();					
						var confirm_password = $( "#confirm_password" ).val();
						var sexCheck = $( "input[name=gender]:checked" ).val();
						var permission = $( "input[name=permission]:checked" ).val();
						var imgCheck = $( ".active" );
						var suffix = imgCheck.attr("src").substr(imgCheck.attr("src").lastIndexOf("i"));
						var user = {
										"account" : account,
										"username": username,
										"password": password,
										"sex": sexCheck,
										"permission":permission,
										"profile_photo": suffix
									};
						request( "POST","<%=basePath%>/admin/updateAdmin",user,updateAdminSuccess,serverError,true );
					}
			}
	    	function updateAdminSuccess (data) {
				console.log("registerSuccess",data);
				$('#message').css('display','none');
				showMessage(data);
				location.reload();
			}
	    	function closecontents() {
    			$('#message').css('display','none');
			}
	    </script>
	</body>
</html>