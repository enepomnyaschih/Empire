function getErrorText(errorId)
{
    return applyTemplate(Locale.errors[errorId]);
}

function stdErrorHandler(response, config)
{
    function excludeText()
    {
        var text = response.responseText;
        
        try
        {
            var json = jsonDecode(text);
            if (!json || !json.errorId || !(typeof json.errorId == "string") || !Locale.errors[json.errorId])
                return text;
            
            return getErrorText(json.errorId);
        }
        catch(e)
        {
            return text;
        }
    }
    
    alert(excludeText());
}

function stdErrorHandlerHideMask()
{
    stdErrorHandler.apply(this, arguments);
    hideMask();
}
