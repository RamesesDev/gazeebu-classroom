<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="script">
		$register({id:"upload_doc",context:"upload_doc",page:"library/upload_doc.jsp", title:"Upload Document to Library", options: {height:400,width:500}}); 
		$put("add_resource", 	
			new function() {
				this.saveHandler;
				var self = this;
				this.parentid;
				this.resource =  {}
				this.linktypes = ["link", "embed", "library"];
				
				this.save = function() {
					this.resource.parentid = this.parentid;
					if(this.saveHandler) this.saveHandler(this.resource);
					return "_close";
				}
				
				this.uploadFile = function() {
					var h = function(o) {;}
					return new PopupOpener( "upload_doc", {handler:h} );		
				}
			}
		);	
 	</jsp:attribute>
	
	<jsp:attribute name="style">
		.label {
			font-weight:bolder;
		}
 	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="add_resource" r:name="save" value="OK"/>
	</jsp:attribute>
	
	<jsp:body>
		<div class="label">Add a Title</div>
		<input type="text"  r:context="add_resource" r:name="resource.title" style="width:300px" r:required="true" r:caption="Title"/>
		<br>
		<div class="label">Add a short description</div>
		<textarea  r:context="add_resource" r:name="resource.description" style="width:300px;height:50px;"></textarea>
		<br>
		
		<div class="label">Select a reference type</div>
		<select r:context="add_resource" r:items="linktypes" r:name="resource.linktype" r:allowNull="true" r:emptyText="-select reference type-"/>
		
		<div r:context="add_resource" r:depends="resource.linktype" r:visibleWhen="#{resource.linktype == 'link'}">
			<div class="label">Link Reference</div>
			<input type="text" r:context="add_resource" r:name="resource.link" r:required="true" style="width:300px;" r:caption="Link Reference"/>
		</div>
		
		<div r:context="add_resource" r:depends="resource.linktype" r:visibleWhen="#{resource.linktype == 'embed'}">
			<div class="label">Enter Embedded Code</div>
			<textarea r:context="add_resource" r:name="resource.link" r:required="true" style="width:300px;height:50px;"></textarea>
		</div>
		
		<div r:context="add_resource" r:depends="resource.linktype" r:visibleWhen="#{resource.linktype == 'library'}">
			<div class="label">Select from Library</div>
			<input type="button" r:context="add_resource" r:name="uploadFile" value="Upload" r:immediate="true" />  
		</div>	
		
	</jsp:body>
	
</t:popup>


	