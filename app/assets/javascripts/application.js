// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
var dragSrcEl = null;

function handleDragStart(e) {
	console.log("test")
	dragSrcEl = this;
	e.dataTransfer.effectAllowed = 'move';
	e.dataTransfer.setData('t', $(this).clone().wrap('<div></div>').parent().html());
}

function handleDragOver(e) {
	if (e.preventDefault) {
		e.preventDefault(); 
	}

  	e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.

  	return false;
  }

  function handleDrop(e) {

  	if (e.stopPropagation) {
  		e.stopPropagation(); 
  	}

  	if (dragSrcEl != this) {
  		$(this).before(e.dataTransfer.getData('t'));
  		
  		dragSrcEl.remove();
  		var cols = document.querySelectorAll('.drag');
  		[].forEach.call(cols, function(col) {
  			drag(col);
  		});
  	}

  	return false;
  }
  function drag(col){
  	col.addEventListener('dragstart', handleDragStart, false);
  	col.addEventListener('dragover', handleDragOver, false);
  	col.addEventListener('drop', handleDrop, false);
  }

  var cols = document.querySelectorAll('.drag');
  [].forEach.call(cols, function(col) {
  	drag(col);
  });