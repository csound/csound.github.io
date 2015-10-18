/*----------------------------------------------------*/
/*  SCEditor
/*----------------------------------------------------*/

(function($){
	$(document).ready(function(){
		$(".WYSIWYG").sceditor({
			plugins: "bbcode",
			toolbar: "bold,italic,underline,center,right,justify,font,size,color,removeformat,bulletlist,orderedlist,table,quote,image,link,ltr,rtl,source",
			width: "100%"
		});

		function addIng() {
			var newElem = $('tr.ingredients-cont.ing:first').clone();
			newElem.find('input').val('');
			newElem.appendTo('table#ingredients-sort');
		}

	});
})(this.jQuery);