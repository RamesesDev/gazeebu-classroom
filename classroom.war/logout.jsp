<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="LogoutService" method="logout" params="${SESSIONID}"/>
<%
	Cookie cookie = new Cookie( "sessionid", (String)request.getAttribute("SESSIONID") ) ;
	cookie.setMaxAge(0);
	response.addCookie( cookie );
%>

<t:index redirect_session="true">
	<table width="100%">
		<tr>
			<td valign="top">
				<div id="description">
					Thank you for using Gazeebu. <br>We'd love to hear from you. 
				</div>
				
			</td>
			<td valign="top" align="right" id="regcontainer">
				
			</td>
		</tr>
		<tr>
		   <td style="text-align:right;vertical-align:middle" colspan="2">
		      Check us out at: 
		      <div style="float:right;padding-right:5px;padding-left:5px;">
		      <a href="http://www.facebook.com/Gazeebu">
		         <img src="img/facebook.png"/>
		      </a>
		      </div>
		      <div style="float:right;padding-right:5px;padding-left:5px;">
		      <a href="http://www.twitter.com/Gazeebu">
		         <img src="img/twitter.png"/>
		      </a>
		      </div>
		   </td>
		</tr>
	</table>
</t:index>
