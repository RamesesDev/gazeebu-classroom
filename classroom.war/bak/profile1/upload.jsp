<%@ page contentType="text/plain"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.rameses.invoker.client.*" %>
<%@ page import="com.rameses.web.support.*" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.io.*" %>


<%    
    String filename = "";
    Map resp = new HashMap();
    if( "post".equals(request.getMethod().toLowerCase()) ) {
        FileItem fi = (FileItem) request.getAttribute("FILE");
		
		String objid = "FILE-" + new java.rmi.server.UID();
        resp.put("objid", objid);
        resp.put("filename", fi.getName());
		
		File f = new File(System.getProperty("jboss.server.home.dir") + "/apps/classroom.war/photos/" + objid.hashCode());
		System.out.println( f );
		fi.write(f);
		resp.put("url", "photos/" + objid.hashCode());
    }
    out.write( JsonUtil.toString( resp ) );
%>
