<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Class Calendar">

   <jsp:attribute name="script">
		$register( {id:"newschedule", page:"classprofile/newschedule.jsp", title:"Build Schedule", context:"newschedule", options:{width:800, height:580} } );
		
		$put( "calendar", 
			new function() {
				this.objid;
				this.entity = {}
				
				this.addSchedule = function() {
					return new PopupOpener("newschedule");
				}
			}
		);	
   </jsp:attribute>
   
   <jsp:body>
		This class does not yet have a Calendar defined
		<input type="button" value="Add Calendar" r:context="calendar" r:name="addSchedule"/>
   </jsp:body>
   
</t:content>
