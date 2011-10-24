<%@ page import="java.util.*;" %>

<%
	Enumeration en = request.getParameterNames();
	System.out.println("================ receiving response from paypal =====================");
	while( en.hasMoreElements() ) {
		Object key = en.nextElement();
		if( key == null ) continue;
		System.out.println( key +"="+ request.getParameter(key+"") );
	}
%>
