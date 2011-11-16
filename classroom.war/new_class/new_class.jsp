<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:popup>
	<jsp:attribute name="script">
		$put(
			"new_class",
			new function() {
				this.saveHandler;
				var svc = ProxyService.lookup("ClassService");
				this.class = {}	
				this.editmode = "new";
				this._controller;
				this.save = function() {
					var o = svc.create( this.class );
					if(this.saveHandler) this.saveHandler();
					return "_close";
				}
			},
			{
				"default" : "new_class/page1.jsp",
				"page2" : "new_class/page2.jsp"
			}
		);
	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" value="Save" r:context="new_class" r:name="save"/>	
	</jsp:attribute>
	
	<jsp:body>
		<div r:controller="new_class"/>
	</jsp:body>	
</t:popup>	