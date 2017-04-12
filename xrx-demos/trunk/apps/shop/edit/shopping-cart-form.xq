xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $app-collection := '/db/dma/apps/shop'
let $data-collection := concat($app-collection, '/data')
let $title := 'Metadata Shopper'

return
let $model :=
        <xf:model>
            <xf:instance xmlns="" id="search-criteria">
                <data>
                    <q/>
                </data>
            </xf:instance>
            <xf:instance xmlns="" id="shopping-cart">
                <data>
                    <!-- this is the file name that the shopping cart contents will be stored -->
                    <filename>test.xml</filename>
                    <element>
                        <name>Super</name>
                        <prefix>uc</prefix>
                        <definition>The root of all data elements.</definition>
                    </element>
                </data>
            </xf:instance>
            
            <xf:instance xmlns="" id="search-response">
                <data/>
            </xf:instance>
            
            <xf:instance xmlns="" id="list-files-response">
                <data/>
            </xf:instance>
            
            <xf:instance xmlns="" id="save-wantlist-response">
                <data/>
            </xf:instance>
            
            <xf:submission id="search-submission" ref="instance('search-criteria')" method="get" 
            action="../search/search.xq" replace="instance" instance="search-response" separator="&amp;">

            </xf:submission>
            
            <!-- Gets the list of current files in the server-side collection and puts them in the model -->
            <xf:submission id="list-files" method="post" action="/rest/db/dma/shop/list-files.xq" replace="instance" instance="list-files-response"/>

            <xf:submission id="save-wantlist" ref="instance('shopping-cart')" method="post" 
            action="{$app-collection}/save.xq" replace="instance" instance="save-wantlist-response" separator="&amp;">
            </xf:submission>
            
            <xf:submission id="echo-search-criteria" ref="instance('search-criteria')" method="post" action="../xqueries/echo-test.xq" replace="all"/>
            <xf:submission id="echo-wantlist" ref="instance('shopping-cart')" method="post" action="../xqueries/echo-test.xq" replace="all"/>
           
           

        </xf:model>
 
 let $content :=
 <div class="content">
     {$app-collection}<br/>

                <xf:input ref="instance('search-criteria')/q" incremental="true" id="search-field">
                    <xf:label>Search:</xf:label>
                    <xf:action ev:event="DOMActivate">
                       <xf:send submission="search-submission"/>
                    </xf:action>
                </xf:input>
                
                <xf:submit submission="search-submission">
                    <xf:label>Search</xf:label>
                </xf:submit>

            
        <xf:output value="count(instance('search-response')/element)">
           <xf:label>Search Result Count: </xf:label>
        </xf:output>
        
        <h3>Search Results:</h3>
        <xf:repeat nodeset="instance('search-response')/element">
            <div class="result">
                 <xf:trigger>
                    <xf:label>Add</xf:label>
                </xf:trigger>
                <div class="result-text">
                    <b>
                        <xf:output ref="name"/>
                    </b>
                    <i>
                        <xf:output ref="definition"/>
                    </i>
               </div>
           </div>
        </xf:repeat>
                
    </div>

return
    style:assemble-form($title, (), (), $model, $content, true())