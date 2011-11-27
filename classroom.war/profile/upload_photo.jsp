<%@ page import="com.rameses.web.support.*" %>
<%@ page import="com.rameses.server.common.*" %>
<%@ page import="com.rameses.service.*" %>
<%@ page import="imagewebutil.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>

<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<c:if test="${!empty SESSIONID}">
	<s:invoke service="SessionService" method="getInfo" params="${SESSIONID}" var="SESSION_INFO"/>
</c:if>

<%
	Map sessInfo = (Map) request.getAttribute("SESSION_INFO");
	
	if("post".equals(request.getMethod().toLowerCase())) 
	{
		try {
			FileItem fi = (FileItem) request.getAttribute("FILE");
			String resUrl = application.getInitParameter("res-url");

			ImageUtil iu = new ImageUtil();
			String ext = "jpg";
			if( sessInfo == null ) throw new Exception("You are no longer logged in. Please re-login to perform this task.");
			
			String target = resUrl + "/profile/" + sessInfo.get("userid").hashCode();
			File dest = new File(new URL(target).toURI());
			if( !dest.exists() ) dest.mkdirs();
			
			//---- transfer image to the target directory -----
			fi.write( new File(dest, "orig") );
			iu.convertToJPG( dest.getPath()+"/orig", dest.getPath()+"/large."+ext);
			iu.createThumbnail( dest.getPath()+"/large."+ext, dest.getPath()+"/medium."+ext, ext, 160);
			iu.createThumbnail( dest.getPath()+"/large."+ext, dest.getPath()+"/thumbnail."+ext, ext, 50);
			
			//---- update user profile picture version -----
			Map env = new HashMap();
			env.put("sessionid", sessInfo.get("sessionid"));

			Map conf = new HashMap();
			conf.put("app.host", application.getInitParameter("app.host") );
			conf.put("app.context", application.getInitParameter("app.context") );
		
			ScriptServiceContext svc = new ScriptServiceContext(conf);
			ServiceProxy ac = (ServiceProxy) svc.create("UserProfileService", env );
			
			Map param = new HashMap();
			param.put("objid", sessInfo.get("userid"));
			Map usrprofile = (Map) ac.invoke("getInfo", new Object[]{param});
			Map info = (Map) usrprofile.get("info");
			if( info == null ) {
				usrprofile.put("info", (info = new HashMap()));
			}
			
			Integer v = (Integer) info.get("photoversion");
			if( v == null ) v = new Integer("0");
			try {
				info.put("photoversion", new Integer((v.intValue()+1)+""));
			}
			catch(Exception e) {
				info.put("photoversion", new Integer("1"));
			}
			
			ac.invoke("update", new Object[]{usrprofile});
			
			//--- this should also update the current session info's photoversion --
			
			out.write("null");
		}
		catch(Exception e) 
		{
			e.printStackTrace();
			out.write( e.getMessage() );
		}
	}
%>