xquery version "1.0";

module namespace style-svg = "http://danmccreary.com/style-svg";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
(:
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
:)

declare namespace svg   = "http://www.w3.org/2000/svg";
declare namespace h = "http://www.w3.org/1999/xhtml";
declare namespace xlink = "http://www.w3.org/1999/xlink";

declare variable $style-svg:data-collection := '/db/dma/apps/icon-builder/data';

declare variable $style-svg:border-fill-color := 'silver';
declare variable $style-svg:border-stroke-color := 'black';
declare variable $style-svg:border-stroke-width := '1px';
declare variable $style-svg:default-css := 'dma.css';

declare function style-svg:add-css-link($in as node()) as node() {
<svg:svg>
    {for $att in $in/@*
      return
        attribute {name($att)} {$att}
    }
    <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" href="../css/{$style-svg:default-css}"/>
    {style-svg:border()}
    {for $sub-element in $in/node()
     return util:deep-copy($sub-element)
    }
</svg:svg>
};

declare function style-svg:css-link() as node() {
<link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" href="../css/{$style-svg:default-css}"/>
};

(: wrap the icon in a 100x100 icon background :)
declare function style-svg:icon-wrap($in as node()) as node() {
let $height := xs:decimal(substring-before($in/@height/string(), 'px'))
let $vertical-translate := (round(100 - $height) div 2) + 15
return
<svg:svg width="100px" height="100px" 
    viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve">
        {style-svg:drop-shadow()}
        {style-svg:gradient-fill()}
        {style-svg:border()}
        <svg:g fill="url(#upper-left-light-source)" transform="scale(.77, .77) translate(15,{$vertical-translate})" style="filter:url(#dropshadow)">
            {for $sub-element in $in/node()
               return util:deep-copy($sub-element)
            }
        </svg:g>

</svg:svg>
};

(: wrap the icon in a 100x100 icon background :)
declare function style-svg:mini-icon-wrap($in as node()) as node() {
let $height := xs:decimal(substring-before($in/@height/string(), 'px'))
let $vertical-translate := (round(100 - $height) div 2) + 15
return
<svg:svg width="16px" height="16px" 
    viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
        {style-svg:drop-shadow()}
        {style-svg:gradient-fill()}
        {style-svg:rounded-border(16, 16, 2, $style-svg:border-fill-color, $style-svg:border-stroke-color, '.25')}
        <svg:g fill="url(#upper-left-light-source)" transform="scale(.1, .1) translate(15,{$vertical-translate})" style="filter:url(#dropshadow)">
            {for $sub-element in $in/node()
               return util:deep-copy($sub-element)
            }
        </svg:g>
</svg:svg>
};

(: wrap the icon using the size parameter :)
declare function style-svg:icon-wrap($in as node(), $size as xs:integer) as node() {
let $height := xs:decimal(substring-before($in/@height/string(), 'px'))
let $vertical-translate := (round(100 - $height) div 2) + 15
let $horizontal-translate := $size div 40 + 15
let $scale := $size div 130
return
<svg:svg width="{$size}px" height="{$size}px" 
    viewBox="0 0 {$size} {$size}" enable-background="new 0 0 {$size} {$size}" xml:space="preserve">
        {style-svg:drop-shadow()}
        {style-svg:gradient-fill()}
        {style-svg:rounded-border($size, $size, 2, $style-svg:border-fill-color, $style-svg:border-stroke-color, '.25')}
        <svg:g fill="url(#upper-left-light-source)" transform="scale({$scale}, {$scale}) translate({$horizontal-translate}, {$vertical-translate})" style="filter:url(#dropshadow)">
            {for $sub-element in $in/node()
               return util:deep-copy($sub-element)
            }
        </svg:g>
</svg:svg>
};

(: wrap the icon in a 100x100 icon background :)
declare function style-svg:icon-group($in as node(), $x as xs:integer, $y as xs:integer) as node() {
let $height := xs:decimal(substring-before($in/@height/string(), 'px'))
let $vertical-translate := (round(100 - $height) div 2) + 15
return
<svg:g transform="translate({$x}, {$y})">
    {style-svg:border()}
    <svg:g fill="url(#upper-left-light-source)" transform="scale(.77, .77) translate(15,{$vertical-translate})" style="filter:url(#dropshadow)">
        {for $sub-element in $in/node()
           return util:deep-copy($sub-element)
        }
    </svg:g>
</svg:g>
};

(: height, width, roundness, fill-color, edge, color, border-width :)
declare function style-svg:border() {
  style-svg:rounded-border(100, 100, 10, 'silver', 'gray', '1px')
};

(:
fill - fill color of the interior of the square
stroke-witdth - width the outline border in px as a string
stroke - color of the outline border
:)
declare function style-svg:rounded-border(
   $height as xs:integer, $width as xs:integer, $corner as xs:integer, 
   $fill as xs:string, $stroke as xs:string, $stroke-width as xs:string) as element(g) {
let $border := round($height div 20)
let $border-height := $height - $border*2
let $border-width := $width - $border*2
return
<svg:g class="border">
   <svg:rect x="{$border}" y="{$border}" rx="{$corner}" height="{$border-height}" width="{$border-width}"  fill="{$fill}" stroke="{$stroke}" stroke-width="{$stroke-width}"/>
</svg:g>
};

