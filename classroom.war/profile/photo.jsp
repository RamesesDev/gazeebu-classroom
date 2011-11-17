<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.rameses.service.*" %>

<%   
	try {
		String userid = request.getParameter("id");
		String type = request.getParameter("t");
		
		String resUrl = application.getInitParameter("res-url");
		String target = resUrl + "/profile/" + userid.hashCode() + "/" + type + ".jpg";
		File f = new File(new URL(target).toURI());
		
		if( !f.exists() ) {
			target = resUrl + "/profile/blank.jpg";
			f = new File(new URL(target).toURI());
		}

		response.addHeader("Cache-Control", "max-age=86400");
		response.addHeader("Cache-Control", "public");
		response.setContentType("image/jpg");
		
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
		//out.write(e.getMessage());
	}	
%>