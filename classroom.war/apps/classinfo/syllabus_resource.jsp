<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.rameses.service.*" %>

<%   
	try {
		String fileid = request.getParameter("id");
		String type = request.getParameter("t");
		String filename = request.getParameter("fn");
		String content_type = request.getParameter("ct");
		
		String resUrl = application.getInitParameter("res-url");
		File dest = new File(new URL(resUrl).toURI());
		
		if( "vw".equals(type) ) {
			response.setHeader("Content-Disposition", "inline; filename=\"" + filename + "\"");
		}
		else if( "dl".equals(type) ) {
			response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
		}
		else if( "rm".equals(type) ) {
			Map env = new HashMap();
			String sessid = (String) request.getAttribute("SESSIONID");
			if( sessid == null || "".equals(sessid) )
				throw new Exception("Your session has expired.");
			
			env.put("sessionid", sessid);

			Map conf = new HashMap();
			conf.put("app.host", application.getInitParameter("app.host") );
			conf.put("app.context", application.getInitParameter("app.context") );
			
			ScriptServiceContext svc = new ScriptServiceContext(conf);
			ServiceProxy ac = (ServiceProxy) svc.create( "ClassService", env );
			
			Map cinfo = new HashMap();
			cinfo.put("objid", request.getParameter("objid"));
			cinfo = (Map) ac.invoke("read", new Object[]{cinfo});
			if( cinfo.get("info") != null ) {
				((Map) cinfo.get("info")).remove("syllabus");
				ac.invoke("update", new Object[]{cinfo});
			}
			
			//remove the file
			File f = new File(dest, "syllabus/" + fileid);
			if( f.exists() ) {
				f.delete();
			}
		}
		else {
			throw new Exception("Invalid download link.");
		}
		
		//-- serve resource
		File f = new File(dest, "syllabus/" + fileid);
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