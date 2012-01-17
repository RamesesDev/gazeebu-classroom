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
		$put("new_topic", 
			new function() {
				this.saveHandler;
				this.parentid;
				this.entry = { resources:[], subscribers: [], viewoption:"0" };
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
					if( this.entry.viewoption == "1" && this.entry.subscribers.length==0) {
						throw new Error("Please add at least one topic member");
					}
					this.entry.parentid = this.parentid;
					this.saveHandler(this.entry);
					return "_close";
				}
				
				this.selectMember = function() {
					var f = function(list) {
						for(var i=0; i<list.length;i++) {
							var e = list[i];
							self.entry.subscribers.push( {objid:e.objid, firstname:e.firstname, 
								lastname:e.lastname,photoversion:e.info.photoversion, usertype:e.usertype } );
						}
					}
					return new DropdownOpener("classroom:lookup_member", {selectHandler: f});
				}
				this.selectedMember;
				this.removeMember = function() {
					if(this.selectedMember) {
						this.entry.subscribers.removeAll(
							function(o) {
								return o.objid == self.selectedMember.objid;
							}
						)
					}
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
		<button type="button" r:context="new_topic" r:name="save">Save</button>
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
		<div><input type="text" r:context="new_topic" r:name="entry.subject" r:required="true" r:caption="Subject" style="width:450px"></div>
		<br>
		<div class="label">Description</div>
		<div>
			<div r:type="richtext" r:context="new_topic" r:name="entry.description" r:required="true" r:caption="Description" 
				style="width:450px;height:150px;">
			</div>
		</div>
		<br>
		<div class="label">View Settings (who are allowed to view this discussion)</div>
		<input type="radio" r:context="new_topic" r:name="entry.viewoption" value="0"/>Allow everybody in the class<br>
		<input type="radio" r:context="new_topic" r:name="entry.viewoption" value="1"/>Allow only members of this topic<br>
		<br>
		<div class="label">Topic Members - <i>who are allowed to participate in the discussion</i></div>
		<a r:context="new_topic" r:name="selectMember" r:immediate="true">Add Members</a>
		
		<ul  r:context="new_topic" r:items="entry.subscribers" r:varName="item" r:name="selectedMember">
			<li style="list-style:none;float:left">
				<table>
					<tr>
						<td rowspan="2" valign="top">
							<img width="30px" src="profile/photo.jsp?id=#{item.objid}&t=thumbnail&v=#{item.photoversion}">
						</td>
						<td>#{item.lastname}, #{item.firstname}</td>
						<td valign="top" align="right">
							<a r:context="new_topic" r:name="removeMember" r:immediate="true">x</a>
						</td>
					</tr>
					<tr>
						<td><i>#{item.usertype}</i></td>
					</tr>
				</table>
			</li> 
		</ul>
		
	</jsp:body>
	
</t:popup>


	