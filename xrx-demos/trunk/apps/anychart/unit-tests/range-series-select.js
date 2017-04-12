/* 
Read these pages:
http://anychart.com/products/anychart/docs/users-guide/livesamples/js-series/index.html 
http://www.anychart.com/products/anychart/docs/users-guide/JavaScriptEvents.html
*/

var myChart = new AnyChart("/rest/db/dma/resources/js/anychart/swf/AnyChart.swf");
/*
myChart.addEventListener('render', 'hideAllInit()');
myChart.addEventListener('draw', 'hideAllInit()');
*/

myChart.setXMLFile("./range-series-show-hide.xml");

myChart.width = 700; 
myChart.height = 500; 

myChart.write("my-chart");

function delayedHide() {
var t=setTimeout("hideAllInit()", 200);
};

function disable(id) {
 myChart.showSeries(id, false);
 myChart.refresh(); 
}; 

function enable(id) {
 myChart.showSeries(id, true);
 myChart.refresh(); 
};

function hideAll() {
    myChart.showSeries('review', false);
    myChart.showSeries('Jan-10', false);
    myChart.showSeries('Feb-10', false);
    myChart.showSeries('Mar-10', false);
    myChart.showSeries('Apr-10', false);
    myChart.showSeries('May-10', false);
    myChart.showSeries('Jun-10', false);
    myChart.showSeries('Jul-10', false);
    myChart.showSeries('Aug-10', false);
    myChart.showSeries('Sep-10', false);
    myChart.showSeries('Oct-10', false);
    myChart.showSeries('Nov-10', false);
    myChart.showSeries('Dec-10', false);
    myChart.refresh(); 
};

function onChartRender(e) {
    myChart.showSeries('review', true);
    myChart.showSeries('Jan-10', false);
    myChart.showSeries('Feb-10', false);
    myChart.showSeries('Mar-10', false);
    myChart.showSeries('Apr-10', false);
    myChart.showSeries('May-10', false);
    myChart.showSeries('Jun-10', false);
    myChart.showSeries('Jul-10', false);
    myChart.showSeries('Aug-10', false);
    myChart.showSeries('Sep-10', false);
    myChart.showSeries('Oct-10', false);
    myChart.showSeries('Nov-10', false);
    myChart.showSeries('Dec-10', false);
};

function onChartDraw(e) {
    myChart.showSeries('review', true);
    myChart.showSeries('Jan-10', false);
    myChart.showSeries('Feb-10', false);
    myChart.showSeries('Mar-10', false);
    myChart.showSeries('Apr-10', false);
    myChart.showSeries('May-10', false);
    myChart.showSeries('Jun-10', false);
    myChart.showSeries('Jul-10', false);
    myChart.showSeries('Aug-10', false);
    myChart.showSeries('Sep-10', false);
    myChart.showSeries('Oct-10', false);
    myChart.showSeries('Nov-10', false);
    myChart.showSeries('Dec-10', false);
};

function hideAllInit() {
    myChart.showSeries('review', true);
    myChart.showSeries('Jan-10', false);
    myChart.showSeries('Feb-10', false);
    myChart.showSeries('Mar-10', false);
    myChart.showSeries('Apr-10', false);
    myChart.showSeries('May-10', false);
    myChart.showSeries('Jun-10', false);
    myChart.showSeries('Jul-10', false);
    myChart.showSeries('Aug-10', false);
    myChart.showSeries('Sep-10', false);
    myChart.showSeries('Oct-10', false);
    myChart.showSeries('Nov-10', false);
    myChart.showSeries('Dec-10', false);
    myChart.refresh(); 
};

function showAll() {
    myChart.showSeries('review', true);
    myChart.showSeries('Jan-10', true);
    myChart.showSeries('Feb-10', true);
    myChart.showSeries('Mar-10', true);
    myChart.showSeries('Apr-10', true);
    myChart.showSeries('May-10', true);
    myChart.showSeries('Jun-10', true);
    myChart.showSeries('Jul-10', true);
    myChart.showSeries('Aug-10', true);
    myChart.showSeries('Sep-10', true);
    myChart.showSeries('Oct-10', true);
    myChart.showSeries('Nov-10', true);
    myChart.showSeries('Dec-10', true);
    myChart.refresh(); 
};
		  
$(function() {
	var mySelect = $( "#date-select" );
	
	var mySliderText = $( "#slider-text" );
	
	var mySlider = $( "#slider1" ).slider({
		min: 1,
		max: 12,
		slide: function( event, ui ) {
			mySelect[0].selectedIndex = ui.value - 1;
            hideAll();
			enable(myArray[ui.value - 1]);
			mySliderText.val(ui.value);
		}
	});
	
	$( "#date-select" ).change(function() {
		mySlider.slider( "value", this.selectedIndex + 1 );
		enable(myArray[this.selectedIndex]);
	});
	
});