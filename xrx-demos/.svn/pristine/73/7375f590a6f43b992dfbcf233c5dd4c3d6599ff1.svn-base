xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $initial-value := xs:integer(request:get-parameter('initial-value', 50))

let $title := "Select Series With Range Control"

let $years1 := ('2009', '2010')
let $years := ('10')
let $months1 := ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
let $months := ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
let $dates :=
   for $year in $years
      for $month in $months
      return
        concat($month, '-', $year)
        
let $my-array :=
   concat("['", string-join($dates, "','"), "']")

return
<html>
    <head>
        
        <title>Select Series With Range Control</title>
        
        <link rel="stylesheet" href="/rest/db/dma/resources/css/blueprint/screen.css" type="text/css" media="screen, projection" />
        <link rel="stylesheet" href="/rest/db/dma/resources/css/blueprint/print.css" type="text/css" media="print" /><!--[if IE ]><link rel="stylesheet" href="/rest/db/dma/resources/css/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->
        <link rel="stylesheet" href="/rest/db/dma/resources/css/style.css" type="text/css" media="screen, projection" />
    </head>
    <body onLoad="delayedHide()">
       <div class="container">
<div class="content">
    <link type="text/css" href="{$style:jquery}/css/custom-theme/jquery-ui-1.8.9.custom.css" rel="stylesheet" />	
	<style type="text/css"><![CDATA[

   .gradient-slider {
		float: left;
		clear: left;
		width: 300px;
		margin: 10px;
		background-image: url(/rest/db/dma/resources/images/slider-background-gradient.png)
	}
]]></style>
    
    
    <script type="text/javascript">
      myArray = {$my-array};
    </script>

   
    <div id="my-chart"/>
    
    <span id="slider1" class="gradient-slider"></span>
    <select name="date-select" id="date-select">
        {for $date in $dates
            return
              <option>{$date}</option>
         }
    </select>
    
    <input type="button" onclick="hideAll()" value="Hide All"/>
    <input type="button" onclick="showAll()" value="Show All"/>
    <input type="button" onclick="hideAllInit()" value="Hide Dates"/>
    <br/>
    <label for="slider-text">Slider Value (Array Index): </label>
    <input id="slider-text" size="1"/>
    
    <script type="text/javascript" src="{$style:jquery}/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="{$style:jquery}/js/jquery-ui-1.8.9.custom.min.js"></script>
    <script type="text/javascript" src="/rest/db/dma/resources/js/anychart/js/AnyChart.js"></script>
    <script type="text/javascript" src="range-series-select.js"></script>

</div>
      </div>
    </body>
</html>