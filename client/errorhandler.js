function stdErrorHandler(response, config)
{
    function excludeText()
    {
        var text = response.responseText;
        
        try
        {
            var json = jsonDecode(text);
            if (!json || !json.errorId || !(typeof json.errorId == "string"))
                return text;
            
            return applyTemplate(Locale.errors[json.errorId] || json.errorId);
        }
        catch(e)
        {
            return text;
        }
    }
    
    alert(excludeText());
}
