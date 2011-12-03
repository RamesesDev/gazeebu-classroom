<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.rameses.service.*" %>

<%
	try {
		String fileid = request.getParameter("id");
		String resUrl = System.getProperty( "gazeebu.library.url" );
		String content_type = request.getParameter("ct");
		
		File dest = new File(new URL(resUrl+"/"+fileid).toURI());
		System.out.println( dest );
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileid + "\"");
		
		//attachment or inline
		
		//-- serve resource
		File f = dest;
		if( !f.exists() ) {
			throw new Exception("Invalid download link. The requested file no longer exists.");
		}

		response.addHeader("Cache-Control", "max-age=86400");
		response.addHeader("Cache-Control", "public");
		response.setContentType(content_type);

		Writer w = response.getWriter();
		InputStream is = null;
		
		try {
			is = new BufferedInputStream(new FileInputStream(f));
			int i = -1;
			while( (i=is.read()) != -1 ) w.write(i);
		}
		catch(Exception e) {
			if( is != null ) try{ is.close(); }catch(Exception ign){;}
		}
	}
	catch(Exception e) {
		out.write(e.getMessage());
	}	
%>