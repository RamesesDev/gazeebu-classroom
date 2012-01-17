<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="head">	
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id:"#add_resource", context:"resource"} );
		$put("new_thread", 
			new function() 
			{
				this.saveHandler;
				this.entry = {classid: "${param['classid']}"};
				var self = this;
				
				this.save = function() {
					this.saveHandler(this.entry);
					return "_close";
				}
			}
		);	
 	</jsp:attribute>

	<jsp:attribute name="style">
		.label {
			font-weight: bolder;
			font-size:12px;
		}
		.colhead {
			background-color: lightgrey;
			font-weight:bolder;
		}
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<button r:context="new_thread" r:name="save">Save</button>
	</jsp:attribute>
	
	<jsp:body>
		<div class="label">Subject</div>
		<div><input type="text" r:context="new_thread" r:name="entry.subject" r:required="true" r:caption="Subject" style="width:450px"></div>
		<br>
		<div class="label">Description</div>
		<div>
			<div r:type="richtext" r:context="new_thread" r:name="entry.description" r:required="true" r:caption="Description" 
				style="width:450px;height:250px;">
			</div>
		</div>
	</jsp:body>
	
</t:popup>


	