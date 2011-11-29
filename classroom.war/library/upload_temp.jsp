<%@ page contentType="text/plain"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.rameses.invoker.client.*" %>
<%@ page import="com.rameses.server.common.*" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>

<%
	try {
		String filename = "";
		Map resp = new HashMap();
		if( "post".equals(request.getMethod().toLowerCase()) ) {
			String resUrl = System.getProperty("gazeebu.temp.url");
			FileItem fi = (FileItem) request.getAttribute("FILE");
			
			String objid = "TEMP_"+("FILE-" + new java.rmi.server.UID()).hashCode();
			resp.put("filename", fi.getName());
			resp.put("fileid", objid);
			resp.put("content_type", fi.getContentType());
			resp.put("filesize", new Long(fi.getSize()));
			try {
				String ext = fi.getName().substring( fi.getName().lastIndexOf(".") );
				resp.put("ext", ext);	
			}
			catch(Exception ign){;}
			
			File dest = new File(new URL(resUrl).toURI());
			File f = new File(dest, objid);
			if( !f.getParentFile().exists() ) f.getParentFile().mkdirs();
			fi.write(f);
		}
		out.write( JsonUtil.toString( resp ) );
	}
	catch(Exception e) {
		e.printStackTrace();
		throw e;
	}
%>

