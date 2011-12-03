<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:popup>

	<jsp:attribute name="script">
		$put("edit_welcome",
			new function() 
			{
				this.handler;
				this.classinfo;
				
				this.onload = function() {
					if( !this.classinfo.info )
						this.classinfo.info = {};
				}
				
				this.save = function() {
					var svc = ProxyService.lookup('ClassService');
					svc.update(this.classinfo);
					if( this.handler ) this.handler();
					return '_close';
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="edit_welcome" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<div r:type="richtext" r:context="edit_welcome" r:name="classinfo.info.welcome_message" style="width:600px;height:400px;"></div>
	</jsp:body>
	
</t:popup>


