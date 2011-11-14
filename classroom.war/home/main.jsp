<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	request.setAttribute("user", m );
%>
<s:invoke service="ClassService" method="getOpenClasses" params="${user}" var="CLASSES"/>

<t:content title="Home">

	<jsp:attribute name="script">
		$put("main", 
			new function() {
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:attribute name="rightpanel">
		Sponsored Ads
	</jsp:attribute>
	
	<jsp:attribute name="style">
		.classhead td {
			padding:4px;
			font-size: 12px;
		}
		.classhead .col {
			background-color: lightgrey;
			font-weight:bolder;
		}
	</jsp:attribute>
	
	<jsp:body>
		<c:if test="${empty CLASSES}">
			You have currently no active classes.
		</c:if>
		<c:if test="${!empty CLASSES}">
			Choose a class and click to enter<br><br>
			<table width="80%" cellpadding="0" cellspacing="0" class="classhead">
				<tr>
					<td width="150" class="col">Class Name</td>
					<td class="col">Description</td>
					<td class="col" colspan="2">Role</td>
				</tr>
			<c:forEach items="${CLASSES}" var="item">
				<tr>
					<td>
						<a href="classroom.jsp?classid=${item.objid}">${item.name}</a>
					</td>
					<td>${item.description}</td>
					<td>${item.usertype}</td>
					<td width="25">
						<c:if test="${item.userid == SESSION_INFO.userid and item.usertype == 'teacher' }">
							<a>Edit</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
		</c:if>
		
		
	</jsp:body>
	
</t:content>

