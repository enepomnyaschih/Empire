function showLoginCard()
{
    showCard($("loginCard"));
    $("loginLoginField").focus();
}

function showLogoffCard()
{
    showCard($("logoffCard"));
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

function hideLogoffCard()
{
    hideCard($("logoffCard"));
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
    if (login.length < 2)
        throw new Error("ERROR_MEMBER_ID_TOO_SHORT");
}

function validatePassword(password)
{
    if (password.length < 6)
        throw new Error("ERROR_PASSWORD_TOO_SHORT");
}

function onLoginSubmit()
{
    try
    {
        validateLogin($("loginLoginField").value);
    }
    catch(e)
    {
        alert(Locale.errors[e.message]);
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
        alert(Locale.errors[e.message]);
        $("registrationLoginField").focus();
        return;
    }
    
    if ($("registrationPasswordField").value != $("registrationConfirmField").value)
    {
        alert(Locale.errors["ERROR_PASSWORDS_DIFFERENT"]);
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
        alert(Locale.errors[e.message]);
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
