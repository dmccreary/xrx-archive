xquery version "1.0";

module namespace style = "http://danmccreary.com/style";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xrx="http://code.google.com/p/xrx";

declare variable $style:context := request:get-context-path();
declare variable $style:site-home := '/';
declare variable $style:web-path-to-site := '/db/dma';
declare variable $style:rest-path-to-site := concat($style:context, '/rest', $style:web-path-to-site);
declare variable $style:web-path-to-app := style:substring-before-last-slash(style:substring-before-last-slash(substring-after(request:get-uri(), '/rest')));
declare variable $style:db-path-to-site  := concat('xmldb:exist://',  $style:web-path-to-site);
declare variable $style:db-path-to-app  := concat('xmldb:exist://', $style:web-path-to-app) ;
declare variable $style:db-path-to-app-data := concat($style:db-path-to-app, '/data');
declare variable $style:app-info := doc(concat($style:web-path-to-app, '/app-info.xml'))/xrx:app-info;
declare variable $style:app-id := $style:app-info/xrx:app-id/text();
declare variable $style:app-name := $style:app-info/xrx:app-name/text();

declare variable $style:app-map := doc(concat($style:web-path-to-app, '/app-map.xml'));

(: shortcuts to global site-wide resources :)
declare variable $style:site-resources := concat(request:get-context-path(), '/rest', $style:web-path-to-site, '/resources');

declare variable $style:site-images := concat($style:site-resources, '/images');

declare variable $style:site-scripts := concat($style:site-resources, '/js');

(: we do not put the rest suffix on these.  They start with '/db' :)
declare variable $style:db-resources := concat($style:web-path-to-site, '/resources');
declare variable $style:db-site-code-tables := concat($style:db-resources, '/code-tables');

(: todo move this to a central site :)
declare variable $style:jquery := concat($style:site-scripts, '/jquery');
declare variable $style:site-css := concat($style:site-resources, '/css');

declare variable $style:site-info-file := concat($style:web-path-to-site, '/site-info.xml');

(: this is a bug in XSLTForms that if you put a '/' in the path after the .xq it will not render correctly. 
   So to get around this bug we convert all the forard slash chararacters to their percent encoded value of %2F.  :)
declare variable $style:feedback-form-path := 
   concat('/rest', $style:web-path-to-site, '/apps/feedback/edit/edit.xq?new=true&amp;uri=', replace(substring-after(request:get-uri(), '/rest'), '/', '%2F'));
declare variable $style:site-info := doc($style:site-info-file);
declare variable $style:form-debug-default := true();

declare function style:substring-before-last-slash($arg as xs:string?)  as xs:string {
       
   if (matches($arg, '/'))
   then replace($arg,
            concat('^(.*)', '/','.*'),
            '$1')
   else ''
 } ;
 
 (: home = 1, apps = 2 :)
 declare function style:web-depth-in-site() as xs:integer {
(: if the context adds '/exist' then the offset is six levels.  If the context is '/' then we only need to subtract 5 :)
let $offset := 
   if ($style:context)
then 6 else 5
    return count(tokenize(request:get-uri(), '/')) - $offset
};

 (: app ID :)
declare function style:app-id() as xs:string {
   let $uri := request:get-uri()
   let $tokens := tokenize($uri, '/')
   let $apps-position := index-of($tokens, 'apps')
   return 
      $tokens[$apps-position+1]
};

declare function style:app-name() as xs:string {
   let $app-id := style:app-id()
   let $app-path := concat($style:web-path-to-site, '/apps/', $app-id)
   let $app-info-path := concat($app-path, '/app-info.xml')
   let $xrx-info := doc($app-info-path)/xrx:app-info
   return $xrx-info//xrx:app-name/text()
};
 
declare function style:assemble-page($title as xs:string*, $breadcrumbs as node()*, 
                                     $style as element()*, $content as node()+) as element() {
    (
    util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')
    ,
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <link rel="shortcut icon" type="image/x-icon" href="{$style:site-images}/favicon.ico"/>
            <title>{ $title }</title>
            { style:css('xhtml') }
            { $style }
        </head>
        <body>
            <div class="container">
                { style:header() } 
                { style:breadcrumbs($breadcrumbs) }
                <div class="inner">
                   <h2>{$title}</h2>
                   { $content }
                </div>
                { style:footer() }
            </div>
        </body>
     </html>
     )
};

(: Convenience functions for assemble-page :)

