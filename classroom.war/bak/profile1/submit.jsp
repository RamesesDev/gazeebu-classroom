<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="testweb.*" %>
<%@ page import="testweb.*" %>

<%
   ImageUtil iu = new ImageUtil();
   if("post".equals(request.getMethod().toLowerCase())) {
      FileItem fi = (FileItem) request.getAttribute("FILE");
      
      String ext = "";
      Matcher m = Pattern.compile(".+\\.(.+)$").matcher(fi.getName());
      if( m.matches() ) ext = m.group(1);

      System.out.println("" + ext);
      
      //change the line next to this.. that line is for the OBJID of the student/teacher
      String objid = "TCH74a18681:131daf6cf9f:-7ffe".hashCode()+"";
      
      String target = "/home/rameses/RAMESES-DEV/Servers/jboss-4.0.5.GA/server/gazeebu/apps/classroom.war/photos/" + objid + "/";

      File folder = new File(target);
      boolean exist = folder.mkdir();
      
      fi.write( new File(target+"original."+ext));
      iu.createThumbnail( target+"original."+ext, target+"medium."+ext, ext, 160);
      iu.createThumbnail( target+"original."+ext, target+"small."+ext, ext, 50);
      
      out.write("{url:'photos/" + objid + "/medium." + ext + "', ext:'" + ext + "'}");
   }
%>
