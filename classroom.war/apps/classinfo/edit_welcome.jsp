<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassrecordService" method="getActivityResult" params="${param['activityid']}" var="INFO"/>

<t:popup>

	<jsp:attribute name="script">
		$put("edit_welcome",
			new function() {
				
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_welcome" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<div r:type="richtext" r:context="edit_welcome" r:name="message" style="width:600px;height:400px;"></div>
	</jsp:body>
	
</t:popup>


