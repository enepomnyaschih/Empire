function stdErrorHandler(response, config)
{
    function excludeText()
    {
        var text = response.responseText;
        
        try
        {
            var json = jsonDecode(text);
            if (!json || !json.errorId || !(typeof json == "string"))
                return text;
            
            return Locale.errors[json.errorId] || json.errorId;
        }
        catch(e)
        {
            return text;
        }
    }
    
    alert(excludeText());
}
