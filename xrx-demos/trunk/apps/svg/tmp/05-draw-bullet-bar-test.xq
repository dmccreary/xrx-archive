xquery version "1.0";
declare namespace svg="http://www.w3.org/2000/svg";
declare namespace xlink="http://www.w3.org/1999/xlink";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace draw-chart = 'http://danmccreary.com/draw-chart' at '../modules/draw-chart-module.xqm';

let $title := 'Draw Bullet Test'

let $config :=
<config>
   <chart-height>300</chart-height>
   <chart-width>400</chart-width>
   <bar-height>40</bar-height>
   <margin-left>20</margin-left>
</config>

let $chart-height := $config/chart-height/text()
let $chart-width := $config/chart-width/text()
let $value := 100



let $content :=
<svg xmlns="http://www.w3.org/2000/svg" height="{$chart-height + 20}" width="{$chart-width}" style="border: solid blue 1px;">
   <text x="4" y="10">Draw Bullet Bar With Green to Red Image Background</text>
   {draw-chart:draw-bullet($config, 'KS', 20, 50, 'view-details.xq?id=1')}
   
   {draw-chart:draw-bullet($config, 'ROC', 60, 100, 'view-details.xq?id=1')}
   
   {draw-chart:draw-bullet($config, '% of Bads in Bottom Decile', 100, 200, 'view-details.xq?id=1')}
   
   {draw-chart:draw-bullet($config, 'PDO', 140, 50, 'view-details.xq?id=1')}
</svg>

return style:assemble-chart($title, $content)