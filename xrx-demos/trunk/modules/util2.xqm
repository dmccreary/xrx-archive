xquery version "1.0";

(: general utilities functions - not to be included by other modules :)

module namespace util2 = "http://danmccreary.com/util2";
import module namespace time = "http://danmccreary.com/time" at 'time.xqm';

declare function util2:substring-before-last-slash($in as xs:string?) as xs:string {  
   if (matches($in, '/'))
     then replace ($in, '^(.*)/.*', '$1')
     else ()
};
 
declare function util2:substring-after-last-slash($in as xs:string?) as xs:string {
   replace ($in, '^.*/', '')
};

declare function util2:substring-before-last($in as xs:string?, $delim as xs:string) as xs:string {
   if (matches($in, $delim))
   then replace($in,
            concat('^(.*)', $delim,'.*'),
            '$1')
   else ''
};

declare function util2:substring-after-last($in as xs:string?, $delim as xs:string) as xs:string {
   replace ($in,concat('^.*',$delim),'')
 } ;
 
(: create all the collections in a path if they do not exist and report results :)
(: this must be run aa an admin user :)
declare function util2:mkdirs-r($done as xs:string?, $todo as xs:string?) as node()* {
(: create a sequence of tokens between the slashes.  $step[1] is null since the first char is '/' :)
let $steps := tokenize($todo, '/')
return
if (count($steps) ge 2)
    then
        (let $first := $steps[2]
         let $rest := substring-after($todo, '/')
         let $path := concat($done, '/', $first)
         let $check-path :=
            if (xmldb:collection-available($path))
               then false()
               else (
                     xmldb:login(util2:substring-before-last-slash($path), 'admin', 'admin123'),
               xmldb:create-collection(util2:substring-before-last-slash($path), util2:substring-after-last-slash($path))
               )
         return
              (
                 <check>
                    <path>{$path}</path>
                    <status>{if ($check-path = true()) then 'new collection created' else 'collection ok' }</status>
                 </check>,
                 util2:mkdirs-r($path, $rest)
               )
          )
    else ()
};

declare function util2:mkdirs($collection-path as xs:string) as node()* {
<checks>
   {util2:mkdirs-r((), $collection-path)}
</checks>
};

declare function util2:month-number-to-string($in as xs:integer) as xs:string {
let $months := ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
return $months[$in]
};

(: returns true if the current user is in the dba group :)
declare function util2:is-dba() as xs:boolean {
   let $current-user := xmldb:get-current-user()
   let $list-of-groups := xmldb:get-user-groups($current-user)
   return
      if ($list-of-groups = 'dba')
         then true()
         else false()
};

declare function util2:format-number($input, $format as xs:string) as xs:string {
xs:string($input)
};

declare function util2:test-status() as node() {
let $collection := substring-after(util2:substring-before-last-slash(request:get-uri()), '/rest')
let $test-status-path := concat($collection, '/test-status.xml')
let $tests := doc($test-status-path)//test

let $sorted-files :=
   for $file in xmldb:get-child-resources( $collection )
   order by xs:dateTime(xmldb:last-modified($collection, $file)) descending
   return
      if (not($file='index.xq') and ends-with($file, '.xq') or ends-with($file, '.html'))
        then $file
        else ()
   
return
<div class="content">
      <p>Unit Tests Sorted By Last Update</p>
      <table class="datatable span-24">
         <thead>
            <tr>
               <th class="span-5 row1">File</th>
               <th class="span-10 row1">Description</th>
               <th class="span-1 row1">Status</th>
               <th class="span-2 row1">Modified</th>
            </tr>
         </thead>
      {for $file at $count in $sorted-files
         let $tests-for-this-file := $tests[file=$file]
         (: we can have many tests for each file, but with different parameters :)
         for $test in $tests-for-this-file
            return 
                let $params := $test//param
                let $params-string :=
                  if ($params)
                     then
                         concat('?',
                           for $param in $params
                           return
                              concat($param/@name/string(), '=', $param/@value/string())
                            )
                     else ()
                return
                    <tr>
                       {if ($count mod 2)
                           then attribute class {'odd'}
                           else attribute class {'even'}
                        }
                       <td style="text-align:left;"><a href="{$file}{$params-string}">{$file}{$params-string}</a></td>
                       <td style="text-align:left;">{$test/desc/text()}</td>
                       <td style="text-align:center;">
                        {if ($test/status/text() = 'fail') 
                           then <span class="fail">fail</span>
                           else <span class="pass">pass</span>
                        }
                       </td>
                       <td style="text-align:left;">{time:us-dateTime(xmldb:last-modified($collection, $file))}</td>
                    </tr>
             }
      </table>
   Test Status at <a href="/rest{$test-status-path}">{$test-status-path}</a>
</div>
};