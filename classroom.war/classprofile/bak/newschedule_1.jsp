<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
	<jsp:body>
		<div>Fill in the following info:</div>
		<div>Start Date:</div>
		<input type=text r:context="newschedule" r:name="entity.startdate" r:datatype="date"/>
		<br>
		<div>End Date:</div>
		<input type=text r:context="newschedule" r:name="entity.enddate" r:datatype="date"/>
		
		<br>
		Days<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="0"/>Sun<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="1"/>Mon<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="2"/>Tue<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="3"/>Wed<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="4"/>Thu<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="5"/>Fri<br>
		<input type="checkbox" r:context="newschedule" r:name="entity.days" r:mode="set" r:checkedValue="6"/>Sat<br>
	</jsp:body>
</t:popup>
