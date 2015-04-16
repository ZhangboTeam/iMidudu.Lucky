var AuthcationServiceUrl = "/ajax/AuthcationService.asmx/";
function Login(userName, password, successHandler, errHandler) {
    callAjaxWebService(AuthcationServiceUrl, "Login", { UserName: userName, Password: password }, successHandler, errHandler);
}
function callAjaxWebService(serviceUrl, methodName, param, successHandler, errHandler) {
    window.status = "";
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: serviceUrl + methodName,
        data: JSON.stringify(param),
        dataType: 'json',
        success: function (result) {
            if (successHandler != null) {
                successHandler(result.d);
            } else {

                $.gritter.add({
                    title: 'MQE',
                    text: 'Save Data Success!<br/>',
                    class_name: 'gritter-success gritter-light'
                });
                window.status = "OK:" + methodName + ",param: " + JSON.stringify(param);
            }
        },
        error: function (err) {
            if (errHandler != null) {
                errHandler(err);
            } else {
                window.status = serviceUrl + methodName + "," + err.responseText;
            }
        }
    });
}