(: the default with reasonable values 
   first is the spread of the shadow and the second is the offset going down to the right:)
declare function style-svg:drop-shadow() as element(filter) {
   style-svg:drop-shadow('3', '5')
};

declare function style-svg:drop-shadow($stdDeviation as xs:string, $offsetblur as xs:string) as element(filter) {
<svg:filter id="dropshadow">
    <svg:feGaussianBlur in="SourceAlpha" stdDeviation="{$stdDeviation}"/> <!-- stdDeviation is how much to blur -->
    <svg:feOffset dx="{$offsetblur}" dy="{$offsetblur}" result="offsetblur"/> <!-- how much to offset -->
    <svg:feMerge> 
        <svg:feMergeNode/> <!-- this contains the offset blurred image -->
        <svg:feMergeNode in="SourceGraphic"/> <!-- this contains the element that the filter is applied to -->
    </svg:feMerge>
</svg:filter>
};

(: use all the defaults
   start at white and end with blue in going at a 45 degree angle from the upper left :)
declare function style-svg:gradient-fill() as node() {
style-svg:gradient-fill('white', 'blue', 45)
};

(: use parameters to change :)
declare function style-svg:gradient-fill($start-color as xs:string, $end-color as xs:string, $angle as xs:integer) as node() {
<svg:linearGradient xmlns="http://www.w3.org/2000/svg" id="upper-left-light-source" gradientTransform="rotate({$angle} .5 .5)">
  <svg:stop offset="0" stop-color="{$start-color}"/>
  <svg:stop offset="1" stop-color="{$end-color}"/>
</svg:linearGradient>
};

declare function style-svg:svg-file($id) as node() {
let $file-path := concat($style-svg:data-collection, '/', $id, '.svg')
return doc($file-path)/svg:svg
};

(: not sure what mime-type to use.  svg+xhtml seems to make the most sense but does
not seem to work :)
declare function style-svg:assemble-page($title as xs:string*, $content as node()+) as node() {
    (
    util:declare-option('exist:serialize', 'method=xml media-type=application/xhtml+xml indent=yes')
    ,
    <h:html xmlns:h="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">
        <h:head>
            <h:title>{ $title }</h:title>
            {style-svg:css('xhtml')}
        </h:head>
        <h:body>
            <h:div class="container">
                {style-svg:header()} 
                {style-svg:breadcrumbs()}
                <h:div class="inner">
                   <h:h2>{$title}</h:h2>
                   { $content }
                </h:div>
                {style-svg:footer()}
            </h:div>
        </h:body>
     </h:html>
     )
};

declare function style-svg:css($page-type as xs:string) 
as node()+ {
    if ($page-type eq 'xhtml') then 
        (
       
        <h:link rel="stylesheet" href="{$style:site-css}/blueprint/screen.css" type="text/css" media="screen, projection" />,
        <h:link rel="stylesheet" href="{$style:site-css}/blueprint/print.css" type="text/css" media="print" />,<!--[if IE ]><link rel="stylesheet" href="{$style:site-css}/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->,
        <h:link rel="stylesheet" href="{$style:site-css}/style.css" type="text/css" media="screen, projection" />

    )
    else if ($page-type eq 'xforms') then 
        <h:link rel="stylesheet" href="{$style:site-css}/xforms.css.xq" type="text/css" />
    else ()
};

declare function style-svg:header()  as node()*  {
<h:div id="header">
   <h:div id="banner">
      <h:span id="logo">
        <h:a href="{$style:rest-path-to-site}/index.xq"><img src="{$style:site-images}/dma-logo.png" alt="danmccreary" width="58" height="58"/>
        </h:a>
      </h:span>   
      
      <h:span id="banner-header-text">Dan McCreary &amp; Associates</h:span>
      
      <h:div id="banner-search">
         <h:form method="GET" action="{$style:rest-path-to-site}/apps/search/search.xq">
                    <h:strong>Search:</h:strong>
                    <h:input name="q" type="text"/>
                    <h:input type="submit" value="Search"/>        
         </h:form>
      </h:div>
      
      <h:div id="banner-login">
         <h:a href="/admin/admin/admin.xql">login</h:a>{' '} user: {' '} {xmldb:get-current-user()}
      </h:div>
   </h:div>
   <h:div class="banner-seperator-bar"/>
</h:div>   
};

declare function style-svg:footer()  as node()*  {
<h:div id="footer">
   <h:div class="banner-seperator-bar"/>
   <h:div id="footer-text">Copyright 2009 Dan McCreary and Associates. All rights reserved.
      <h:a href="{$style:feedback-form-path}">Feedback</h:a>
   </h:div>
</h:div>
};

declare function style-svg:breadcrumbs() as node() {
<h:div class="breadcrumbs">
  <h:a href="{$style:rest-path-to-site}/index.xq">Home</h:a>
  
  &gt; <h:a href="{$style:rest-path-to-site}/apps/index.xq">Apps</h:a>
  
  {if (style:web-depth-in-site() > 2) then
  (' &gt; ',
  <h:a href="{$style:rest-path-to-site}/apps/{style:app-id()}/index.xq">{style:app-name()}</h:a>
  )
  else ()}
  
</h:div>
};