function hideCard(el)
{
    el.style.visibility = "hidden";
    el.style.position = "absolute";
}

function showCard(el)
{
    el.style.visibility = "visible";
    el.style.position = "relative";
}

function apply(host, server)
{
    for (var key in server)
        host[key] = server[key];
}

function isArray(o)
{
    return (typeof o == "object") && (o.length !== undefined);
}

function $(id)
{
    return document.getElementById(id);
}
