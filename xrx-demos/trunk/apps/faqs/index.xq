xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'FAQ Manager'

let $content :=
<div class="content">
        <p>Welcome to the Frequently Asked Questions Manager.  This demo uses w3c XForms and has been tested with FireFox 2.0 with the XForms addon.</p>
        <p>This demo allows you to manipulate frequently asked questions using XForms and eXist with basic database operations CRUDS (Create, Read, Update, Delete and Search).
            <ol>
                <li>
                    <a href="views/list-items.xq">List</a> List of all FAQs 
                </li>
                <li>
                    <a href="edit/edit.xq?new=true">New</a> Create New FAQ
                </li>
                <li>
                    <a href="search/search-form.xq">Search</a> Search FAQs
                </li>
                <li>
                    <a href="views/list-categories.xq">List Categories</a> List all FAQ Categories
                </li>
                <li>
                    <a href="views/metrics.xq">FAQ Metrics</a> Counts of various FAQ Metrics
                </li>
            </ol>
          </p>
</div>

return style:assemble-page($title, $content)
         