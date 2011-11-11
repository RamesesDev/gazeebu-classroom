<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>

   <jsp:attribute name="script">
		$put( "newschedule", 
			new function() {
				this.objid;
				this.entity = {days:[]}
				this.next = function() {
					var str = 'startdate='+this.entity.startdate;
					str+= '&enddate='+this.entity.enddate;
					return "choose-schedule?"+str;
				}
			},
			{
				"default" : "classprofile/newschedule_1.jsp",
				"choose-schedule" : "classprofile/newschedule_2.jsp"
			}
		);	
   </jsp:attribute>
   
   <jsp:attribute name="rightactions">
		<input type="button" r:context="newschedule" r:name="next" value="Next"/>	
   </jsp:attribute>
   
   <jsp:body>
		<div r:controller="newschedule"></div>
   </jsp:body>
   
</t:popup>
