<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="INFO"/>

<t:content title="Class Profile">

	<jsp:attribute name="style">
		.sectiontitle {
			font-size:14px;
			font-weight:bold;
			padding:5px;
		}
		.section {
			background-color: lightgrey;		
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register( {id:"invite_student", page:"apps/classinfo/invite_student.jsp", context:"invite_student", title:"Invite Students", options: {width:500,height:400} } )
		$put("classinfo",
			new function() {
				this.inviteStudents = function() {
					return new PopupOpener("invite_student");
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input class="button" type="button" r:context="classinfo" r:name="inviteStudents" value="Invite Students" />
	</jsp:attribute>
	
	<jsp:body>
		<table width="80%">
			<tr>
				<td colspan="2" class="sectiontitle section">Class Information</td>
			</tr>
			<tr>
				<td valign="top">Name</td>
				<td>${INFO.name}</td>
			</tr>
			<tr>
				<td valign="top">Description</td>
				<td>${INFO.description}</td>
			</tr>
			
		</table>
	</jsp:body>
	
</t:content>
