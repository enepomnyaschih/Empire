function applyHTMLLocale()
{
    applyLoginPanelLocale();
}

function onLoad()
{
    applyHTMLLocale();
    
    document.getElementById("loginLoginField").focus();
}
