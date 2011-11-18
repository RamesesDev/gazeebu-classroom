<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured-master>

	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/profile/profile.css" type="text/css" rel="stylesheet" />
		<style>
			.form-panel .section {
				overflow: hidden;
				background-color: lightgrey;		
				margin-bottom: 10px;
				padding:5px;
			}
			.form-panel .section .controls {
				display: inline-block;
				float: right;
			}
			.form-panel .sectiontitle {
				display: inline-block;
				font-size:14px;
				font-weight:bold;
			}
			
			.form-panel { width: 80%; }
			.form-panel table { margin-left: 20px; }
		</style>
		<script>
			$register({id:"personal", page:"profile/personal.jsp", context:"personal"});
			$register({id:"account", page:"profile/account.jsp", context:"account"});
			$register({id:"contact", page:"profile/contact.jsp", context:"contact"});
			$register({id:"profilepicture", page:"profile/profilepicture.jsp", context:"profilepicture"});
			$register({id:"credits", page:"profile/credits.jsp", context:"credits"});
			$register({id:"userpage", page:"profile/userpage.jsp", context:"userpage"});
			$register({id:"mobilesettings", page:"profile/mobilesettings.jsp", context:"mobilesettings"});
			$register({id:'student_search', page:'student_search.jsp', context: 'student_search', title:'Search Student'});
			$register({id:"sharecredit", page:"profile/sharecredit.jsp", context:"sharecredit"});
			$register({id:"donate", page:"profile/donate.jsp", context:"donate"});
			$register({id:"buycredits", page:"profile/buycredits.jsp", context:"buycredits"});
			$register({id:"editmobile", page:"profile/editmobile.jsp", context:"editmobile"});
			
			$put( "profile", 
				new function() {
					this.onload = function() {
						if( !window.location.hash ) {
							window.location.hash = "personal";
						}
					}
				}
			);	
			
		</script>
	</jsp:attribute>

   <jsp:body>
	   <div class="inner-page-sidebar">
		  <a href="#personal">General Information</a><br>
		  <a href="#account">Account Settings</a><br>
		  <a href="#contact">Contact Settings</a><br>
		  <a href="#profilepicture">Profile Picture</a><br>
		  <a href="#credits">Credits</a><br>
		  <a href="#mobilesettings">Mobile Settings</a><br>
	   </div>
   </jsp:body>

</t:secured-master>
