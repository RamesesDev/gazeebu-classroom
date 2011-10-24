<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<c:if test="${empty param['classid'] and !empty SESSIONID}">
	<s:invoke service="ClassService" method="getDefaultClassId" var="CLASS_ID"/>
	<c:if test="${!empty CLASS_ID}">
		<c:set var="REDIRECT" value="home.jsp?classid=${CLASS_ID}#bulletin:bulletin" scope="request"/>
	</c:if>
	<c:if test="${empty CLASS_ID}">
		<c:set var="REDIRECT" value="home.jsp?classid=none#bulletin:bulletin"  scope="request"/>
	</c:if>
	<%response.sendRedirect( (String)request.getAttribute("REDIRECT") );%>
</c:if>
