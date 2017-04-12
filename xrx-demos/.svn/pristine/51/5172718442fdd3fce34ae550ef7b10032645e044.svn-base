xquery version "1.0";
declare namespace svg="http://www.w3.org/2000/svg";
declare namespace xlink="http://www.w3.org/1999/xlink";

import module namespace draw-chart = 'http://danmccreary.com/draw-chart' at 'draw-chart-module.xqm';
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=yes indent=yes";

let $config :=
<config>
   <chart-height>300</chart-height>
   <chart-width>400</chart-width>
   <bar-width>30</bar-width>
   <bar-spacing>3</bar-spacing>
   <bar-count>24</bar-count>
   <margin-left>20</margin-left>
</config>

let $chart-height := $config/chart-height/text()
let $chart-width := $config/chart-width/text()
let $bar-width := $config/bar-width/text()
let $bar-spacing := $config/bar-spacing/text()
let $bar-count := $config/bar-count/text()
let $margin-left := $config/margin-left/text()

return
<svg xmlns="http://www.w3.org/2000/svg" height="{$chart-height + 20}" width="{$chart-width}" style="border: solid blue 1px;">
   {for $bar in (1 to $bar-count)
      let $x := ($bar -1) * ($bar-width + $bar-spacing) + $margin-left
      return
         draw-chart:draw-bar($config, util:random($chart-height), $x, 'view-details.xq?id={$bar}')
   }
</svg>