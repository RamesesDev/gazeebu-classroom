<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="head" fragment="true" %>

<%@ attribute name="script" fragment="true"%>
<%@ attribute name="style" fragment="true"%>

<%@ attribute name="header_middle" fragment="true" %>

<t:secured>

	<jsp:attribute name="before_rendering">
		<jsp:invoke fragment="before_rendering"/>
	</jsp:attribute>

	<jsp:attribute name="head">
		<jsp:invoke fragment="head"/>
		
		<c:if test="${! empty script}">
		<script>
			<jsp:invoke fragment="script"/>	
		</script>	
		</c:if>

		<c:if test="${! empty style}">
		<style>
			<jsp:invoke fragment="style"/>	
		</style>	
		</c:if>
		
	</jsp:attribute>
	
	<jsp:attribute name="header_middle">
		<jsp:invoke fragment="header_middle"/>
	</jsp:attribute>	
	
	<jsp:body>
		<table width="100%" height="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top" width="165" height="100%">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<jsp:doBody/>
							</td>
						</tr>
					</table>
				</td>
				<td valign="top" height="100%">
					<table class="shadowbox" width="100%" height="100%">
						<tr>
							<td id="content" height="100%" valign="top">&nbsp;</td> 
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</jsp:body>

</t:secured>

