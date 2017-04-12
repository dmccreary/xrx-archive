xquery version "1.0";

(: MODS XRX Application :)

import module namespace style = "http://www.danmccreary.com/xrx" at "../../modules/style.xqm";

let $model :=
<xf:model>
    <xf:instance xmlns="" id="my-instance" src="classifiers.xml"/>
    <xf:submission id="save" method="post" action="save.xq" replace="all"/>
</xf:model>

let $content :=
<div class="content">
    <h1>Manage List of Classifiers</h1>
    <p>These classifiers are similar to tags but they are enumerated and must be selected from a list. 
    Their primary use is to create subsets of terms to restrict reports.</p>
    <xf:group>
        <table>
            <thead>
                <tr>
                    <th class="Label">Classifier Label (for pick list)</th>
                    <th class="Value">Classifier Value (display in colums)</th>
                    <th class="Description">Classifier Description</th>
                </tr>
            </thead>
        </table>
        <br/>
        <xf:repeat nodeset="instance('my-instance')/item" id="item-repeat">
            <xf:input ref="label" class="Label inline-control"/>
            <xf:input ref="value" class="Value inline-control"/>
            <xf:input ref="description" class="Description inline-control"/>
            <xf:trigger>
                <xf:label>Delete Classifier</xf:label>
                <xf:delete nodeset="instance('my-instance')/item[index('item-repeat')]" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:repeat>
    </xf:group>
    <xf:trigger>
        <xf:label>Add New Classifier</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:insert nodeset="instance('my-instance')/item" at="last()" position="after"/>
            <!-- set the value to the item count -->
            <xf:setvalue ref="instance('my-instance')/item[last()]/label" value=""/>
            <xf:setvalue ref="instance('my-instance')/item[last()]/value" value=""/>
        </xf:action>
    </xf:trigger>
    <xf:trigger>
        <xf:label>Delete Selected Classifier</xf:label>
        <xf:delete nodeset="instance('my-instance')/item[index('item-repeat')]" ev:event="DOMActivate"/>
    </xf:trigger>
    <br/>
    <xf:submit submission="save">
        <xf:label>Save</xf:label>
    </xf:submit>
</div>
