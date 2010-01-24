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

function onLoginUseCookieChange()
{
    updateLoginCheckboxes();
}

function updateRegistrationCheckboxes()
{
    var startCheckbox       = document.getElementById("registrationStartCheckbox");
    var useCookieCheckbox   = document.getElementById("registrationUseCookieCheckbox");
    var rememberCheckbox    = document.getElementById("registrationRememberCheckbox");
    
    useCookieCheckbox   .disabled = !startCheckbox.checked;
    rememberCheckbox    .disabled = !startCheckbox.checked || !useCookieCheckbox.checked;
}

function onRegistrationStartChange()
{
    updateRegistrationCheckboxes();
}

function onRegistrationUseCookieChange()
{
    updateRegistrationCheckboxes();
}

function applyLoginPanelLocale()
{
    document.getElementById("loginFormTitle").innerHTML = locale.authorization;
    document.getElementById("loginLoginLabel").innerHTML = locale.login + ":&nbsp;";
    document.getElementById("loginPasswordLabel").innerHTML = locale.password + ":&nbsp;";
    document.getElementById("loginUseCookieTR").title = locale.useCookieTip;
    document.getElementById("loginUseCookieLabel").innerHTML = locale.useCookie + ":&nbsp;";
    document.getElementById("loginRememberTR").title = locale.rememberTip;
    document.getElementById("loginRememberLabel").innerHTML = locale.remember + ":&nbsp;";
    document.getElementById("loginSubmit").value = locale.login;
    document.getElementById("loginRegisterLink").innerHTML = locale.register;
    document.getElementById("registrationFormTitle").innerHTML = locale.registration;
    document.getElementById("registrationLoginLabel").innerHTML = locale.login + ":&nbsp;";
    document.getElementById("registrationPasswordLabel").innerHTML = locale.password + ":&nbsp;";
    document.getElementById("registrationConfirmLabel").innerHTML = locale.confirm + ":&nbsp;";
    document.getElementById("registrationStartTR").title = locale.startTip;
    document.getElementById("registrationStartLabel").innerHTML = locale.start + ":&nbsp;";
    document.getElementById("registrationUseCookieTR").title = locale.useCookieTip;
    document.getElementById("registrationUseCookieLabel").innerHTML = locale.useCookie + ":&nbsp;";
    document.getElementById("registrationRememberTR").title = locale.rememberTip;
    document.getElementById("registrationRememberLabel").innerHTML = locale.remember + ":&nbsp;";
    document.getElementById("registrationSubmit").value = locale.register;
    document.getElementById("registrationBackLink").innerHTML = "<< " + locale.back;
}
