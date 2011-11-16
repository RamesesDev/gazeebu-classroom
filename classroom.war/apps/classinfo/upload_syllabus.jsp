<%@ page contentType="text/plain"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.rameses.invoker.client.*" %>
<%@ page import="com.rameses.server.common.*" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.io.*" %>


<%
	try {
		String filename = "";
		Map resp = new HashMap();
		if( "post".equals(request.getMethod().toLowerCase()) ) {
			FileItem fi = (FileItem) request.getAttribute("FILE");
			
			String objid = "SLB"+("FILE-" + new java.rmi.server.UID()).hashCode();
			resp.put("filename", fi.getName());
			resp.put("fileid", objid);
			
			File f = new File(System.getProperty("jboss.server.home.dir") + "/apps/classroom.war/apps/classinfo/uploads/" + objid);
			System.out.println( f );
			fi.write(f);
		}
		out.write( JsonUtil.toString( resp ) );
	}
	catch(Exception e) {
		e.printStackTrace();
		throw e;
	}
%>
