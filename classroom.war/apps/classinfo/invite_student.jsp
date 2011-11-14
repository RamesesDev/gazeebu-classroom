<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<!--
<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
-->
<!--
<s:invoke service="ClassrecordService" method="getSummary" params="${params}" var="INFO"/>
-->

<t:popup>

	<jsp:attribute name="style">
		.button {
			border:1px solid lightgrey;
			font-weight:bolder;
			padding:5px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("invite_student",
			new function() {
				this.add = function() {
					alert('Adding students');
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="classinfo" r:name="add" value="OK" />
	</jsp:attribute>
	
	<jsp:body>
		Show Students here
	</jsp:body>
	
</t:popup>
