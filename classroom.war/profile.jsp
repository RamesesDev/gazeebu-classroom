<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured-master>

	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/profile/profile.css" type="text/css" rel="stylesheet" />
		<script>
			$register({id:"accountsettings", page:"profile/accountsettings.jsp", context:"accountsettings"});
			$register({id:"profilepicture", page:"profile/profilepicture.jsp", context:"profilepicture"});
			$register({id:"credits", page:"profile/credits.jsp", context:"credits"});
			$register({id:"userpage", page:"profile/userpage.jsp", context:"userpage"});
			$register({id:"mobilesettings", page:"profile/mobilesettings.jsp", context:"mobilesettings"});
			$register({id:'student_search', page:'student_search.jsp', context: 'student_search', title:'Search Student'});
			$register({id:"sharecredit", page:"profile/sharecredit.jsp", context:"sharecredit"});
			$register({id:"donate", page:"profile/donate.jsp", context:"donate"});
			$register({id:"buycredits", page:"profile/buycredits.jsp", context:"buycredits"});
			
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
		  <a href="#profilepicture">Profile Picture</a><br>
		  <a href="#credits">Credits</a><br>
		  <a href="#mobilesettings">Mobile Settings</a><br>
	   </div>
   </jsp:body>

</t:secured-master>
