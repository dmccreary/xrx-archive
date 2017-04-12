xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $page :=
<html>
    <head>
        <style><![CDATA[
            div { position: absolute; width: 60px; height: 60px; float: left; }
            .first { background-color: green; left: 0;}
            .second { background-color: blue; left: 80px;}
        ]]></style>
      <script src="http://code.jquery.com/jquery-latest.js"></script>
    </head>
    <body>
      
        <p><button>Run</button></p>
        
        <div class="second"></div>
        <div class="first"></div>
        
        <script><![CDATA[
            $("button").click(function() {
               $("div.first").slideUp(300).delay(1200).fadeIn(2000);
               $("div.second").slideUp(300).fadeIn(400);
            });
        ]]></script>
    
    </body>
</html>

return $page