
$("input:radio").click(function(){
    var value = $(this).val()  //获取选中的radio的值
    var model1 = $( "#model1" );
	var model2 = $( "#model2" );
	model1.css("width","50px");
	model1.css("height","60px");
	model1.css("display","inline-block");
	model2.css("width","50px");
	model2.css("height","60px");
	model2.css("display","inline-block");
    if( value == "M" ) {
		model1.attr("src","../images/data/model/mheadA.png");
		model2.attr("src","../images/data/model/mheadB.png");
	} else {
		model1.attr("src","../images/data/model/wheadA.png");
		model2.attr("src","../images/data/model/wheadB.png");
	}
});

$("img").click(function(){
	$('#model1').click(function() {
		$(this).addClass('insert');
		$('#model2').removeClass('no_insert');
	});
	 $('#model2').click(function() {
		$(this).addClass('no_insert');
		$('#model1').removeClass('insert');
	});
	
});

function register() {
	var account = $( "#account" );
	var username = $( "#username" );
	var password = $( "#password" );
	var confirm_password = $( "#confirm_password" );
	var sexCheck = $( "input[name=gender]:checked" );
	/* var imgCheck = $( "img[state=checked]" ); */
	if( password.val() != confirm_password.val() ) {
		alert("两次密码输入不一致");
	} else {
		var user = {
						"account" : account.val(),
						"username": username.val(),
						"password": password.val(),
						"sex": sexCheck.val(),
						"model_path": "images/data/model/mheadA.png"
					};
		request( "POST","../user/register",user,registerSuccess,serverError,true );
	}			
}
function registerSuccess (data) {
	console.log("registerSuccess",data);
	if(data.code==0){
		showMessage(data); 
		$(window).attr( "location", "../jsp/login.jsp");
//		<%-- request( "POST","<%=basePath%>"+data.nextAction,{},showMessage,serverError,true ); --%>
	}
}