(: Just pass title and content.  Put in the default breadcrumb and null for style :)
declare function style:assemble-page($title as xs:string, $content as node()+) as element() {
    style:assemble-page($title, (), (), $content)
};

(: put in the title, style and content :)
declare function style:assemble-page($title as xs:string, $style as node(), $content as node()+) as element() {
    style:assemble-page($title, style:breadcrumbs(()), $style, $content)
};

declare function style:breadcrumbs($suffix as node()*) as node() {
   <div class="breadcrumbs">
      <a href="{$style:rest-path-to-site}/index.xq">Home</a>
      
      &gt; <a href="{$style:rest-path-to-site}/apps/index.xq">Apps</a>
      
      {if (style:web-depth-in-site() > 2) then
      (' &gt; ',
      <a href="{$style:rest-path-to-site}/apps/{style:app-id()}/index.xq">{style:app-name()}</a>
      )
      else ()}
      
      {if ($suffix) then (' &gt; ', $suffix) else ()}
   </div>
};

declare function style:assemble-form($model as node(), $content as node()+) 
as node()+ {
    style:assemble-form((), (), $model, $content, true())
};

(:~
    An alternate version of style:assemble-form(), allowing debug mode.

    @param $model an XForms model node
    @param $content nodes for the body of the page
    @param $debug boolean to activate XSLTForms debug mode
    @return properly serialized XHTML+XForms page
:)
declare function style:assemble-form($model as node(), $content as node()+, $debug as xs:boolean) 
as node()+ {
    style:assemble-form((), (), $model, $content, $debug)
};

(:~
    A helper function for style:assemble-form(), with all optional parameters.

    @param $dummy-attributes an optional sequence of attributes to add to the HTML element
    @param $style an optional style node containing CDATA-encased CSS definitions
    @param $model an XForms model node
    @param $content nodes for the body of the page
    @return properly serialized XHTML+XForms page
:)
declare function style:assemble-form($title as xs:string, $dummy-attributes as attribute()*, $style as element(style)*, 
                                     $model as element(xf:model), $content as node()+)
as node()+ {
    style:assemble-form($dummy-attributes, $style, $model, $content, $style:form-debug-default)
};

(:~
    A helper function for style:assemble-form(), with all optional parameters.

    @param $title the text node containing the title of the page
    @param $breadcrumbs the element node containing the breadcrumbs
    @param $style an optional style node containing CDATA-encased CSS definitions
    @param $model an XForms model node
    @param $content nodes for the body of the page
    @param $dummy-attributes an optional sequence of attributes to add to the HTML element
    @param $debug boolean to activate XSLTForms debug mode
    @return properly serialized XHTML+XForms page
:)
declare function style:assemble-form(
        $title as xs:string,
        $dummy-attributes as attribute()*,
        $style as node()*, 
        $model as node(),
        $content as node()+, 
        $debug as xs:boolean) 
as node()+ {
    util:declare-option('exist:serialize', 'method=xhtml media-type=text/xml indent=yes process-xsl-pi=no')
    ,
    processing-instruction xml-stylesheet {concat('type="text/xsl" href="', request:get-context-path(), '/rest', '/db/xforms/xsltforms/xsltforms.xsl"')}
    ,
    if ($debug) then 
        processing-instruction xsltforms-options {'debug="no"'}
    else ()
    ,
    <html  
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
    xmlns:kert="http://kuberam.ro/ns/kert"
    kert:dummy="dummy"
    eXSLTFormsDataInstancesViewer="true"
    >{ $dummy-attributes }
        <head>
            
            <title>{ $title }</title>
            <link rel="stylesheet" type="text/css" href="edit.css"/>
            { style:css('xforms') }
            { $style }
            { $model }
        </head>
        <body>
            <div class="container">
                { style:header() } 
                <div class="inner">
                { style:breadcrumbs(()) }
                    <h2>{$title}</h2>
                    { $content }
                </div>
                { style:footer() }
            </div>
        </body>
    </html>
};

declare function style:css($page-type as xs:string) 
as node()+ {
    if ($page-type eq 'xhtml') then 
        (
       
        <link rel="stylesheet" href="{$style:site-css}/blueprint/screen.css" type="text/css" media="screen, projection" />,
        <link rel="stylesheet" href="{$style:site-css}/blueprint/print.css" type="text/css" media="print" />,<!--[if IE ]><link rel="stylesheet" href="{$style:site-css}/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->,
        <link rel="stylesheet" href="{$style:site-css}/style.css" type="text/css" media="screen, projection" />

    )
    else if ($page-type eq 'xforms') then 
        <link rel="stylesheet" href="{$style:site-css}/xforms.css.xq" type="text/css" />
    else ()
};

