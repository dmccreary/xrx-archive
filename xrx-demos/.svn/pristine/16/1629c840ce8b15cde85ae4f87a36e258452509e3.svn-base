xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'AnyChart Demo Application'

let $content := 
<div class="content">
    <p>Welcome to the {$title}.</p>
    
    <h4>Unit Tests</h4>
    <a href="unit-tests/index.xq">List Unit Tests</a>
    <!--
      
     <h4>Dynamic Charts</h4>
      <a href="views/list-dynamic-charts.xq">List Dynamic Charts</a> A listing of dynamic charts.  Dynamic charts
      are charts that pull their data directly from a web service.<br/>
      
     <h4>Static Charts</h4>
        <a href="views/list-items.xq">List Static Charts</a> A listing of static charts.  These
        charts are used to define the presentation aspects of each chart but they do not
        pull any data from Oracle or Futrix.<br/>
        
        <a href="views/list-samples.xq">List Samples</a> A listing of sample charts that are designed
        to show the capabilities of the AnyChart application and to test special use cases.<br/>
      
    <h4>Data Quality checks</h4>
         A series of data quality checks to ensure consistency accross all charts.<br/>
         <a href="views/quality-checks.xq">Quality Checks</a> A listing of quality checks for each chart.<br/>
         
          <a href="views/time-series-checks.xq">Time Series Quality Checks</a> A listing of quality checks for time-series specific functions.<br/>
         
         <a href="views/list-charts-by-type.xq">List Charts By Type</a> A listing of all charts
         sorted by the chart type such as time-series charts, distribution charts or x-y charts.<br/>
         
         <a href="views/validate-time-series-charts.xq">Validate Time Series Charts</a> Use XML Schema to validate the
         structure of time-series charts.<br/>
         
    <h4>Distribution Analysis Over Time</h4>
      Tools to explore how the distributions of scores over time.  Most of these charts have a time-slider under the charts.<br/>
       <a href="dynamic/population-score-distribution.xq">Population</a> Browse population distributions vs time.<br/>
       <a href="dynamic/score-distribution-goods-and-bads.xq">Score Distribution Goods and Bads</a> Score distribtuion good and bads for each period of time.<br/>
      
    <h4>Unit Tests</h4>
      <a href="views/list-unit-tests.xq">List Unit Tests</a> A listing of unit tests.<br/>
      <a href="unit-tests/counts-tab-mockup.xq">Counts Tab Mockup</a> Four Charts on the Counts Tab.<br/>
      
      <a href="samples/series-show-hide.html">Show or Hide a Series</a> onditionally Show or Hide a Series<br/>
      
      <a href="unit-tests/range-series-select.xq">Range Series Select</a> Use a range control to select a chart data series.<br/>
      <a href="unit-tests/range-series-select2.xq">Range Series Select Two Charts</a> Use a range control to select a chart data series.<br/>
       <a href="unit-tests/validate-time-series-test-instance.xq">Validate Time Series Test File</a> Use a range control to select a chart data series.<br/>
      
    <h4>Metrics</h4>
      <a href="views/metrics.xq">Metrics</a><br/>
      <a href="views/all-element-names.xq">All Element Names</a> We use over 100 different elements to describe a chart.  This
      lists each of the elements and allows you to see a list of reports that use each element.
      
      <h4>AnyChart Bugs</h4>
      <a href="views/list-bugs.xq">List Bugs</a> Listing of bugs and known work-arounds.
      
      <h4>AnyChart Data Services</h4>
      These services pull data from production systems or cached versions of reports to fill in data services for charts.<br/>
      
      <a href="modules/list-anychart-module-functions.xq">List AnyChart Module Dynamic Chart Functions.</a> For each chart list the dynamic XML created by the AnyChart module.<br/>
      <a href="modules/list-data-module-functions.xq">List Data Module Functions.</a>List the dynamic data parts of the charts<br/>
      
      
      <h4>Dynamic SQL Charts</h4>
      <div
      class="notice">Note - these queries may put a small load on Oracle development servers but they are only intended to pull metadata
      and code tables from the development systems.  You must be on the Chase network to demo these charts.</div>
      <p>These charts dynamically pull data from actual Oracle Summary Tables</p>
      <a href="dynamic/applications-approved-booked.xq?model-id=384">Applications, Approved, Booked</a> Test chart for Counts tab with data
      from Oracle summary table.<br/>
      
      <a href="dynamic/booked-and-bads.xq?model-id=384">Booked and Bads</a> Test chart for Counts tab with data
      from Oracle summary table.<br/>
      <a href="views/view-dynamic-chart.xq?file=benchmark-counts.xq">Benchmark Counts</a><br/>
       
      This report returns row counts from all tables with the String "Bench" in the table name.<br/>
      <br/>
      -->
</div>

return 
    style:assemble-page($title, $content)
