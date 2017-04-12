xquery version "1.0";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
import module namespace transform = "http://exist-db.org/xquery/transform";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/xhtml; charset=UTF-8" />
        <title>Project EA Queries</title>
    </head>
    <body>
        <h2>Query Index</h2>
        <h4>Data files</h4>
        <ol>
            <li><a href="../../../../civil-war/va-convention/proceedings/ref/delegates.xml">delegates.xml</a></li>
            <li><a href="../../../../civil-war/va-convention/proceedings/ref/locations.xml">locations.xml</a></li>
            <li><a href="../../../../civil-war/va-convention/proceedings/ref/coll-index.xml">coll-index.xml</a></li>
            <li><a href="../../../../civil-war/va-convention/proceedings/ref/master-events.xml">master-events.xml</a></li>
            <li><a href="../../../../civil-war/va-convention/proceedings/ref/votes.xml">votes.xml</a></li>
        </ol>

        <h4>URL parameters for search queries</h4>
        <ul>
        <li>element: the element name to be searched, used by element search - set to element=p for full-text search</li>
        <li>keyword: the words or phrases to search for</li>
        <li>startDate: the starting date of a range - inclusive</li>
        <li>endDate: the ending date of a range - inclusive</li>
        <li>delegates: delegates to select - comma-separated for multiple values</li>
        <li>locations: locations to select - comma-separated for multiple values</li>
        <li>maxMatches: the number of matches on any hit to include in the result - default 5</li>
        <li>start: the index of the first hit to include - default 1</li>
        <li>hitsPerPage: the number of hits to include on a page - default 10</li>
        <li>order: the field to use in sorting hits - legal values: date (ascending), score (descending), delegate (ascending), location (ascending)</li>
        <li>direction: the direction of the sort - ascending or descending - default indicated in parentheses below</li>
</ul>
        <h4>Search queries</h4>
        <ol>
            <li><a href="speech-search-results.xq?keyword=truth&amp;order=date&amp;direction=descending"
                    >speech-search-results.xq?keyword=truth&amp;order=date&amp;direction=descending</a><br />
                    Paginated, sorted search results on
                speeches. Returns 10 hits per page. URL parameters used are keyword (search term),
                start (number of the first "hit" per page), hitsPerPage (number of hits per page).
                delegates, startDate, endDate, locations parameters also work here. Sorting parameters are order (date, score,
                delegate, location) and direction (ascending, descending).</li>
                <br />

            <li><a href="speech-search-analysis.xq?keyword=truth"
                    >speech-search-analysis.xq?keyword=truth</a><br /> Returns analysis for speech
                search based on the keyword parameter. delegates, startDate, endDate, locations
                parameters also work here.</li>
                <br />
                
            <li><a href="element-search-results.xq?element=p&amp;keyword=loyal*&amp;order=date&amp;direction=ascending"
                    >element-search-results.xq?element=p&amp;keyword=loyal*&amp;order=date&amp;direction=ascending</a><br /> This is a
                multi-purpose query written to search on specific, indexed nodes through the element
                parameter. For full text searches, "element=p" should be passed. Currently the
                possible element parameter values are: note, floatingText, p. We have separated
                speech searches from this query since the data being returned for those are much
                more substantial. startDate, endDate parameters may also be used in this query.</li>
            <br />

            <li><a href="element-search-analysis.xq?element=p&amp;keyword=loyal*"
                    >element-search-analysis.xq?element=p&amp;keyword=loyal*</a><br />
                Date analytics that are returned with each general node search. To be used with
                timeplot.
            </li>
            <br />

            <li><strong>TEMP - DO NOT USE</strong> <a href="speech-search-results-cloud.xq?delegates=earlyja&amp;startDate=1861-02-13&amp;endDate=1861-05-01"
                    >speech-search-results-cloud.xq?delegates=earlyja&amp;startDate=1861-02-13&amp;endDate=1861-05-01</a><br />
                Testing.
            </li>
        </ol>

        <h4>Page-return queries</h4>
        <ol>
            <li><a href="get-page-with-pb-query.xq?keyword=convention&amp;id=pb.3.300"
                    >get-page-with-pb-query.xq?keyword=gentleman&amp;id=pb.3.300</a><br /> This query will
                return the text content of a single page of the book and re-execute the original
                query, allowing highlighting of the search term. Requires the original keyword
                parameter, as well as the xml:id of the "match" from the search result list. This
                will work for speech searches and full-text, as the match node is now structured in
                the same way. This query also passes xml:id attribute values for parent nodes, when
                applicable. These will (mostly) refer back to coll-index.xml and allow breadcrumbing
                to be built at the page level.</li>
            <br />

            <li><a href="get-page-with-pb.xq?id=pb.2.109">get-page-with-pb.xq?id=pb.2.109</a><br />
                Returns the text content of a single page without a search term. This query and #1
                wrap parent nodes in a parents node structure, while the page being delivered is
                wrapped in hit elements.</li>
        </ol>

        <h4>Timeline/Timeplot queries</h4>
        <ol>
            <li><a href="events-chunk.xq?startDate=1861-02-01&amp;endDate=1861-04-14"
                    >events-chunk.xq?startDate=1861-02-01&amp;endDate=1861-04-14</a><br /> Returns
                event nodes from master-events.xml according to required startDate and endDate
                parameters.</li>
        </ol>

        <h4>Notes</h4>
        <p>The database path to the page images is
                <strong>/db/civil-war/va-convention/proceedings/images</strong>.</p>
    </body>
</html>
