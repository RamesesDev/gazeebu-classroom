<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="head">	
		<link href="${pageContext.request.contextPath}/js/ext/richtext/richtext.css" rel="stylesheet"></link>
		<script src="${pageContext.request.contextPath}/js/ext/richtext/richtext.js"></script>
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id:"#add_resource", context:"resource"} );
		$put("new_thread", 
			new function() {
				this.saveHandler;
				this.entry = {classid: "${param['classid']}", resources:[] };
				this._controller;
				var self = this;
				this.addResource = function() {
					var f = function(o) {
						self.entry.resources.push(o);
						self._controller.refresh();
					}
					return new DropdownOpener("#add_resource", {handler: f}) ;
				}
				this.save = function() {
					this.saveHandler(this.entry);
					return "_close";
				}
			}
		);	
		$put( "resource",
			new function() {
				this.handler;
				this.resource = {};
				this.types = ["video", "link"];
				this.add = function() {
					this.handler( this.resource );
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
		<input type="button" r:context="new_thread" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="add_resource" style="display:none;">
			Title : <input type="text" r:context="resource" r:name="resource.title" r:required="true" r:caption="Resource Title"/><br>
			Link : <input type="text" r:context="resource" r:name="resource.link" r:required="true" r:caption="Resource Link"/><br>
			Type: <select r:context="resource" r:items="types" r:name="resource.type" ></select><br>
			<input type="button" r:context="resource" r:name="add" value="Add"/>
		</div>
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
		<br>
		<div class="label">References</div>
		<div>
			<table r:context="new_thread" r:items="entry.resources" r:varName="item" width="450px" cellpadding="1" cellspacing="0">
				<thead>
					<tr>
						<td class="colhead">Title</td>
						<td class="colhead">Type</td>
						<td class="colhead">Link</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>#{item.title}</td>
						<td>#{item.type}</td>
						<td>#{item.link}</td>
					</tr>
				</tbody>
				<tfoot>
					<td colspan="3">
					<a r:context="new_thread" r:name="addResource" r:immediate="true">Add Reference</a> 
					</td>
				</tfoot>
			</table>
		</div>
	</jsp:body>
	
</t:popup>


	