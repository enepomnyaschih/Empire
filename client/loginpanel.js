function showLoginCard()
{
    showCard($("loginCard"));
    $("loginLoginField").focus();
}

function showLogoutCard()
{
    $("logoutMemberIdField").innerHTML = Data.memberId;
    showCard($("logoutCard"));
}

function showRegistrationCard()
{
    showCard($("registrationCard"));
    $("registrationLoginField").focus();
}

function hideLoginCard()
{
    hideCard($("loginCard"));
}

function hideLogoutCard()
{
    hideCard($("logoutCard"));
}

function hideRegistrationCard()
{
    hideCard($("registrationCard"));
}

function onRegisterClick()
{
    hideLoginCard();
    showRegistrationCard();
}

function onRegisterBackClick()
{
    hideRegistrationCard();
    showLoginCard();
}

function updateLoginCheckboxes()
{
    var useCookieCheckbox   = $("loginUseCookieCheckbox");
    var rememberCheckbox    = $("loginRememberCheckbox");
    
    rememberCheckbox.disabled = !useCookieCheckbox.checked;
}

function updateRegistrationCheckboxes()
{
    var startCheckbox       = $("registrationStartCheckbox");
    var useCookieCheckbox   = $("registrationUseCookieCheckbox");
    var rememberCheckbox    = $("registrationRememberCheckbox");
    
    useCookieCheckbox   .disabled = !startCheckbox.checked;
    rememberCheckbox    .disabled = !startCheckbox.checked || !useCookieCheckbox.checked;
}

function onLoginUseCookieChange()
{
    updateLoginCheckboxes();
}

function onRegistrationStartChange()
{
    updateRegistrationCheckboxes();
}

function onRegistrationUseCookieChange()
{
    updateRegistrationCheckboxes();
}

function validateLogin(login)
{
    if (login.length < Const.minLoginLength)
        throw new Error("ERROR_MEMBER_ID_TOO_SHORT");
    
    if (login.length > Const.maxLoginLength)
        throw new Error("ERROR_MEMBER_ID_TOO_LONG");
}

function validatePassword(password)
{
    if (password.length < Const.minPasswordLength)
        throw new Error("ERROR_PASSWORD_TOO_SHORT");
    
    if (password.length > Const.maxPasswordLength)
        throw new Error("ERROR_PASSWORD_TOO_LONG");
}

function onLoginSubmit()
{
    try
    {
        validateLogin($("loginLoginField").value);
    }
    catch(e)
    {
        alert(getErrorText(e.message));
        $("loginLoginField").focus();
        return;
    }
    
    Ajax.request({
        url     : Api.login,
        params  : {
            memberId    : $("loginLoginField").value,
            password    : $("loginPasswordField").value,
            remember    : $("loginRememberCheckbox").checked
        },
        method  : "POST",
        success : function() { alert("success!"); },
        failure : stdErrorHandler
    });
    
    return false;
}

function onLogoutSuccess()
{
    deleteCookie("ticket");
    Data.ticket = null;
    
    hideLogoutCard();
    showLoginCard();
}

function onLogoutClick()
{
    showMask();
    
    Ajax.request({
        url     : Api.logout,
        params  : {
            ticket  : Data.ticket
        },
        method  : "POST",
        success : onLogoutSuccess,
        failure : stdErrorHandlerHideMask
    });
}

function loginAfterRegistration()
{
}

function onRegistrationSubmit()
{
    try
    {
        validateLogin($("registrationLoginField").value);
    }
    catch(e)
    {
        alert(getErrorText(e.message));
        $("registrationLoginField").focus();
        return;
    }
    
    if ($("registrationPasswordField").value != $("registrationConfirmField").value)
    {
        alert(getErrorText("ERROR_PASSWORDS_DIFFERENT"));
        $("registrationPasswordField").value = "";
        $("registrationConfirmField").value = "";
        $("registrationPasswordField").focus();
        return;
    }
    
    try
    {
        validatePassword($("registrationPasswordField").value);
    }
    catch(e)
    {
        alert(getErrorText(e.message));
        $("registrationPasswordField").value = "";
        $("registrationConfirmField").value = "";
        $("registrationPasswordField").focus();
        return;
    }
    
    Ajax.request({
        url     : Api.register,
        params  : {
            memberId    : $("registrationLoginField").value,
            password    : $("registrationPasswordField").value
        },
        method  : "POST",
        success : loginAfterRegistration,
        failure : stdErrorHandler
    });
}

function applyLoginPanelLocale()
{
    $("loginFormTitle"              ).innerHTML = Locale.authorization;
    $("loginLoginLabel"             ).innerHTML = Locale.login + ":&nbsp;";
    $("loginPasswordLabel"          ).innerHTML = Locale.password + ":&nbsp;";
    $("loginUseCookieTR"            ).title     = Locale.useCookieTip;
    $("loginUseCookieLabel"         ).innerHTML = Locale.useCookie + ":&nbsp;";
    $("loginRememberTR"             ).title     = Locale.rememberTip;
    $("loginRememberLabel"          ).innerHTML = Locale.remember + ":&nbsp;";
    $("loginSubmit"                 ).value     = Locale.login;
    $("loginRegisterLink"           ).innerHTML = Locale.register;
    $("logoutLink"                  ).innerHTML = Locale.logout;
    $("registrationFormTitle"       ).innerHTML = Locale.registration;
    $("registrationLoginLabel"      ).innerHTML = Locale.login + ":&nbsp;";
    $("registrationPasswordLabel"   ).innerHTML = Locale.password + ":&nbsp;";
    $("registrationConfirmLabel"    ).innerHTML = Locale.confirm + ":&nbsp;";
    $("registrationStartTR"         ).title     = Locale.startTip;
    $("registrationStartLabel"      ).innerHTML = Locale.start + ":&nbsp;";
    $("registrationUseCookieTR"     ).title     = Locale.useCookieTip;
    $("registrationUseCookieLabel"  ).innerHTML = Locale.useCookie + ":&nbsp;";
    $("registrationRememberTR"      ).title     = Locale.rememberTip;
    $("registrationRememberLabel"   ).innerHTML = Locale.remember + ":&nbsp;";
    $("registrationSubmit"          ).value     = Locale.register;
    $("registrationBackLink"        ).innerHTML = "<< " + Locale.back;
}
