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
		<style>
			body{
				width:200px;
			}
		</style>
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
		
		<link rel="stylesheet" href="<%=basePath%>/css/suit-category.css">
		
	</head>
	<body>
		<div id="Big">
		
			<div id="medium">
				<div id="small">
					<div id="word">服装类型</div>
					<lable id= "num1">编号:</lable>
					<input type='text' id='num_txt' name='num' value=''/>
					<lable id="type1">类型:</lable>
					<input type='text' id='type_txt' name='type' value=''/>
					<button id="add">添加</button>
				</div>
		   
				<div id="cloth">				
					<div id="word">
						服装类型
					</div>				
					<lable id= "num1">编号:</lable>
					<input type='text' id='num_txt2' name='num' value=''/>
					<lable id="type1">类型:</lable>
					<input type='text' id='type_txt2' name='type' value=''/>
					<button id="update">保存</button>
					<button id="delete">删除</button>
					
				</div>
					
			</div>
				
    	</div>
    	
    	<script>	
			$(document).ready(function(){
				
				/* 初始化所有类别 */
				request( "POST", "<%=basePath%>/user/iniCategory", {},iniCategorySuccess,serverError,true );
				
				function iniCategorySuccess ( responseData ) {					
					showMessage( responseData );
					categories = responseData.data;				
					$.each( categories, function( i, category ) {
						
						var category_code = category.category_code;
						var category_name =  category.category_name;
						var templateClone = $("#cloth").clone(true).css("display","block").appendTo("#medium");
						templateClone.find("input[name='num']").attr("value", category_code);
						templateClone.find("input[name='num']").attr("preValue", category_code);
						templateClone.find("input[name='type']").attr("value", category_name);
						
					});
				}
				
				/* 添加类别 */
				$('#add').click(function(){
					var num_txt = $(this).parent().find("input[name='num']").val();
					var type_txt = $(this).parent().find("input[name='type']").val();
					if(num_txt.trim().length==0){
						alert("编号不能为空");
					}else if(type_txt.trim().length==0){
						alert("服装类型不能为空");
					}else{
						var category = {
								category_code : num_txt ,
								category_name : type_txt
							};
						console.log( category );
						request( "POST", "<%=basePath%>/admin/addCategory", category,addSuccess,serverError,true );
						
						var refreshDiv = $(this).parent().find("input[type='text']")
						
						function addSuccess ( responseData ) {
							
							showMessage( responseData );
							
							if( responseData.code == 605 ) {	
								refreshDiv.val("");
								var c = $("#cloth").clone(true).css("display","block").appendTo("#medium");
								c.find("input[name='num']").attr("value",num_txt);
								c.find("input[name='num']").attr("preValue",num_txt);
								c.find("input[name='type']").attr("value",type_txt);
							}
						}
					}
				});
				
				/* 修改类别信息 */
				$('#update').click(function(){
					var num_txt = $(this).parent().find("input[name='num']").val();
					var preValue = $(this).parent().find("input[name='num']").attr('preValue');
					var type_txt = $(this).parent().find("input[name='type']").val();
					//保存编号和类型，如果数据库中有相同编号，alert(信息已存在)
					//否则alert（修改成功）
					var category = {
							category_code : num_txt ,
							category_name : type_txt
						};
					console.log( category );
					request( "POST", "<%=basePath%>/admin/updateCategory/"+preValue, category, updateSuccess,serverError,true );
					
					/* 保存当前操作元素，使其再函数中可以使用 */
					var updateDiv = $(this).parent('div');
					function updateSuccess( responseData ) {
						
						showMessage( responseData );
						console.log(updateDiv);
						updateDiv.find("input[name='num']").attr("preValue", responseData.data.category_code);
						
					}
				})
				
				/* 删除类别 */
				$('#delete').click(function(){
					
					var category_code = $(this).parent().find("input[name='num']").val();
					var type_txt = $(this).parent().find("input[name='type']").val();
					//在数据库中找到对应编号将其删除，也可能找不到(如果用户没有点保存直接点删除，就donothing)
					if(confirm("确认删除"+type_txt+"吗？")){
						
						var category = {
								category_code : category_code ,
								category_name : type_txt
							};
						request( "POST", "<%=basePath%>/admin/deleteCategory", category, querySuccess,serverError,true );
						
						var deleteDiv = $(this).parent('div');
						function querySuccess( responseData ) {
							
							showMessage( responseData );
							
							if( responseData.code == 606 ) {
								
								deleteDiv.remove();
								
							}
						}
					}
					
				})
				
				
				
			});
		</script>
	</body>
</html>