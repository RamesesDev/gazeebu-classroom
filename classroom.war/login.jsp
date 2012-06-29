<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%    
	Map map = new HashMap();
	map.put( "username", request.getParameter( "username" ) );
	map.put( "password", request.getParameter( "password" ) );
	request.setAttribute( "data", map );	
%>


<s:invoke service="LoginService" method="login" params="${data}" var="result" debug="true"/>
<c:if test="${empty error}">
	<c:set var="SESSIONID" value="${result.sessionid}" scope="request"/>
	<%
		Cookie cookie = new Cookie( "sessionid", (String)request.getAttribute("SESSIONID") ) ;
		response.addCookie( cookie );
		
		if( request.getParameter("u") != null )
			response.sendRedirect(request.getParameter("u"));
		else
			response.sendRedirect("home.jsp");
	%>
</c:if>

<c:if test="${!empty error}">
	<jsp:include page="reloginform.jsp" />
</c:if>



