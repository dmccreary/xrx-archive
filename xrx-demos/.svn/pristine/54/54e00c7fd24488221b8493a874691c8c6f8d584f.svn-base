xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at "../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Sitemap Demo'

let $content :=
<div class="content">
            <ol>
            <li>
                <a href="sitemap.xq">Sitemap</a> Sitemap of the root collection
            </li>
            <li>
                <a href="collection-titles.xml">Titles</a> XML file of the titles
            </li>
            
             <li>
                <a href="http://en.wikibooks.org/wiki/XQuery/Sitemap_for_Content_Management_System">Wikibook Article</a> A Sample in the Wikibook to demonstrate recursion
            </li>
            
        </ol>

</div>
return style:assemble-page($title, $content)