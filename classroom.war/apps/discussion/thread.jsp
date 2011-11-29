<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("objid", request.getParameter("objid") );
	request.setAttribute( "params", m );
%>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_USER_INFO"/>
<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>
<s:invoke service="DiscussionService" method="openThread" params="${params}" var="DISCUSSION"/>

<t:content rightpanelwidth="40%" title="${DISCUSSION.subject}">

	<jsp:attribute name="contenthead">
		<a href="#discussion:discussion" style="font-size:9px;color:blue;"><< Back</a><br>
	</jsp:attribute>
	
	<jsp:attribute name="subtitle">
		<a style="font-size:11px;color:black;text-transform:none;">Posted on ${DISCUSSION.dtposted}</a>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put("thread", 
			new function() {
			}
		);	
 	</jsp:attribute>
	
	<jsp:attribute name="style">
		.label {
			font-weight:bold;
			font-size:12px;
		}
		#leftpanel1 {
			display:none;
		}
 	</jsp:attribute>

	<jsp:attribute name="actions">
		<c:set var="RES_PATH" value="${pageContext.servletContext.contextPath}/apps/classinfo/syllabus_resource.jsp"/>
		<c:set var="syllabus" value="${CLASS_INFO.info.syllabus}"/>
		<a href="${RES_PATH}?t=vw&id=${syllabus.fileid}&fn=${syllabus.filename}&ct=${syllabus.content_type}" target="_blank">
			View Syllabus
		</a>
 	</jsp:attribute>
	

	<jsp:body>
		<table width="100%" cellpadding="2" cellspacing="1">
			<tr>
				<td valign="top" align="left">
				
					<div  class="label">Description</div>
					<div>${DISCUSSION.description}</div> 	
					<br>
					<div class="label">References</div>
					<div>
						<table>
							<c:forEach items="${DISCUSSION.resources}" var="item" varStatus="status">
								<tr>
									<td style="padding-left:10px;">
										<c:if test="${item.type == 'video'}">
											<embed src="${item.link}" height="260" width="350"></embed> 
											<br>
											====
											${status.index+1}. ${item.title}
										</c:if>
										<c:if test="${item.type == 'link'}">
											${status.index+1}. <a href="javascript:window.open('${item.link}');">${item.title}</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</td>
				<td colspan="2" valign="top" width="50%">
					<div class="label">Topics (for discussion)</div>
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	