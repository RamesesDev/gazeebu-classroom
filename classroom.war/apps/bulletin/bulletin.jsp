<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>

<t:content title="Bulletin Board" subtitle="Post announcements and important news">
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/textarea.js"></script>
	</jsp:attribute>
	<jsp:attribute name="style">
		.removeButton {
			font-size: 12px;
			font-weight:bold;
			color:lightgrey;
			text-decoration: none;
			padding-right:4px;
			padding-left:4px;
		}
		.removeButton:hover {
			color:white;
			background-color: red;
		}
		.bulletin_action {
			font-size:11px;
		}
		.inquireAction {
			color: lightgrey;
		}
		.inquireAction:hover {
			color:blue;
			font-weight:bold;
		}
		.actionbutton {
			border:1px solid lightgrey;
			font-family:verdana;
			padding:5px;
			font-weight:bold;
		}
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input type="button" r:context="bulletin" r:name="subscribeSMS" value="Subscribe SMS" class="actionbutton"/>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<c:if test="${CLASS_INFO.usertype == 'teacher'}">
			<input class="button" type="button" r:context="classroom" r:name="inviteStudents" value="Invite Students" />
			<br>
		</c:if>
	</jsp:attribute>
	
	<jsp:body>
		<cui:messagelist context="bulletin" canRemove="true" proxyService="BulletinService" usersIndex="$ctx('classroom').usersIndex"/>
	</jsp:body>
	
</t:content>

