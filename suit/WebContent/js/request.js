/**
 * 
 */
function request(method,url,data,successCallBack,errorCallBack,async){
    $.ajax({
        url: url,
        async:async,
        contentType: "application/json",
        data: JSON.stringify(data),
        method: method,
        success:successCallBack,
        error:errorCallBack
    });
}

function showMessage(responseData){
	console.log("showMessage",responseData);
	alert(responseData.description);
}

function serverError(XMLHttpRequest, textStatus){
    console.log("responseText:",XMLHttpRequest.responseText);
    console.log("status:",XMLHttpRequest.status);
    console.log("textStatus:",textStatus);
    console.log("readyState:",XMLHttpRequest.readyState);
    alert("服务器错误，请检查前后台控制台输出！");
}
