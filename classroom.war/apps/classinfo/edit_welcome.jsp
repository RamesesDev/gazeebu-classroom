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
				this.classInfo;
				
				this.onload = function() {
					if( !this.classInfo.info )
						this.classInfo.info = {};
				}
				
				this.save = function() {
					var svc = ProxyService.lookup('ClassService');
					svc.update(this.classInfo);
					if( this.handler ) this.handler();
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_welcome" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<div r:type="richtext" r:context="edit_welcome" r:name="classInfo.info.welcome_message" style="width:600px;height:400px;"></div>
	</jsp:body>
	
</t:popup>


