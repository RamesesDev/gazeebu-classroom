<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/common" prefix="common" %>
<%@ tag import="com.rameses.web.support.*" %>
<%@ tag import="com.rameses.server.common.*" %>
<%@ tag import="java.util.*" %>

<%@ attribute name="context" %>
<%@ attribute name="caption" %>
<%@ attribute name="action" %>
<%@ attribute name="params" %>
<%@ attribute name="visibleWhen" rtexprvalue="true" type="java.lang.Object"%>


<c:if test="${visibleWhen != false}">
	<div class="post-message clearfix">
		<a r:context="${context}" r:name="${action}" r:params="${not empty params ? params : ''}">
			<span class="post-icon"></span>
			<span class="lbl">${not empty caption ? caption : 'Post a message'}</span>
		</a>
	</div>
</c:if>

