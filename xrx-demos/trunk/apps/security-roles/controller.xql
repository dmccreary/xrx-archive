xquery version "1.0";

(:~
    controller.xql for URL rewriting.
    Uses the "app-level" behavior, as defined in the url-rewriting.xqm module
:)

import module namespace url = "http://exist-db.org/ns/url-rewriting" at "../../modules/url-rewriting.xqm";

(: Standard controller.xql variables passed in from the URL Rewriting framework :)

declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:controller external;
declare variable $exist:path external;
declare variable $exist:resource external;

(: Wrap these variables into a single element, to pass onto the URL Rewriting module :)

declare variable $url-values := 
    <params>
        <param name="uri">{request:get-uri()}</param>
        <param name="root">{$exist:root}</param>
        <param name="prefix">{$exist:prefix}</param>
        <param name="controller">{$exist:controller}</param>
        <param name="path">{$exist:path}</param>
        <param name="resource">{$exist:resource}</param>
    </params>;

(: The URL Rewriting module contains the URL Rewriting behavior for this page :)

url:app-level($url-values)
