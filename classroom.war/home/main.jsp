<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:content title="Home">

	<jsp:attribute name="script">
		$put("main", 
			new function() {
			
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:body>
		<h1>Welcome to Gazeebu</h1>
		<c:if test="${SESSION_INFO.usertype=='teacher'}">
			<a href="#createclass">Click here to create a class</a> 
		</c:if>
	</jsp:body>
	
</t:content>

