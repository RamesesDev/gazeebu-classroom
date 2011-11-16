<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:popup>

	<jsp:attribute name="style">
		.edit_result td {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("edit_info",
			new function() 
			{
				this.classinfo;
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="edit_info" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table>
			<tr>
				<td valign="top" width="100">Name</td>
				<td><label r:context="edit_info">#{classinfo.name}</label></td>
			</tr>
			<tr>
				<td valign="top">Description</td>
				<td><label r:context="edit_info">#{classinfo.description}</label></td>
			</tr>				
		</table>
	</jsp:body>
	
</t:popup>


