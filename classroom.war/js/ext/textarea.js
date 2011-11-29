BindingUtils.handlers.div_textarea = function( elem, controller, idx ) 
{
   var e = $(elem);
   var name = R.attr(e, 'name');
   var cols = R.attr(e, 'cols') || 30;
   var textarea;
   var controls;
   var close;
   
	var textarea = $(elem).data('_textarea');
	if( !textarea ) {	   
		init();
	}
	else {
		controls = e.data('_controls');
		close = e.data('_close');
	}

	var value = controller.get(name) || '';
	if( name ) textarea.val( value );
	
	if( value ) {
		textarea.trigger('focus');
	}
	else {
		close.trigger('click');
	}
	
	

	//helper
	function init() {
		if( e.children().length > 0 ) {
			controls = e.children().wrap('<div class="txt-controls"></div>').parent().hide();
		}
		
		var tpl = $('<table width="100%"><tr><td><textarea/></td><td valign="top" width="24px"><a href="#">x</a></td></tr></table>').prependTo(e);
		textarea = tpl.find('textarea')
		 .wrap('<div class="hint-wrapper" style="width:100%"></div>')
		 .css({
			width:'100%',outline:'none',
			resize:'none',display:'block',overflow:'auto'
		 });
		
		close = tpl.find('a')
		 .css('opacity',0)
		 .addClass('txt-close')
		 .css({display:'block',width:'24px',height:'24px','line-height':'24px','text-align':'center'})
		 .click(a_click);
		
		textarea
		 .focus(ta_focus)
		 .blur(ta_blur)
		 .change(update_bean)
		 .autoResizable({
			animate: true,
			animateDuration: 300,
			padding: 30,
			paste: true,
			pasteInterval: 100

		 });
		
		e.data('_textarea', textarea)
		 .data('_close', close)
		 .data('_controls', controls);
	}
	
	function ta_focus() {
		if( R.attr(elem, 'hint') && $(this).hasClass('input-hint') ) {
			$(this).val('').removeClass('input-hint');
		}
		$(this).height(50);
		close.stop().animate({opacity: 1},50);
		if( controls ) controls.show();
	}
	
	function ta_blur() {
		if( !this.value.trim() && !$(this).hasClass('input-hint') && R.attr(elem, 'hint') ) {
			$(this).val(R.attr(elem, 'hint')).addClass('input-hint');
		}
	}
	
	function a_click(){ 
		textarea.val('').trigger('change').height(20);
		if( R.attr(elem, 'hint') ) {
			textarea.val(R.attr(elem, 'hint')).addClass('input-hint');
		}
		$(this).stop().animate({opacity:0},50);
		if( controls ) controls.hide();
		return false; 
	}
	
	function update_bean() {
		if( name ) controller.set(name, this.value);
	}
};
