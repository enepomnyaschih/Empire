function applyHTMLLocale()
{
    applyLoginPanelLocale();
}

function initLoginPanel()
{
    if (Data.memberId)
        showLogoutCard();
    else
        showLoginCard();
}

function onGetMemberInfoSuccess(response, config)
{
    var json = jsonDecode(response.responseText);
    Data.memberId = json.memberId;
    initLoginPanel();
}

function onGetMemberInfoFailure(response, config)
{
    stdErrorHandler.apply(this, arguments);
    initLoginPanel();
}

function onLoad()
{
    applyHTMLLocale();
    
    Ajax.request({
        url     : Api.getMemberInfo,
        method  : "GET",
        success : onGetMemberInfoSuccess,
        failure : onGetMemberInfoFailure
    });
    
    $("loginLoginField").focus();
}
