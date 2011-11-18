<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:popup>

	<jsp:attribute name="style">

	</jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"add_award",
			new function() {
				this.userid;
				this.data = {userid:this.userid}
				this.submit = function() {
					alert("award " + $.toJSON(this.data) );
				}
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="add_award" r:name="submit" value="Submit"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<p>Choose an award</p>
		<br>
	</jsp:body>
	
</t:popup>

