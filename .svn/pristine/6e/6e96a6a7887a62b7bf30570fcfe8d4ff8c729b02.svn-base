/**
 * stringUtil.js
 */
(function() {

    var HIGHLIGHTCLASSNAME = "highlight";
    
    _NARU.ui.getHighlightClassName = function() {
        return HIGHLIGHTCLASSNAME;
    }
    
    _NARU.ui.setHighlightClassName = function(highlightClassName) {
        HIGHLIGHTCLASSNAME = highlightClassName;
    }
    
    _NARU.ui.highlightTrByEvent = function(event) {
        if (window.event) {
            if (window.event.target.tagName.toUpperCase() == "TR")
                $(window.event.target).addClass(this.getHighlightClassName()).siblings().removeClass(this.getHighlightClassName());
            else if (window.event.target.tagName.toUpperCase() == "TD")
                $(window.event.target).parent("tr").addClass(this.getHighlightClassName()).siblings().removeClass(this.getHighlightClassName());
        }
    };
	
})();