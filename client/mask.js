var maskDepth = 0;

function showMask()
{
    ++maskDepth;
    $("mask").style.visibility = "visible";
}

function hideMask()
{
    if (--maskDepth == 0)
        $("mask").style.visibility = "hidden";
}
