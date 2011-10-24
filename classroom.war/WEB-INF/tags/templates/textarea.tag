<%@ attribute name="id" %>
<%@ attribute name="context" %>
<%@ attribute name="hint" %>
<%@ attribute name="name" %>
<%@ attribute name="label" fragment="true" %>
<%@ attribute name="textareacontrols" fragment="true"%>

<script>
	function stretch(element) {
	  var h = element.scrollHeight + 30;
	  element.style.height = 38;
	  if(h > element.offsetHeight)
		  element.style.height = (element.scrollHeight+30) + 'px';
	}
   
	function startTyping( textarea ) {
	   textarea.style.height = 38+30;
	   document.getElementById("${id}_body").style.display = 'block';
	   document.getElementById("${id}_close").style.display = 'block';
	}
	
	function stopTyping( textarea, discard ) {
		textarea = textarea || document.getElementById("${id}_textarea");		
		if( textarea.value.length > 0 && !discard ) return;
		
		textarea.value = "";
		textarea.style.height = 30;
		document.getElementById("${id}_body").style.display = 'none';
		document.getElementById("${id}_close").style.display = 'none';
	}
</script>

<table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
   <tr>
      <td>
        <jsp:invoke fragment="label" />
      </td>
   </tr>
   <tr>
      <td colspan="2" valign="top">
		<div style="position: relative;border:1px solid #a5aa84;">
			<textarea r:hint="${hint}"
                      r:context="${context}"
                      r:name="${name}"
				      style="outline:none;resize:none;border:0;overflow:hidden;"
					  cols="80"
				      id="${id}_textarea"
                      onfocus="startTyping(this)"
                      onkeyup="stretch(this)"
                      onkeydown="stretch(this)">
			</textarea>
            <div style="height: 10px;width: 10px;cursor: pointer;position: absolute;right: 5px;margin: 1px;top: 5px;">
               <a id="${id}_close" href="#" class="close" onclick="stopTyping(null, true); return false;" style="display:none">X</a>
            </div>
            <div style="position: absolute;right: 4px;bottom: 4px;white-space: nowrap;">
               <jsp:invoke fragment="textareacontrols"/>
            </div>
         </div>
		 <div id="${id}_body" style="display:none">
			<jsp:doBody/>
		 </div>
      </td>
   </tr>
</table>
