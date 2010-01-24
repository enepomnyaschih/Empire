function $(id)
{
    return document.getElementById(id);
}

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

// Standard item comparison function.
function compare(a, b)
{
    if (a > b) return 1;
    if (a < b) return -1;
    return 0;
}
