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
		$put("message_form", 
			new function() 
			{
				this.saveHandler;
				this.entry = { resources:[], subscribers: [], viewoption:"0" };
				this._controller;
				this.viewoption = "0";
				
				var self = this;

				this.save = function() {
					if( this.viewoption == "2" && this.entry.subscribers.length==0) {
						throw new Error("Please add at least one topic member");
					}
					if( this.viewoption == "0" && this.entry.subscribers.length > 0) {
						this.entry.subscribers = [];
					}
					
					this.entry.privacy = parseInt(this.viewoption);
					if( this.saveHandler ) {
						this.saveHandler(this.entry);
					}
					return "_close";
				}
				
				this.selectMember = function() {
					var f = function(list) {
						for(var i=0; i<list.length;i++) {
							var e = list[i];
							self.entry.subscribers.push( {userid:e.objid, firstname:e.firstname, 
								lastname:e.lastname,photoversion:e.info.photoversion, usertype:e.usertype } );
						}
					}
					return new DropdownOpener("common:lookup_member", {selectHandler: f});
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
		<input type="button" r:context="message_form" r:name="save" value="Save"/>
	</jsp:attribute>

	<jsp:body>
		<div class="label">Subject</div>
		<div><input type="text" r:context="message_form" r:name="entry.subject" r:required="true" r:caption="Subject" style="width:450px"></div>
		<br>
		<div class="label">Message</div>
		<div>
			<div r:type="richtext" r:context="message_form" r:name="entry.message" r:required="true" r:caption="Message" 
				style="width:450px;height:150px;">
			</div>
		</div>
		<br>
		<div class="label">View Settings (who are allowed to view this discussion)</div>
		<label>
			<input type="radio" r:context="message_form" r:name="viewoption" value="0"/>
			Allow everybody in the class
		</label>
		<br>
		<label>
			<input type="radio" r:context="message_form" r:name="viewoption" value="2"/>
			Allow only members of this topic
		</label>
		<br>
		<br>
		<div r:context="message_form" r:visibleWhen="#{viewoption == '2'}" r:depends="viewoption">
			<a r:context="message_form" r:name="selectMember" r:immediate="true">Add Members</a>
			<br/>
			<ul  r:context="message_form" r:items="entry.subscribers" r:varName="item" r:name="selectedMember">
				<li style="list-style:none;float:left">
					<table>
						<tr>
							<td rowspan="2" valign="top">
								<img width="30px" src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{item.photoversion}">
							</td>
							<td>#{item.lastname}, #{item.firstname}</td>
							<td valign="top" align="right">
								<a r:context="message_form" r:name="removeMember" r:immediate="true">x</a>
							</td>
						</tr>
						<tr>
							<td><i>#{item.usertype}</i></td>
						</tr>
					</table>
				</li> 
			</ul>
		</div>
		
	</jsp:body>
	
</t:popup>


	