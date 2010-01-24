function onRegisterClick()
{
    hideCard(document.getElementById("loginCard"));
    showCard(document.getElementById("registrationCard"));
    
    document.getElementById("registrationLoginField").focus();
}

function onRegisterBackClick()
{
    hideCard(document.getElementById("registrationCard"));
    showCard(document.getElementById("loginCard"));
    
    document.getElementById("loginLoginField").focus();
}

function updateLoginCheckboxes()
{
    var useCookieCheckbox   = document.getElementById("loginUseCookieCheckbox");
    var rememberCheckbox    = document.getElementById("loginRememberCheckbox");
    
    rememberCheckbox.disabled = !useCookieCheckbox.checked;
}

function updateRegistrationCheckboxes()
{
    var startCheckbox       = document.getElementById("registrationStartCheckbox");
    var useCookieCheckbox   = document.getElementById("registrationUseCookieCheckbox");
    var rememberCheckbox    = document.getElementById("registrationRememberCheckbox");
    
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

function onLoginSubmit()
{
    Ajax.request({
        url     : Api.login,
        params  : {
            memberId    : $("loginLoginField").value,
            password    : $("loginPasswordField").value,
            remember    : $("loginRememberCheckbox").checked
        },
        method  : "GET",
        success : function() { alert("success!"); },
        failure : function() { alert("failure!"); }
    });
    
    return false;
}

function applyLoginPanelLocale()
{
    document.getElementById("loginFormTitle").innerHTML = Locale.authorization;
    document.getElementById("loginLoginLabel").innerHTML = Locale.login + ":&nbsp;";
    document.getElementById("loginPasswordLabel").innerHTML = Locale.password + ":&nbsp;";
    document.getElementById("loginUseCookieTR").title = Locale.useCookieTip;
    document.getElementById("loginUseCookieLabel").innerHTML = Locale.useCookie + ":&nbsp;";
    document.getElementById("loginRememberTR").title = Locale.rememberTip;
    document.getElementById("loginRememberLabel").innerHTML = Locale.remember + ":&nbsp;";
    document.getElementById("loginSubmit").value = Locale.login;
    document.getElementById("loginRegisterLink").innerHTML = Locale.register;
    document.getElementById("registrationFormTitle").innerHTML = Locale.registration;
    document.getElementById("registrationLoginLabel").innerHTML = Locale.login + ":&nbsp;";
    document.getElementById("registrationPasswordLabel").innerHTML = Locale.password + ":&nbsp;";
    document.getElementById("registrationConfirmLabel").innerHTML = Locale.confirm + ":&nbsp;";
    document.getElementById("registrationStartTR").title = Locale.startTip;
    document.getElementById("registrationStartLabel").innerHTML = Locale.start + ":&nbsp;";
    document.getElementById("registrationUseCookieTR").title = Locale.useCookieTip;
    document.getElementById("registrationUseCookieLabel").innerHTML = Locale.useCookie + ":&nbsp;";
    document.getElementById("registrationRememberTR").title = Locale.rememberTip;
    document.getElementById("registrationRememberLabel").innerHTML = Locale.remember + ":&nbsp;";
    document.getElementById("registrationSubmit").value = Locale.register;
    document.getElementById("registrationBackLink").innerHTML = "<< " + Locale.back;
}
