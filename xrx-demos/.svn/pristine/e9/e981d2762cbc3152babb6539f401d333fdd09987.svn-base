xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.w3.org/1999/xhtml";
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
        <legend>Keyword Search</legend>
        
        <input type="text" class="input" maxlength="100" size="40" name="keywords"
            style="width:100%;"/>
        <div class="default">
            <span class="field-label">Field:</span>
            <select name="search_in" class="multiselect" multiple="multiple">
                <option value="all" selected="selected">All</option>
                <option value="from">From</option>
                <option value="to">To</option>
                <option value="cc">CC</option> 
                <option value="subject">Subject</option>  
            </select>
        </div>
        
        <div>
            <span class="field-label">Match Type:</span>
            <select name="match-type" >
                <option value="any" selected="selected">Any keyword(or)</option>
                <option value="exact">Exact Match</option>
                <option value="all">All Keywords(and)</option>
                <option value="fuzzy">Fuzzy Match</option>
            </select>
        </div>
    </fieldset>

    <fieldset class="span-6 last">
        <legend>From</legend>
        <select name="from" class="multiselect" multiple="multiple">
                <option value="any" selected="selected">Any Person</option>
                {for $person in $persons
                 return 
                <option value="{$person/*:value/text()}">{$person/*:label/text()}</option>
            }
       </select>
    </fieldset>

    <fieldset class="span-6">
        <legend>Message Category</legend>
        <select name="cat" size="12" class="multiselect" multiple="multiple">
            <option value="all" selected="selected">All Categories</option>
            {for $classifier in $classifiers
             return 
                <option value="{$classifier/*:value/text()}">{$classifier/*:label/text()}</option>
            }
        </select>
    </fieldset>

    <fieldset  class="span-6">
        <legend>Recency</legend>
        <select name="date" style="width:150px">
            <option value="0" selected="selected">Any Day</option>
            <option value="1">Today</option>
            <option value="7">This Week</option>
            <option value="30">One Months</option>
            <option value="90">Three Months</option>
            <option value="180">Six Months</option>
            <option value="365">One Year</option>
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