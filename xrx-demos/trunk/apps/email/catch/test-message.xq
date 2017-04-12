xquery version "1.0";

let $current-dateTime := current-dateTime()
return
<message>
    <id>1</id>
    <headers>
        <date>{$current-dateTime}</date>
        <from>
            <label>Sue Smith</label>
            <address>sue.smith@example.com</address>
        </from>
        <to>
            <label>John Smith</label>
            <address>johndoe@example.com</address>
        </to>
        <cc>
            <label>Fred Jones</label>
            <address>fred.jones@example.com</address>
        </cc>
        <subject>XRX training classes next week.</subject>
        <categories>
            <category>urgent</category>
        </categories>
    </headers>
    <attachments>
        <attachment filename="mydoc.doc" mimetype="binary/ms-word"/>
    </attachments>
    <body>
        <text>Test message that will be automatically indexed by the Lucene engine.</text>
    </body>
</message>
