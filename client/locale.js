function getLanguage()
{
    return navigator.language;
}

function loadLocale(lang)
{
    var head = document.getElementsByTagName("head")[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = "locale/locale-" + lang + ".js";
    head.appendChild(script);
}

loadLocale("en-US");
loadLocale(getLanguage());
