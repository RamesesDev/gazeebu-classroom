<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ attribute name="id" %>
<%@ attribute name="context" %>
<%@ attribute name="hint" %>
<%@ attribute name="name" %>
<%@ attribute name="label" fragment="true" %>
<%@ attribute name="leftcontrols" fragment="true"%>
<%@ attribute name="rightcontrols" fragment="true"%>

<script>	
	$(function(){
		if( !$.fn.autoResize ) {
			alert('jQuery autoResize plugin is required in order to use this textarea tag.');
		}
		else {
			$('#${id}_textarea').autoResize(
			{
				onResize : function() {
					$(this).css({opacity:0.8});
				},
				animateCallback : function() {
					$(this).css({opacity:1});
				},
				animateDuration : 100
			});
		}
	});
   
	function startTyping( textarea ) {
		var ta = $(textarea);
		var h = ta.data('orig_height');
		if( !h ) {
			h = ta.height();
			ta.data('orig_height', h);
		}
		ta.stop().animate({height: h*2});
		$('#${id}_close').show();
		$('#${id}_controls').show();
		$('#${id}_body').show('slide', {direction: 'up'});
	}
	
	function stopTyping( elm ) {
		var ta = $(elm).parents('.textarea-tag:first').find('textarea:last');
		ta.val('').trigger('change');;
		if( ta.data('orig_height') ) ta.stop().animate({height: ta.data('orig_height')});
		$('#${id}_close').hide();
		$('#${id}_controls').hide();
		$('#${id}_body').hide('slide', {direction: 'up'});
	}
</script>

<div class="textarea-tag page-form-table">
	<div class="box">
		<div class="box-inner">
			<div class="hint-wrapper" style="width:100%">
				<span class="hint"></span>
				<textarea r:context="${context}"
						  r:name="${name}"
						  r:hint="${hint}"
						  id="${id}_textarea"
						  onfocus="startTyping(this)"
						  style="height:24px;width:90%;outline:none;resize:none;border:0;overflow:hidden;">
				</textarea>
			</div>
			<div id="${id}_close" class="close-box" style="display:none">
			   <a href="#" class="close" onclick="stopTyping(this); return false;" title="Cancel"></a>
			</div>
			<c:if test="${!empty leftcontrols or !empty rightcontrols}">
				<div id="${id}_controls" class="controls" style="display:none">
					<div class="controls-inner">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="left">
									<jsp:invoke fragment="leftcontrols"/>
								</td>
								<td align="right">
									<jsp:invoke fragment="rightcontrols"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div id="${id}_body" style="display:none">
		<jsp:doBody/>
	</div>
</div>
