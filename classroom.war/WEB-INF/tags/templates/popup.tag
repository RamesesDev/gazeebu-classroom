<%@ attribute name="leftactions" fragment="true" %>
<%@ attribute name="rightactions" fragment="true" %>

<%@ attribute name="head" fragment="true" %>
<%@ attribute name="script" fragment="true"%>
<%@ attribute name="style" fragment="true"%>

<c:if test="${! empty head}">
<jsp:invoke fragment="head"/>	
</c:if>

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


<table width="100%" height="100%">
	<tr>
		<td colspan="2" valign="top">
			<jsp:doBody/>
		</td>
	</tr>
	<tr>
		<td align="left" height="40" valign="top">
			<jsp:invoke fragment="leftactions"/>
		</td>
		<td align="right" height="40" valign="top">
			<jsp:invoke fragment="rightactions"/>
		</td>
	</tr>
</table>
