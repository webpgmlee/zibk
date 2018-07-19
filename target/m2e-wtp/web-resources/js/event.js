/**
 * event.js
 */

	/**
	 * 뒤로가기 방지
	 */
   $(document).keydown(function(e){
       if(e.target.nodeName.toUpperCase() != "INPUT" && e.target.nodeName.toUpperCase() != "TEXTAREA"){
		   if(e.keyCode === 8){
		       return false;
		   }
       }
   });