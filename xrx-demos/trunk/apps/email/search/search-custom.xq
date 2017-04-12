xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.w3.org/1999/xhtml";

(: return the nth month name :)
declare function local:month-name($month-number as xs:integer) as xs:string {
 ('January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December')
   [$month-number]
 };
 
let $title := 'Search E-Mail Messages Advanced'
let $classifiers-file-path := concat($style:db-path-to-app, '/code-tables/message-classification-codes.xml')
let $classifiers := doc($classifiers-file-path)//*:item

let $person-file-path := concat($style:db-path-to-app, '/code-tables/person-name-codes.xml')
let $persons := doc($person-file-path)//*:item

let $style :=
<style type="text/css"><![CDATA[
   -moz-border-radius: 10px;
   -webkit-border-radius: 10px;
]]></style>

let $content :=
<div class="content">
    <form method="GET" action="search-advanced.xq" class="span-24 last">

    <fieldset class="span-10">
        <legend>Search By:</legend>
        
        <span class="field-label">Name:</span>
        <input type="text" class="input" maxlength="100" size="40" name="name"/>
        <br/>
        
        <span class="field-label">Email:</span>
        <input type="text" class="input" maxlength="100" size="40" name="from"/>
        <br/>
        
        <span class="field-label">Station code:</span>
        <input type="text" class="input" size="40" name="classifier"/>
        <br/>
        
        <span class="field-label">Subject:</span>
        <input type="text" class="input" size="40" name="subject"/>
        <br/>
 
        <span class="field-label">Text contains:</span>
        <input type="text" class="input" size="40" name="q"/>
        <br/>
 
        <span class="field-label">Since:</span>
        <select name="after-year">
            <option value="1999" selected="selected">1999</option>
                {for $year in (1999 to 2010)
                 return 
                <option value="{$year}">{$year}</option>
            }
        </select>
        <select name="after-month">
                {for $month in (1 to 12)
                 return 
                <option value="{$month}">{local:month-name($month)}</option>
            }
        </select>
        <select name="after-day">
                {for $day in (1 to 31)
                 return 
                   <option value="{$day}">{$day}</option>
            }
        </select>
        <br/>
        
        <span class="field-label">Before:</span>
        <select name="before-year">
                {for $year in (1999 to 2009)
                 return 
                   <option value="{$year}">{$year}</option>
            }
            <option value="2010" selected="selected">2010</option>
        </select>
        <select name="before-month">
                {for $month in (1 to 12)
                 return 
                <option value="{$month}">{local:month-name($month)}</option>
            }
        </select>
        <select name="before-day">
                {for $day in (1 to 31)
                 return 
                <option value="{$day}">{$day}</option>
            }
        </select>
    </fieldset>

    <fieldset  class="span-10">
        <legend>Sort Result Order</legend>
        <select name="sort">
            <option value="date">Date</option>
            <option value="title">Subject</option>
            <option value="from">From</option>
            <option value="to">To</option>
            <option value="classifier">classifier</option>
        </select>
        <div class="default">
            <input type="radio" name="sort_order" class="radio" value="desc"
                checked="checked"/>Descending
            <input type="radio"
                name="sort_order" class="radio" value="asc"/>Ascending
        </div>
    </fieldset>
                
        <div class="searchSubmit">
            <input type="submit" value="Search" class="submit"/>
        </div>
    </form>
</div>

return style:assemble-page($title, $content)