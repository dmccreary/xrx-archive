xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-name := 'jiem-conditions.xml'
let $doc := concat($data-collection, '/', $doc-name)

let $prefix := request:get-parameter('prefix', 'A')
let $lc-prefix := lower-case($prefix)
let $title :=concat('Rules With', ' ', $prefix)
let $sp := ' '

let $content :=
<div class="content">
        <div class="nav-bar">
            <a href="starts-with.xq?prefix=A">A</a>{$sp}
            <a href="starts-with.xq?prefix=B">B</a>{$sp}
            <a href="starts-with.xq?prefix=C">C</a>{$sp}
            <a href="starts-with.xq?prefix=D">D</a>{$sp}
            <a href="starts-with.xq?prefix=E">E</a>{$sp}
            <a href="starts-with.xq?prefix=F">F</a>{$sp}
            <a href="starts-with.xq?prefix=G">G</a>{$sp}
            <a href="starts-with.xq?prefix=H">H</a>{$sp}
            <a href="starts-with.xq?prefix=I">I</a>{$sp}
            <a href="starts-with.xq?prefix=J">J</a>{$sp}
            <a href="starts-with.xq?prefix=K">K</a>{$sp}
            <a href="starts-with.xq?prefix=L">L</a>{$sp}
            <a href="starts-with.xq?prefix=M">M</a>{$sp}
            <a href="starts-with.xq?prefix=N">N</a>{$sp}
            <a href="starts-with.xq?prefix=O">O</a>{$sp}
            <a href="starts-with.xq?prefix=P">P</a>{$sp}
            <a href="starts-with.xq?prefix=Q">Q</a>{$sp}
            <a href="starts-with.xq?prefix=R">R</a>{$sp}
            <a href="starts-with.xq?prefix=S">S</a>{$sp}
            <a href="starts-with.xq?prefix=T">T</a>{$sp}
            <a href="starts-with.xq?prefix=U">U</a>{$sp}
            <a href="starts-with.xq?prefix=V">V</a>{$sp}
            <a href="starts-with.xq?prefix=W">W</a>{$sp}
            <a href="starts-with.xq?prefix=X">X</a>{$sp}
            <a href="starts-with.xq?prefix=Y">Y</a>{$sp}
            <a href="starts-with.xq?prefix=Z">Z</a>{$sp}
         </div>
        <p><b>Report generation date-time: </b> {current-dateTime()}.  <b>Sort:</b> Case insensitive alphabetical by term.</p>
        <ol>
        {
         for $item in doc($doc)/conditions/condition[starts-with(@predicate, $lc-prefix)]
            let $predicate := string($item/@predicate)
            order by $predicate
            return
               <li>
                  <b>{$predicate}</b> - {string($item/@subject)}
               </li>
      }
      </ol>
      </div>
return style:assemble-page($title, $content)
