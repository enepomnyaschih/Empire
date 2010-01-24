function getValue(path, root)
{
    root = root || window;
    
    var nodes = path.split(".");
    for (var i = 0; i < nodes.length; ++i)
        root = root[nodes[i]];
    
    return root;
}

function applyTemplate(tpl, values)
{
    var result = [];
    
    var curIndex = 0;
    while (true)
    {
        var aIndex = tpl.indexOf("{", curIndex);
        if (aIndex == -1)
            break;
        
        var bIndex = tpl.indexOf("}", aIndex);
        if (bIndex == -1)
            break;
        
        result.push(tpl.substr(curIndex, aIndex - curIndex));
        result.push(getValue(tpl.substr(aIndex + 1, bIndex - aIndex - 1), values));
        
        curIndex = bIndex + 1;
    }
    
    result.push(tpl.substr(curIndex));
    
    return result.join("");
}
