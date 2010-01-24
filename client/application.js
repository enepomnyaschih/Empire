function applyHTMLLocale()
{
    applyLoginPanelLocale();
}

function onLoad()
{
    applyHTMLLocale();
    
    $("loginLoginField").focus();
}
