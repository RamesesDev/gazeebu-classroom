<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:popup>

	<jsp:attribute name="style">
	
	</jsp:attribute>

	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/datetime.js"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		$put("newtask",
			new function(){
				this.name = "hello";
				this.task = {servicetype:"script"}
				this.saveHandler;
				this.save = function() {
					this.saveHandler( this.task );
					return "_close";
				}
			}
		);
	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="newtask" r:name="save" value="Save" /> 
	</jsp:attribute>

	<jsp:body>
		Task ID: <input type="text" r:context="newtask" r:name="task.id" r:required="true" r:caption="ID"/><br>
		Description: <input type="text" r:context="newtask" r:name="task.description"/><br>
		<hr>
		Service: <input type="text" r:context="newtask" r:name="task.service" r:required="true" r:caption="Service name"/><br>
		Method: <input type="text" r:context="newtask" r:name="task.method" r:required="true" r:caption="Method"/><br>
		Service Type: <input type="text" r:context="newtask" r:name="task.servicetype" r:required="true" r:caption="Service Type"/><br>
		Parameters: <textarea r:context="newtask" r:name="task.parameters" r:required="true" r:caption="Parameters"></textarea><br>
		<hr>
		App Host: <input type="text" r:context="newtask" r:name="task.apphost" r:required="true" r:caption="App Host"/><br>
		App Context: <input type="text" r:context="newtask" r:name="task.appcontext" r:required="true" r:caption="App Context"/><br>
		Allowed Host: <input type="text" r:context="newtask" r:name="task.allowedhost" r:caption="Allowed Host"/><br>
		<hr>

		Start date: <span r:type="datetime" r:context="newtask" r:name="task.startdate" r:required="true" r:caption="Start Date"/><br>
		End date <span r:type="datetime" r:context="newtask" r:name="task.enddate" r:required="true" r:caption="End Date" r:options="{maxYear: (new Date()).getFullYear() + 3}"/><br>
		Interval: <input type="text" r:context="newtask" r:name="task.interval" r:required="true" r:caption="Interval"/><br>
	</jsp:body>
	
</t:popup>


