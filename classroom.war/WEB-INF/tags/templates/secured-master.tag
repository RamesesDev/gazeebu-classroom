<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<%@ attribute name="before_rendering" fragment="true" %>
<%@ attribute name="header_middle" fragment="true" %>
<%@ attribute name="script" fragment="true" %>
<%@ attribute name="style" fragment="true" %>
<%@ attribute name="head" fragment="true" %>
<%@ attribute name="pageTitle" fragment="false"%>
<%@ attribute name="sections" fragment="true"%>
<%@ attribute name="sidebar" fragment="true"%>
<%@ attribute name="content" fragment="true"%>


<t:secured pageTitle="${pageTitle}">

	<jsp:attribute name="before_rendering">
		<jsp:invoke fragment="before_rendering"/>
	</jsp:attribute>

	<jsp:attribute name="head">
		<jsp:invoke fragment="head"/>
	</jsp:attribute>	
	
	<jsp:attribute name="header_middle">
		<jsp:invoke fragment="header_middle"/>
	</jsp:attribute>	
	
	<jsp:attribute name="script">
		<jsp:invoke fragment="script"/>
	</jsp:attribute>	
	
	<jsp:attribute name="style">
		<jsp:invoke fragment="style"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<jsp:invoke fragment="sections"/>
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%" height="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top" width="1px" height="100%">
					<table id="leftpanel" width="180px" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<div class="leftnav scrollpane">
									<jsp:doBody/>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td valign="top" height="100%">
					<table class="shadowbox canvas" width="100%" height="550">
						<tr>
							<c:if test="${empty content}">
								<td id="content" class="content" height="100%" valign="top"></td>
							</c:if>
							<c:if test="${not empty content}">
								<td class="content" height="100%" valign="top">
									<jsp:invoke fragment="content"/>
								</td>
							</c:if>
						</tr>
					</table>
				</td>
				<c:if test="${not empty sidebar}">
					<td width="250" valign="top">
						<div class="sidebar-container">
							<div class="sidebar scrollpane">
								<jsp:invoke fragment="sidebar"/>
							</div>
						</div>
					</td>
				</c:if>
			</tr>
		</table>
	</jsp:body>

</t:secured>