declare function style:header()  as node()*  {
<div id="header">
   <div id="banner">
      <span id="logo"><a href="{$style:rest-path-to-site}/index.xq"><img src="{$style:site-images}/dma-logo.png" alt="danmccreary" width="58" height="58"/></a></span>   
      
      <span id="banner-header-text">Dan McCreary &amp; Associates</span>
      
      <div id="banner-search">
         <form method="GET" action="{$style:rest-path-to-site}/apps/search/search.xq">
                    <strong>Search:</strong>
                    <input name="q" type="text"/>
                    <input type="submit" value="Search"/>        
         </form>
      </div>
      
      <div id="banner-login">
         <a href="/admin/admin/admin.xql">login</a>{' '} user: {' '} {xmldb:get-current-user()}
      </div>
   </div>
   <div class="banner-seperator-bar"/>
</div>   
};

declare function style:footer()  as node()*  {
<div id="footer">
   <div class="banner-seperator-bar"/>
   <div id="footer-text">Copyright 2009 Dan McCreary and Associates. All rights reserved.
      <a href="{$style:feedback-form-path}">Feedback</a>
   </div>
</div>
};

(:~ 
    Constructs a menu of pages for an app, based on an app's map file.
    
    @return a categorized, ordered list of the pages for an app
:)
declare function style:app-pages-menu() as element()+ {
    
    (: let $username := auth:get-current-user() :)
    let $username := xmldb:get-current-user()
    
    (: let $show-development-info := auth:has-developer-rights($username) :) 
    let $show-development-info := true()
    let $show-dev-dashboard := xs:boolean(request:get-parameter('dev-dashboard', '0'))
    return
        if ($show-development-info and $show-dev-dashboard) then
            (: Show app developer dashboard - the status all apps in the app-map :)
            let $pages := $style:app-map//xrx:page
            let $category-param := request:get-parameter('category', ())
            let $categories := if ($category-param) then $category-param else distinct-values($pages//xrx:category)
            return
                <div>
                    <h3>Development Dashboard for the {style:app-name()}</h3>
                    <p><a href=".">Return to App Menu</a></p>
                    {
                    for $category in $categories
                    let $category-name := $style:app-map//xrx:app-menu-category[@id eq $category]
                    let $page-count := count($pages[.//xrx:category eq $category])
                    order by $category-name/@order
                    return 
                        (
                        <h4>{$category-name (: concat($category-name, ' (', $page-count, if ($page-count eq 1) then ' page' else ' pages', ')') :)}</h4>
                        ,
                        style:app-pages-table($pages[.//xrx:category = $category])
                        )
                    }
                </div>
        else
            (: Show the app menu - the default :)
            let $pages := $style:app-map//xrx:page[.//xrx:show eq 'yes']
            let $app-menu-categories := $style:app-map//xrx:app-menu-category
            let $categories := distinct-values($pages//xrx:category)
            return
                (
                if ($show-development-info) then <p><a href="?dev-dashboard=1">Show App Development Dashboard</a></p> else ()
                ,
                for $category in $categories
                let $category-name := $app-menu-categories[@id eq $category]
                order by $category-name/@order
                return
                    style:app-pages-list($category-name, $pages[.//xrx:category = $category])
                )
};

(:~ 
    Helper function, constructs a table out of app pages.  
    
    @param $pages the page elements to be put into the table
    @return a titled, ordered list of the pages for an app
:)
declare function style:app-pages-table($pages as element(xrx:page)+) as element(table) {
    <table>
        <thead>
            <tr>
                <th/>
                <th>Path</th>
                <th>Label</th>
                <th>Description</th>
                <th>Show</th>
                <th>Status</th>
            </tr>
        </thead>
        {
        for $page at $count in $pages
        return
            <tr>
                <td>{$count}.</td>
                <td>{
                    let $path := concat(
                        $page/xrx:path/text(),
                        if ($page/xrx:param[1]/@name ne '') then
                            concat(
                                '?',
                                string-join(
                                    ( for $param in $page/xrx:param return concat($param/@name, '=', $param/@value ) )
                                    , '&amp;')
                                )
                        else ()
                        )
                    return <a href="{$path}">{$path}</a>
                }</td>
                <td>{$page/xrx:label/text()}</td>
                <td>{$page/xrx:app-menu/xrx:description/text()}</td>
                <td>{$page/xrx:app-menu/xrx:show/text()}</td>
                <td>{
                    let $development-stage := $page//xrx:development-stage/text()
                    return
                        (
                        attribute {'class'} {concat('status-', substring-before($development-stage, '%'))}
                        ,
                        <span title="{style:development-status-label($development-stage)}">{$development-stage}</span>
                        )
                }</td>
            </tr>
        }
    </table>
};

(:~ 
    Helper function, constructs each category's titled, ordered list of pages for an app.
    
    @param $category the id for the category to be shown
    @param $pages the page elements to be listed
    @return a titled, ordered list of the pages for an app
:)
declare function style:app-pages-list($category as xs:string*, $pages as element(xrx:page)+) as element()+ {
    (: no need to show Default category name :)
    if ($category eq 'Default') then () else <h3>{$category}</h3> 
    ,
    let $list := 
        <ol>{
            for $page in $pages
            let $path := $page/xrx:path/text()
            let $url-params := 
                if ($page/xrx:param[1]/@name ne '') then 
                    concat('?', 
                        string-join(
                            for $param in $page/xrx:param 
                            return concat($param/@name, '=', $param/@value)
                            ,
                            '&amp;'
                        )
                    )
                else ()
            let $label := $page/xrx:label/text()
            let $description := $page//xrx:description/text()
            let $username := xmldb:get-current-user()
            (: let $show-development-info := auth:has-developer-rights($username) :)
            let $show-development-info := true()
            let $development-info := 
                if ($show-development-info) then
                    style:development-status-image( $page//xrx:development-stage/text() )
                else ()
            let $xquery-missing-warning := 
                if ($show-development-info) then
                    let $exists-xquery := util:binary-doc-available(concat($style:db-path-to-app, '/', $path, '.xq'))
                    return
                        if ($exists-xquery) then () else <span style="color:red;">[missing .xq]</span> 
                else ()
            order by $page//xrx:category/@order
            return
                <li>
                    <a href="{concat($path, $url-params)}">{$label}</a> {' ', $description, ' ', $development-info, ' ', $xquery-missing-warning}
                </li>
        }</ol>
    return 
        if (count($pages) eq 1) then (: strip unnecessary list elements :)
            <p>{$list//li/node()}</p> 
        else 
            $list
};    

(:~ 
    Helper function, returns the development status image element.
    
    @param $development-stage the development status
    @return an image element
:)
declare function style:development-status-image($development-stage as xs:string) as element(img) {
    let $development-stage-label := style:development-status-label($development-stage)
    let $development-stage-text := concat('Development stage: ', $development-stage, ': ', $development-stage-label)
    let $development-stage-image := concat($style:web-path-to-site, '/resources/images/', '9px-', substring-before($development-stage, '%'), '.png')
    return 
        <img src="{$development-stage-image}" width="9" height="9" title="{$development-stage-text}" alt="{$development-stage-text}" />
};

(:~ 
    Helper function, returns the development status label.
    
    @param $development-stage the development status
    @return the development status label
:)
declare function style:development-status-label($development-stage as xs:string) {
    $style:site-info//xrx:development-stage[xrx:value eq $development-stage]/xrx:description/text()
};

(: This line will only appear if the user has a role of publisher 
declare function style:publish-controls($id as xs:string) as node()? {
    if ( auth:has-publish-rights(auth:get-current-user()) )
       then 
          <a href="../../publisher/publish-to-web?app-id={style:app-id()}&amp;id={$id}">Publish</a>
       else ()
};

:)

(: For revision status in all edits apps :)
declare function style:revision-status($id as xs:string) as element()* {
    if ($id) then
        <fieldset>
            <legend>Revision Status</legend>
                <xf:output ref="created-by">
                    <xf:label>Created By:  </xf:label>
                </xf:output>
                <br/> 
                <xf:output ref="created-datetime"> 
                    <xf:label>Date Created:  </xf:label>
                </xf:output>
                <br/> 
                <xf:output ref="last-modified-by">
                    <xf:label>Last Modified By:  </xf:label>
                </xf:output>
                <br/> 
                <xf:output ref="last-modified-datetime">
                    <xf:label>Previous Modification:  </xf:label>
                </xf:output>
        </fieldset>
    else ()
};



(:For revision status in all edits apps hist namespace :)
declare function style:revision-status-hist($id as xs:string) as node() {
<fieldset>
         <legend>Revision Status</legend>
         {if ($id) then 
             (<xf:output ref="hist:created-by">
                  <xf:label>Created By:</xf:label>
              </xf:output>,<br/>,<br/>,
              <xf:output ref="hist:created-datetime">
                  <xf:label>Date Created:</xf:label>
              </xf:output>,<br/>,<br/>)
         else()}
              {<xf:input ref="hist:last-modified-by">
                   <xf:label>Modify By:</xf:label>
                   <xf:hint>Author of this modification or edit (current user).</xf:hint>
                </xf:input>}<br/><br/>
               {if ($id) then 
               <xf:output ref="hist:last-modified-datetime">
                   <xf:label>Previous Modification:</xf:label>
               </xf:output>
         else()}<br/>
</fieldset>
};

(: For revision status in all edits apps :)
declare function style:revision-status-table($item as node()?) as node()? {
    if ($item) then
    <div class="revision-status">
        <table class="span-12">
            <thead>
               <tr>
                  <th class="span-3">Field</th>
                  <th class="span-8 last">Value</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td class="field-label">Created By:</td>
                  <td>{$item//*:created-by/text()}</td>
               </tr>
               <tr>
                  <td class="field-label">Date Created:</td>
                  <td>{$item//*:created-datetime/text()}</td>
               </tr>
               <tr>
                  <td class="field-label">Last Modified By:</td>
                  <td>{$item//*:last-modified-by/text()}</td>
               </tr>
               <tr>
                  <td class="field-label">Last Modified Date:</td>
                  <td>{$item//*:last-modified-datetime/text()}</td>
               </tr>
             </tbody>
        </table>
    </div>
    else ()
};

(: custom HTML header that includes the syntax highlighting portion of the page :)
(: http://code.google.com/p/syntaxhighlighter :)
declare function style:assemble-syntax-page($title as xs:string*, $content as node()+) as element() {
    (
    util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')
    ,
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <link rel="shortcut icon" type="image/x-icon" href="{$style:site-images}/favicon.ico"/>
            <title>{ $title }</title>
            { style:css('xhtml') }
            
            <script src="{$style:site-scripts}/syntax/shCore.js" type="text/javascript"></script>
            <script src="{$style:site-scripts}/syntax/shBrushCss.js" type="text/javascript"></script>
            <script src="{$style:site-scripts}/syntax/shBrushJScript.js" type="text/javascript"></script>
            <script src="{$style:site-scripts}/syntax/shBrushPlain.js" type="text/javascript"></script>
            <script src="{$style:site-scripts}/syntax/shBrushXml.js" type="text/javascript"></script>
            <script src="{$style:site-scripts}/syntax/shBrushXQuery.js" type="text/javascript"></script>
            
            <link href="{$style:site-css}/syntax/shCore.css" rel="stylesheet" type="text/css" /> 
            <link id="theme" href="{$style:site-css}/syntax/shThemeDefault.css" rel="Stylesheet" type="text/css" />

            <script type="text/javascript">
                SyntaxHighlighter.config.stripBrs = true;
                SyntaxHighlighter.defaults[ 'auto-links'] = false;
                SyntaxHighlighter.defaults[ 'wrap-lines'] = false;
                SyntaxHighlighter.all();
             </script>
             
        </head>
        <body>
            <div class="container span-24 last">
                { style:header() } 
                { style:breadcrumbs(()) }
                <div class="inner">
                   <h2>{$title}</h2>
                   { $content }
                </div>
                { style:footer() }
            </div>
        </body>
     </html>
     )
};

(: This function finds the longest strings in a sequence of strings :)
declare function style:max-length($string-seq as xs:string*) as xs:string* {
  let $max := max (for $s in  $string-seq  return string-length($s))
  return $string-seq[string-length(.) = $max]
  };


declare function style:view-resources($resources as node()?) as node() {
   <div class="resources">
      <div class="resource-title"><b>Resources:</b></div>
      <table class="span-24">
         <thead>
            <tr>
               <th class="span-4">Name</th>
               <th class="span-4">Type</th>
               <th class="span-16 last">URL</th>
            </tr>
         </thead>
         <tbody>{
            for $resource in $resources/resource
               return
               <tr>
                   <td>{$resource/resource-name/text()}</td>
                   <td>{style:resource-type-label($resource/resource-type/text())}
                   
                   </td>
                   <td><a href="{$resource/resource-url/text()}">{$resource/resource-url/text()}</a></td>
               </tr>
         }</tbody>
      </table>
   </div>
};

(: todo the help system is the standard the site :)
declare function style:resource-type-label($resource-type-value as xs:string?) as xs:string {
   (: use a central standard for resource type codes :)
   let $lookup-table := doc('/db/dma/resources/code-tables/resource-type-codes.xml')/code-table
   let $label := $lookup-table//item[value = $resource-type-value]/label/text()
   return
     if ($label)
         then $label
         else concat('No Label ', $resource-type-value)
};

(: This is the simple non-parameterized version of edit controls designed to be placed at all of the end of the view-item pages 
  
  style:edit-controls($id)
  
:)
declare function style:edit-controls($id as xs:string) as node() {
<div class="edit-controls">
    { (: only put the edit controls in if the user has edit rights auth:has-edit-rights(auth:get-current-user()) :)
    if ( true() )
       then (
           <a href="../edit/edit.xq?id={$id}">Edit</a>,
           <a href="../edit/delete-confirm.xq?id={$id}">Delete</a>,
           style:publish-controls($id)
       ) else ()
    }
    <a href="../edit/get-instance.xq?id={$id}">View XML</a>
</div>
};

(: This is the edit-controls with params.  It has a second parameter which controls which of the five buttons to display.
The params string is of the form "vedpx" where:

v: to enable the View button
e: to enable the Edit button
d: to enable the Delete button
p: to enable the Publish button
x: to enable the "View XML" button.

To enable all five controls call it like this:

   style:edit-controls($id, 'vedpx')
   
:)
declare function style:edit-controls($id as xs:string, $params as xs:string) as node() {
<div class="edit-controls">
    {if (contains($params, 'v')) then <a href="../views/view-item.xq?id={$id}">View</a> else () }
    { (: only put the edit controls in if the user has edit rights auth:has-edit-rights(auth:get-current-user()):)
    if ( true() )
       then (
           if (contains($params, 'e')) then <a href="../edit/edit.xq?id={$id}">Edit</a> else (),
           if (contains($params, 'd')) then <a href="../edit/delete-confirm.xq?id={$id}">Delete</a> else (),
           if (contains($params, 'p')) then style:publish-controls($id) else ()
       ) else ()
    }
    {if (contains($params, 'x')) then <a href="../edit/get-instance.xq?id={$id}">View XML</a> else () }
</div>
};

(: The additional config parameter here is for multi-object apps.  They have a node that includes links for the VEDPX actions 
Example:
<config>
   <view>../views/view-widget.xq?id=</view>
   <edit>../edit/edit-widget.xq?id=</edit>
   <delete>../edit/delete-confirm-widget.xq?id=</delete>
   <publish>../edit/publish-widget.xq?id=</publish>
   <xml>../edit/get-instance-widget.xq?id-/publish-widget.xq?id=</xml>
</config>

:)
declare function style:edit-controls($id as xs:string, $params as xs:string, $config as node()) as node() {
<div class="edit-controls">
    {if (contains($params, 'v')) then <a href="{$config/view/text()}{$id}">View</a> else () }
    { (: only put the edit controls in if the user has edit rights auth:has-edit-rights(auth:get-current-user()):)
    if ( true() )
       then (
           if (contains($params, 'e')) then <a href="{$config/edit/text()}{$id}">Edit</a> else (),
           if (contains($params, 'd')) then <a href="{$config/delete/text()}{$id}">Delete</a> else (),
           if (contains($params, 'p')) then style:publish-controls($id) else ()
       ) else ()
    }
    {if (contains($params, 'x')) then <a href="../edit/{$config/xml/text()}{$id}">View XML</a> else () }
</div>
};


(: This line will only appear if the user has a role of publisher :)
(: note that the style module uses the html namespace so we need to use *: as a prefix to select the null namespace :)
declare function style:publish-controls($id as xs:string) as node()? {

(: this line assumes that each item in the application collection has a unigue id :)
let $doc := collection($style:db-path-to-app-data)/*[*:id/text() = $id]
return
    (: auth:has-publish-rights(auth:get-current-user()) :)
    if ( true() )
       then
          if ($doc//*:publication-status-code/text() = 'published')
             then <a href="../../publisher/un-publish-to-web.xq?app-id={style:app-id()}&amp;id={$id}">Un-Publish</a>
             else <a href="../../publisher/publish-to-web.xq?app-id={style:app-id()}&amp;id={$id}">Publish</a>
       else ()
};
