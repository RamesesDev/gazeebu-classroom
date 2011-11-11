<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Class Information">

   <jsp:attribute name="script">
		$put( "classinfo", 
			new function() {
				this.objid;
				this.entity = {}
			}
		);	
   </jsp:attribute>
   
   <jsp:body>
		There are no schedules yet set for this class
   </jsp:body>
   
</t:content>
