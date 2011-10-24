<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="testweb.*" %>

<%
   ImageUtil iu = new ImageUtil();
   if("post".equals(request.getMethod().toLowerCase())) {
      FileItem fi = (FileItem) request.getAttribute("FILE");
      
      String ext = "";
      Matcher m = Pattern.compile(".+\\.(.+)$").matcher(fi.getName());
      if( m.matches() ) ext = m.group(1);

      String objid = (new java.rmi.server.UID()+"").hashCode()+"."+ext;      
      String target = "/home/rameses/RAMESES-DEV/Servers/jboss-4.0.5.GA/server/etracs_org/apps/etracs.ear/etracs.war/photos/";

      fi.write( new File(target+objid) );
      iu.createThumbnail(target+objid, target+"thumbnail"+objid, ext);
      out.write("{url:'photos/thumbnail" + objid + "'}");
   }
%>
