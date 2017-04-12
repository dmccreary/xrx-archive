xquery version "1.0";
module namespace gc = 'http://www.danmccreary.com/google-charts';

declare function gc:bullet-bar(
    $height as xs:decimal,
    $width as xs:decimal,
    $danger as xs:decimal,
    $warn as xs:decimal,
    $ok as xs:decimal,
    $target as xs:decimal,
    $actual as xs:decimal
) as xs:string {
let $danger-width-percent := $danger div 100
let $warn-width-percent := $warn div 100
let $ok-width-percent := $ok div 100
let $target-width-percent := $target div 100
let $target-plus-one := $target-width-percent + 0.01
 return concat(
   'http://chart.apis.google.com/chart?cht=bhs&amp;chs=',
    $width,
    'x',
    $height,
    '&amp;chd=t:', $actual, 
    '&amp;chm=r,ff0000,0,0.0,', $danger-width-percent,
    '|r,ffff00,0,', $danger-width-percent, ',', $warn-width-percent,
    '|r,00A000,0,', $warn-width-percent, ',', $ok-width-percent,
    '|r,000000,0,', $target-width-percent, ',', $target-plus-one, 
    '&amp;chco=000000&amp;chbh=',
    round($height * 0.6)
  )
};

declare function gc:simple-line-chart-demo() as node() {
<img src = 
"http://chart.apis.google.com/chart?
chs=250x100
&amp;chd=t:60,40,60,30,30,70|50,30,27,85,60,40
&amp;cht=lc
&amp;chco=FF0000,0000FF
&amp;chdl=2009|2010" 
alt = "Sample Line Chart"/>
};

declare function gc:demo-vertical-bar-chart() as node() {
<img src = 
"http://chart.apis.google.com/chart?chs=250x100&amp;chxt=y&amp;chbh=a&amp;cht=bvg&amp;chco=A2C180,3D7930&amp;chd=t:10,50,60,80,40,60,30|50,60,100,40,20,40,30&amp;chtt=Vertical+bar+chart"/>
};