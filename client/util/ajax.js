if (window.XMLHttpRequest === undefined)
{
    window.XMLHttpRequest = function()
    {
        try { return new ActiveXObject("Msxml2.XMLHTTP.6.0"); }
        catch(e) {}
        try { return new ActiveXObject("Msxml2.XMLHTTP.3.0"); }
        catch(e) {}
        try { return new ActiveXObject("Msxml2.XMLHTTP"); }
        catch(e) {}
        try { return new ActiveXObject("Microsoft.XMLHTTP"); }
        catch(e) {}
        throw new Error("This browser does not support XMLHttpRequest.");
    }
}

window.Ajax = {
    /**
     *  config:
     *  {
     *      url     : String,
     *      params  : Object,
     *      method  : String,
     *      success : Function,
     *      failure : Function,
     *      scope   : Object
     *  }
     */
    request: function(config) {
        // prepare params
        var params = config.params || {};
        var paramsList = [];
        
        for (var key in params)
        {
            var value = params[key];
            
            if (value === null)
                continue;
            
            if (isArray(value))
            {
                for (var i = 0; i < value.length; ++i)
                {
                    paramsList.push(encodeURIComponent(key) + "=" + encodeURIComponent(value[i]));
                }
            }
            else
            {
                paramsList.push(encodeURIComponent(key) + "=" + encodeURIComponent(value));
            }
        }
        
        var paramsString = paramsList.length ? paramsList.join("&") : null;
        
        // prepare and send request
        var req = new XMLHttpRequest();
        
        function handleResponse()
        {
            if (req.readyState != 4)
                return;
            
            var callback = (req.status == 200) ? config.success : config.failure;
            if (callback)
                callback.call(config.scope || req, req, config);
        }
        
        var method = config.method || "POST";
        var url;
        var content;
        
        if (config.method == "POST")
        {
            url = config.url;
            content = paramsString;
        }
        else
        {
            url = config.url + (paramsString ? ("?" + paramsString) : "");
            content = null;
        }
        
        req.open(method, url, true);
        req.onreadystatechange = handleResponse;
        req.send(content);
        
        return req;
    }
};
