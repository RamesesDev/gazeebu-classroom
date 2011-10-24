<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured-master>

   <jsp:attribute name="script">
      $register({id:"accountsettings", page:"profile/accountsettings.jsp", context:"accountsettings"});
      $register({id:"contactinformation", page:"profile/contactinformation.jsp", context:"contactinformation"});
      $register({id:"basicinformation", page:"profile/basicinformation.jsp", context:"basicinformation"});
      $register({id:"profilepicture", page:"profile/profilepicture.jsp", context:"profilepicture"});
      $register({id:"credits", page:"profile/credits.jsp", context:"credits"});
   </jsp:attribute>

   <jsp:body>
	   <div class="inner-page-sidebar">
		  <a href="#accountsettings">General</a><br>
		  <a href="#basicinformation">Basic Information</a><br>
		  <a href="#contactinformation">Contact Information</a><br>
		  <a href="#profilepicture">Profile Picture</a><br>
		  <a href="#credits">Credits</a><br>
	   </div>
   </jsp:body>

  </t:secured-master>
