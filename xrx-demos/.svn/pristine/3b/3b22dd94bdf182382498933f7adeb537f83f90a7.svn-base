xquery version "1.0";
module namespace draw-chart = 'http://danmccreary.com/draw-chart';

declare namespace svg="http://www.w3.org/2000/svg";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare variable $draw-chart:app-db-path := '/db/chase/apps/charts';

(: draw a standard width bar for a bar chart :)
declare function draw-chart:draw-bar($config as node(), $height as xs:integer, $x as xs:integer, $top-text as xs:string, $href as xs:string) as node() {
    let $chart-height := $config//chart-height/text()
    (: the bar width is always recalculated based on the values in the configuration node :)
    let $chart-width := $config//chart-width/text()
    let $bar-count := $config//bar-count/text()
    let $bar-width := $config//bar-width/text()
    let $bar-color := $config//bar-color/text()
    let $half-bar-width := round($bar-width div 2)
    let $y := $chart-height - $height
    return
    <g transform="translate({$x} 10)" >
        <a xlink:href="{$href}">
            <rect width="{$bar-width}" height="{$height}" x="0" y="{$y}" class="svg_nav" fill="{$bar-color}"/>
            <text x="-3" y="{$y - 2}">{$top-text}</text>
        </a>
    </g>
 };

(: draw a standard width 100 point bullet bar  :)
declare function draw-chart:draw-bullet($config as node(), $margin-label as xs:string, $y as xs:integer, $value as xs:integer, $href as xs:string) as node() {

let $chart-width := $config//chart-width/text()
let $chart-width := $config//chart-width/text()
let $bar-height := $config//bar-height/text()
let $margin-left := $config/margin-left/text()

return
<g class="bullet-bar" transform="translate(0 {$y})">
    <a xlink:href="{$href}">
        
        <image x="{$margin-left}" y="0" width="{$chart-width - $margin-left}" height="{$bar-height}" xlink:href="../images/color-band-green-to-red.png" />
        <text x="0" y="10">{$margin-label}</text>
        <g transform="translate({$margin-left + $value} 15)">
           <polygon points="-5,0 0,10 5,0" fill="black"/>
           <text x="5" y="10">{$value}</text>
        </g>
        {draw-chart:axis('default')}
    </a>
</g>
};

declare function draw-chart:axis($type as xs:string) {
   <g id="horizontal-axis"  transform="translate(20 25)" stroke="black" stroke-width="1">
    <line x1="0" x2="0" y1="0" y2="10"/>
    <line x1="50" x2="50" y1="0" y2="10"/>
    <line x1="100" x2="100" y1="0" y2="10"/>
    <line x1="150" x2="150" y1="0" y2="10"/>
    <line x1="200" x2="200" y1="0" y2="10"/>
    <line x1="250" x2="250" y1="0" y2="10"/>
    <line x1="300" x2="300" y1="0" y2="10"/>
    <line x1="350" x2="350" y1="0" y2="10"/>
</g>

};