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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>服装管理</title>
		<script src="<%=basePath%>/js/jquery.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/vendor/jquery.ui.widget.js"></script>
		<script src="<%=basePath%>/js/jquery.iframe-transport.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/jquery.fileupload.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/main.js" type="text/javascript"></script>
		<link href="<%=basePath%>/css/main.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath%>/css/jquery.fileupload.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath%>/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="<%=basePath%>/css/suits.css">
		
	</head>
	 <style>
		 #uploaderContainer{
		 		position: relative;
	            display: inline-block;
	            text-align: center;
		 }
		 #uploaderContainer input{
				position:relative;
				top:-20px;
				opacity: 0.0;
		}
		#uploaderContainer img{
				margin-top: 0;
		}
	 </style>
	<body>
		<div id="queryTerms" class="qiery">

			 <label >性别:</label>
			 <select class="gender" name="gender" id="gender">
	 			<option value="true">男</option>
	  			<option value="false">女</option>
			</select>
			<label>服饰类别:</label>
			 <select name="apparel" id="apparel"></select>
			<button class="button" id="query" onclick="queryClothes()">查询</button>
		</div>
		
		<!-- 模板 -->
		<div id="form1" class="insert" style="display:none;">
			<div style="position:relative;margin-top:1%; ">
				<img style="width: 100%;height:30px;position: relative;" src="<%=basePath%>/images/ui/suitTitle.png" />
				<span style="position: absolute; top: 10%; left:45%;height:100%;font-size:18px;">服饰细目</span>
			</div>
			<!-- 左边盒子 -->
			<div class="left">
			<div >
				 <label class='sno' >编号:</label>
				 <input type="text" size="20px" id="clothes_code" >
			</div>
			<div>
				 <label class='name' >名称:</label>
				 <input type="text" size="20px" id="clothes_name" >
			</div>
			<div >
				 <label class='price' >价格:</label>
				 <input type="text" size="20px" id="price" >
			</div>
			<div>
				 <label class='name' >性别:</label>
				 <select class="gender" name="gender" id="gender">
	 				<option value="true">男</option>
	  				<option value="false">女</option>
				</select>
			</div>
			<div>
				 <label class='name' >分类:</label>
				 <select name="apparel"  id="apparel">
				</select>
			</div>
			</div>
			<!-- 右边盒子 -->
			<div id="uploaderContainer" class="right">			
				<span>点击添加图片</span>
				<input type="file" id="uploaderImg" name="files[]" onclick="uploadFileRequest($(this).parent().parent(),'<%=basePath%>/images/data/suits/')"/>
			   	<img id="suitImage" border="0" src="<%=basePath%>/images/data/suits/unknown.png" width="200" height="125">			   
			</div>
			 <hr style="width:100%;margin-top:5%;border:none;border-top:1px solid #BFEFFF;" />			
				<button class="button" id="add" >添加</button>
				<button class="button" id="save" >保存</button>
				<button class="button" id="delete">删除</button>
			
		</div>
			
		<div id="clone"></div>
		
		<script>
		var cloneObj;
		<%-- $('#a-img').click(function(){
		    $(this).parent().find('#uploaderImg').click();
		    console.log("asas",$(this).parent().parent());
		    uploadFileRequest($(this).parent().parent(),"<%=basePath%>/images/data/suits/");
		}); --%>
		function uploadFileRequest(suit,urlPrefix){
			suit.find("#uploaderContainer input").fileupload({
					url:"<%=basePath%>/admin/uploadImage?code="+suit.find("#clothes_code").val(),
				    dataType: 'json',
				    done: function (e, data) {
				    	//suit.find("#imageUrl").val(data.result.description);
				    	suit.find("#uploaderContainer img").attr("src",urlPrefix+data.result.description);				  
				    	showMessage({"code":0,"description":data.result.description+"上传成功！"});
				        }
				});
		}
		
		$(document).ready(function(){			
			request( "POST", "<%=basePath%>/user/iniCategory", {},iniCategorySuccess,serverError,true );		
			function iniCategorySuccess ( responseData ) {
				categories = responseData.data;				
				$.each( categories, function( i, category ) {
					//console.log(category.category_code,category.category_name)					
					var category_code = category.category_code;
					var category_name =  category.category_name;
					var slt1 = $("#queryTerms").find("select[name='apparel']");
					slt1.append("<option value='"+category_code+"'>"+category_name+"</option>");					
					var slt2 = $("#form1").find("#apparel");
					slt2.append("<option value='"+category_code+"'>"+category_name+"</option>");
				});
				cloneObj = $("#form1").clone(true);
				cloneObj.find(".right").remove();
				cloneObj.find("#save").remove();
				cloneObj.find("#delete").remove();
				cloneObj.addClass('addmodel');
				cloneObj.find("span").css({"left":"35%"});
				cloneObj.css({"width":"210px","height":"250px"});
				cloneObj.css("display","inline").appendTo("#clone");
				cloneObj.css("display","inline").appendTo("#clone");
			}
		});
		
		function queryClothes() {
			var divs = $("#clone").children();
			divs.remove();
			
			cloneObj = $("#form1").clone(true);
			cloneObj.find(".right").remove();
			cloneObj.find("#save").remove();
			cloneObj.find("#delete").remove();
			cloneObj.addClass('addmodel');
			cloneObj.find("span").css({"left":"35%"});
			cloneObj.css({"width":"210px","height":"250px"});
			cloneObj.css("display","inline").appendTo("#clone");
			cloneObj.css("display","inline").appendTo("#clone"); 
			var sex = $("#queryTerms").find("select[name='gender']").val();
			var category_code = $("#queryTerms").find("select[name='apparel']").val();
			cloneObj.find("#gender").val(sex);
			cloneObj.find("#apparel").val(category_code);
			
						
			console.log(sex,category_code);
			var clothes = {
					"category_code":category_code,
					"clothes_sex":sex
			}
			request( "POST", "<%=basePath%>/normal/queryClothes", clothes,queryClothesSuccess,serverError,true );
		}
		
		function queryClothesSuccess(responseData) {
			console.log(responseData);
			
			var allClothes = responseData.data;
			$.each(allClothes, function( i, clothes ) {									
				var clothes_code = clothes.clothes_code;
				var clothes_name =  clothes.clothes_name;
				var price =  clothes.price;
				var category_code =  clothes.category_code;
				var clothes_sex = ""+clothes.clothes_sex;
				var clothes_path = clothes.clothes_path;
				var cloneObj2 = $("#form1").clone(true);
				cloneObj2.find("#add").remove();
				cloneObj2.find("#save").css({"left":"20%"});
				cloneObj2.find("#delete").css({"left":"25%"});
				cloneObj2.find("#clothes_code").val(clothes_code);
				cloneObj2.find("#clothes_name").val(clothes_name);
				cloneObj2.find("#price").val(price);
				cloneObj2.find("#gender").val(clothes_sex);
				cloneObj2.find("#apparel").val(category_code);
				if(clothes_path != null){
					console.log("<%=basePath%>/"+clothes_path);
					cloneObj2.find("#uploaderContainer img").attr("src","<%=basePath%>/"+clothes_path);
					console.log(cloneObj2.find("#uploaderContainer img").attr("src"));
				}				
				cloneObj2.addClass(clothes_code);
				cloneObj2.css("display","inline").appendTo("#clone");				
			});
			
		}		
		//服饰细目点击添加克隆出填好信息的盒子			
			$('#add').click(function(){
				var clothes_code = $(this).parent().find("#clothes_code").val();
				var clothes_name =  $(this).parent().find("#clothes_name").val();
				var price =  parseFloat( $(this).parent().find("#price").val() );
				var price_format = price.formatMoney();
				var category_code =  $(this).parent().find("select[name='apparel']").val();
				var clothes_sex = $(this).parent().find("select[name='gender']").val();
				if(clothes_code.trim().length == 0||clothes_name.trim().length == 0||price.toString().trim().length == 0){
					alert("信息不完整");
				}else if (isNaN(price)) {
					alert("价格应为数字");
				}else{
					var clothes = {
							"clothes_code":clothes_code,
							"category_code":category_code,
							"clothes_name":clothes_name,
							"price":price,
							"clothes_sex":clothes_sex
					}
					request( "POST", "<%=basePath%>/admin/addClothes", clothes,addClothesSuccess,serverError,true );
				}
				
			});
		
		function addClothesSuccess(responseData) {
			showMessage( responseData );			
			if(responseData.code==200){
				var clothes = responseData.data;
				var clothes_code = clothes.clothes_code;
				var clothes_name =  clothes.clothes_name;
				var price =  clothes.price;
				var category_code =  clothes.category_code;
				var clothes_sex = ""+clothes.clothes_sex;
				var cloneObj1 = $("#form1").clone(true);
				cloneObj1.find("#add").remove();
				cloneObj1.find("#save").css({"left":"20%"});
				cloneObj1.find("#delete").css({"left":"25%"});
				cloneObj1.find("#clothes_code").val(clothes_code);
				cloneObj1.find("#clothes_name").val(clothes_name);
				cloneObj1.find("#price").val(price);
				cloneObj1.find("#gender").val(clothes_sex);
				cloneObj1.find("#apparel").val(category_code);
				cloneObj1.addClass(clothes_code);
				
				cloneObj1.css("display","inline").appendTo("#clone");
				cloneObj.find("#clothes_code").val("");
				cloneObj.find("#clothes_name").val("");
				cloneObj.find("#price").val("");
			}					
		}
		//删除盒子
			$('#delete').click(function(){
				var clothes_name =  $(this).parent().find("#clothes_name").val();
				var clothes_code = $(this).parent().find("#clothes_code").val();
				if(confirm("确认删除"+clothes_name+"吗？")){					
					var clothes = {
							"clothes_code" : clothes_code 
						};
					
					request("POST","<%=basePath%>/admin/deleteClothes",clothes,deleteClothesSuccess,serverError,true );					
					var deleteDiv = $(this).parent('div');
					function deleteClothesSuccess( responseData ) {						
						showMessage( responseData );						
						if( responseData.code == 500 ) {							
							deleteDiv.remove();
							
						}
					}
				}				
			});
		
		
			$('#save').click(function(){
				var clothes_code = $(this).parent().find("#clothes_code").val();
				var clothes_name =  $(this).parent().find("#clothes_name").val();
				var price =  $(this).parent().find("#price").val();
				var category_code =  $(this).parent().find("select[name='apparel']").val();
				var clothes_sex = $(this).parent().find("select[name='gender']").val();
				if(clothes_code.trim().length == 0||clothes_name.trim().length == 0||price.trim().length == 0){
					alert("信息不完整");
				}else if (isNaN(price)) {
					alert("价格应为数字");
				}else{
					var clothes = {
							"clothes_code":clothes_code,
							"category_code":category_code,
							"clothes_name":clothes_name,
							"price":price,
							"clothes_sex":clothes_sex
					}
					request( "POST", "<%=basePath%>/admin/updataClothes", clothes,updataClothesSuccess,serverError,true );
				}
				
				function updataClothesSuccess( responseData ) {						
					showMessage( responseData );						
					
				}
				
			});
		</script>
	</body>
</html>