<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured-master>

	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/profile.css" type="text/css" rel="stylesheet" />
		<script>
		    $register({id:"accountsettings", page:"profile/accountsettings.jsp", context:"accountsettings"});
			$register({id:"contactinformation", page:"profile/contactinformation.jsp", context:"contactinformation"});
			$register({id:"basicinformation", page:"profile/basicinformation.jsp", context:"basicinformation"});
			$register({id:"profilepicture", page:"profile/profilepicture.jsp", context:"profilepicture"});
			$register({id:"credits", page:"profile/credits.jsp", context:"credits"});
			$register({id:"userpage", page:"profile/userpage.jsp", context:"userpage"});
			$register({id:"mobilesettings", page:"profile/mobilesettings.jsp", context:"mobilesettings"});
			
			$put( "profile", 
				new function() {
					this.onload = function() {
						if( !window.location.hash ) {
							window.location.hash = "accountsettings";
						}
					}
				}
			);	
			
		</script>
	</jsp:attribute>

   <jsp:body>
	   <div class="inner-page-sidebar">
		  <a href="#accountsettings">General</a><br>
		  <a href="#basicinformation">Basic Information</a><br>
		  <a href="#contactinformation">Contact Information</a><br>
		  <a href="#profilepicture">Profile Picture</a><br>
		  <a href="#credits">Credits</a><br>
		  <a href="#mobilesettings">Mobile Settings</a><br>
	   </div>
   </jsp:body>

</t:secured-master>
