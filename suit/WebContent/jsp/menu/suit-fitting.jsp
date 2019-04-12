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
		<title>3D Fitting room</title>

	    <script src="<%=basePath%>/js/jquery.min.js" type="text/javascript"></script>
	    <script src="<%=basePath%>/js/main.js" type="text/javascript"></script>
	
	    <link rel="stylesheet" href="<%=basePath%>/css/suit-3d-fitting.css">
	</head>
	<body>
	
		<!--服饰详细信息的模板容器-->
	    <div id="suitTemplate">
	        <img class="imgBox" alt="图片正在路上" src=""/>
	        <div>
	        	<span>编码:</span>
	        	<span class="codeBox"></span>
	        </div>
	        <div>
	        	<span>名称:</span>
	        	<span class="nameBox"></span>
	        </div>
	        <div >
	        	<span>单价:</span>
	        	<span class="priceBox"></span>
	        </div>
	        <div class="clothes_info"></div>
	        <input class="dress-off" type="button" value="脱下" />
	        <input class="dress-up" type="button" value="穿上" />
	    </div>
		
		<!--3d场景容器-->
	    <div id="WebGL-Container">
	
	        <div id="suit-container">
	            <!--按服饰分类的选择容器-->
	            <div id="suit-select">
	                <label for="suit-list">选择分类</label>
	                <select id="suit-list" onchange="query()">
	                </select>
	            </div>
	
	            <!--存放选择值的查询结果-->
	            <div id="suit-item"></div>
	        </div>
	
	        <!--选中的服饰的容器-->
	        <div id="suit-selected"></div>
	
	        <!--选中服饰的总价的容器-->
	        <div id="totalPrice">
	            <div class="sum_title">总价：</div>
	            <div class="sum_value">0</div>
	        </div>
	        
	    </div>
	
	    <script>
	
	    </script>
	
	    <!--加载3D场景需要的JS库-->
	    <script src="<%=basePath%>/js/three.js"></script>
	    <script src="<%=basePath%>/js/loaders/MTLLoader.js"></script>
	    <script src="<%=basePath%>/js/loaders/OBJLoader.js"></script>
	    <script src="<%=basePath%>/js/controls/OrbitControls.js"></script>
	    <script src="<%=basePath%>/js/loaders/TGALoader.js"></script>
	    <script src="<%=basePath%>/js/loaders/DDSLoader.js"></script>
	    <script src="<%=basePath%>/js/WebGL.js"></script>
	
	    <!--按数据库返回数据封装的3D场景加载器-->
	    <script src="<%=basePath%>/js/WebGL-scene/initScene.js"></script>
	    <script src="<%=basePath%>/js/WebGL-scene/initDress.js"></script>
	
	    <script>
	
	        /*检测浏览器是否支持WebGL*/
	        if ( WEBGL.isWebGLAvailable() === false ) {
	
	            document.body.appendChild( WEBGL.getWebGLErrorMessage() );
	
	        }
	
	        /*初始化3D场景*/
	        var scene = new THREE.Scene();
	
	        initScene( scene );
	
	        /*从数据库取类别数据
	        * 初始化类别选择框的所有值
	        * */
	        request( "POST", "<%=basePath%>/user/iniCategory", {},initCategorySelections,serverError,true );
	        function initCategorySelections( responseData ) {
	        	$("#suit-list").append("<option value=''>请选择分类</option>");
	        	var categories = responseData.data;	
	            $.each( categories , function ( i, category ) {
				
	                var category_code = category.category_code;
	                var category_name =  category.category_name;
	                $("#suit-list").append("<option value='"+category_code+"'>"+category_name+"</option>");
	
	            });
	        }
			
	        request( "POST", "<%=basePath%>/normal/iniUserModel", {},iniUserModelSuccess,serverError,true );
	        /*初始化人物模型(未穿衣服的状态)*/
	        function iniUserModelSuccess( responseData ) {
	        	initDress( responseData.data.model_name , '<%=basePath%>/'+responseData.data.model_path , scene);
	        }
	        
	        request( "POST", "<%=basePath%>/normal/iniUserDress", {},iniUserDressSuccess,serverError,true );
	        /*初始化人物服装(每个用户有自己独立的试衣间)*/
	        function iniUserDressSuccess( responseData ) {
	        	var dressAll = responseData.data;
	        	var totalPrice = 0;
				$.each( dressAll, function( i, dress ) {
					console.log(dress.clothes_code+","+dress.clothesobj_path)
					initDress( dress.clothes_code , '<%=basePath%>/'+dress.clothesobj_path , scene);
					
					var iniDiv = $( "#suitTemplate" ).clone( true );
					iniDiv.css( "display", "block" );
					iniDiv.css( "width", "120px" );
					iniDiv.css( "height", "100px" );
					iniDiv.find( ".dress-up" ).css( "display", "none" );
					iniDiv.find( ".dress-off" ).css( "display", "block" );
					iniDiv.find( ".imgBox" ).remove();
					
					iniDiv.find( ".codeBox" ).text(dress.clothes_code );
					iniDiv.find( ".nameBox" ).text(dress.clothes_name );
					iniDiv.find( ".priceBox" ).text(parseFloat( dress.price ).formatMoney() );
					iniDiv.find( ".clothes_info" ).attr( "path", dress.clothesobj_path );
					iniDiv.find( ".clothes_info" ).attr( "code", dress.clothes_code );
					iniDiv.find( ".clothes_info" ).attr( "price", dress.price );
					
		            $( "#suit-selected" ).append( iniDiv );
		
		            totalPrice = Number(totalPrice) +  Number(dress.price);
					
				});
				var t = $( "#totalPrice" );
				console.log(parseFloat(totalPrice));
	            t.find( ".sum_value").attr( "price", totalPrice) ;
	            t.find( ".sum_value").text( parseFloat(totalPrice).formatMoney() ) ;
	        }
	        
	        /*
	        * 初始化查询结果
	        * */
			function query() {
	        	
	        	$("#suit-item").children().remove();	        	
	        	var category_code = $("#suit-list option:selected").val();
	        	var clothes = {
						"category_code":category_code
				}
				request( "POST", "<%=basePath%>/normal/queryClothesInfo", clothes ,showClothesList,serverError,true );
		
		        function showClothesList( responseData ) {
		        	var clothes = responseData.data;
		        	console.log(clothes);
		            $.each( clothes, function (i , perClothes) {
		
		                var perClothesDiv = $( "#suitTemplate" ).clone( true );
		                perClothesDiv.css( "display", "block" );
		                perClothesDiv.find( ".dress-off" ).css( "display", "none" );
		
		                perClothesDiv.find( ".imgBox" ).attr( "src", "<%=basePath%>/"+perClothes.clothes_path ) ;
		                perClothesDiv.find( ".codeBox" ).text(perClothes.clothes_code );
		                perClothesDiv.find( ".nameBox" ).text(perClothes.clothes_name );
		                perClothesDiv.find( ".priceBox" ).text(parseFloat( perClothes.price ).formatMoney() );
		                perClothesDiv.find( ".clothes_info" ).attr( "path", perClothes.clothesobj_path );
		                perClothesDiv.find( ".clothes_info" ).attr( "code", perClothes.clothes_code );
		                perClothesDiv.find( ".clothes_info" ).attr( "price", perClothes.price );
		
		                $( "#suit-item" ).append( perClothesDiv );
		            } );
		        }
	        }
	
	        /*脱下衣服的事件*/
	        $( ".dress-off" ).click(function (  ) {
	            var clothes_code = $( this ).parent().find( ".clothes_info" ).attr( "code" );
	            var price = $( this ).parent().find( ".clothes_info" ).attr( "price" );
				
	            var t = $( "#totalPrice" );
	            var totalPrice = t.find( ".sum_value" ).attr("price");
	            totalPrice = Number(totalPrice) -  Number(price);
	            t.find( ".sum_value").attr( "price", totalPrice) ;
	            t.find( ".sum_value").text( parseFloat(totalPrice).formatMoney() ) ;
	
	            removeDress( clothes_code, scene);
	            $( this ).parent().remove();
	            
	            var dress = {
	            	 "account": "",
           		     "clothes_code":clothes_code
	            }
	            request( "POST", "<%=basePath%>/normal/deleteDress", dress,deleteDressSuccess,serverError,true );
		        function deleteDressSuccess( responseData ) {
		        	console.log(responseData);
		        }
	        });
	
	        function removeDress( clothes_code, scene ) {
	            var t2 = scene.getObjectByName( clothes_code );
	            scene.remove(t2);
	        }
	
	        /*穿上衣服的事件*/
	        $( ".dress-up" ).click(function () {
	            var clothes_path = $( this ).parent().find( '.clothes_info' ).attr( 'path' ) ;
	            var clothes_code = $( this ).parent().find( ".clothes_info" ).attr( "code" );
	            var price = $( this ).parent().find( ".clothes_info" ).attr( "price" );
	            <%-- initDress( 'hair04' , '<%=basePath%>/'+'suits/female/hair/hair04/' , scene); --%>
	            // initDress( 'clothes02' , '../suit/female/clothes/clothes02/' , scene);
	            // initDress( 'trousers01' , '../suit/female/trousers/trousers01/' , scene);
				/* alert(clothes_path+","+clothes_code); */
				var suitSelected = $( this ).parent().clone( true );
				var dress = {
	            		 "account": "",
            		     "clothes_code":clothes_code
	            }
	            request( "POST", "<%=basePath%>/normal/saveDress", dress,saveDressSuccess,serverError,true );
		        function saveDressSuccess( responseData ) {
		        	if( responseData.code == 200 ) {
			        	initDress( clothes_code , '<%=basePath%>/'+clothes_path , scene);
			        	
			            suitSelected.css( "display", "block" );
			            suitSelected.css( "width", "120px" );
			            suitSelected.css( "height", "100px" );
			            suitSelected.find( ".dress-up" ).css( "display", "none" );
			            suitSelected.find( ".dress-off" ).css( "display", "block" );
			            suitSelected.find( ".imgBox" ).remove();
			
			            $( "#suit-selected" ).append( suitSelected );
						
			            var t = $( "#totalPrice" );
			            var totalPrice = t.find( ".sum_value" ).attr("price");
			            totalPrice = Number(totalPrice) +  Number(price);
			            t.find( ".sum_value").attr( "price", totalPrice) ;
			            t.find( ".sum_value").text( parseFloat(totalPrice).formatMoney() ) ;
			            
		        	} else {
		        		showMessage(responseData);
		        	}
			            
		        }
		        
	        });
	        
	    </script>
	</body>
</html>