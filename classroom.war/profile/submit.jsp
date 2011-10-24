
<%@ page import="com.rameses.web.support.*" %>
<%@ page import="com.rameses.server.common.*" %>
<%@ page import="java.util.*" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<%
   if("post".equals(request.getMethod().toLowerCase())) {
	  Map param = new HashMap();
	  param.put("res-url", application.getInitParameter("res-url"));
	  param.put("fileitem", request.getAttribute("FILE"));
	  
	  request.setAttribute("PARAM", param);
%>
   <s:invoke service="ProfilePhotoService" method="savePhoto" params="${PARAM}" var="result" />
<%      
      Object o = request.getAttribute("result");
      Object e = request.getAttribute("error");
      if(e != null) {
         System.out.println("Error is " + e);
      }
      out.write(o==null ? "null" : JsonUtil.toString( o ));
   }
%>


