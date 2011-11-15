<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassrecordService" method="getActivityResult" params="${param['activityid']}" var="INFO"/>

<t:popup>

	<jsp:attribute name="style">
		.edit_result td {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("edit_info",
			new function() {
				
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_info" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table>
			<tr>
				<td valign="top" width="100">Name</td>
				<td>${INFO.name}</td>
			</tr>
			<tr>
				<td valign="top">Description</td>
				<td>${INFO.description}</td>
			</tr>			
		</table>
		<br/>
	</jsp:body>
	
</t:popup>


