<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="style">
		.button {
			border:1px solid lightgrey;
			font-weight:bolder;
			padding:5px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("invite_student",
			new function() {
				var svc = ProxyService.lookup( "ClassInvitationService" );
				this.keyword;
				var self = this;
				this.selected;
				this.data = { invitees: [] }
				this._controller;
				this.search = function(txt) {
					return svc.findStudents( {name:txt, classid: "${param['classid']}"} );
				}
				this.propertyChangeListener = {
					'selected' : function(o) {
						self.data.invitees.push(o);
						self.keyword = "";
						self._controller.refresh();						
					}
				}
				this.invitee;
				
				this.removeInvitee = function() {
					if(self.invitee) {
						self.data.invitees.removeAll( function(o) {  return o.objid == self.invitee.objid }   );
						self._controller.refresh();						
					}
				}
				
				this.submit = function() {
					this.data.classid = "${param['classid']}";
					svc.sendStudentInvitation( this.data );
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="suggest-tpl" style="display:none">
			<a href="#">
				<table>
					<tr>
						<td valign="top">
							<img src="#{!profile ? 'blank.jpg' : profile +  '/thumbnail.jpg'}"/>
						</td>
						<td valign="top">
							#{name}<br/>
							<span style="color:#aaa">#{name}</span>
						</td>
					</tr>
				</table>
			</a>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%">
			<tr>
				<td align="right">
					Add Invitee 
				</td>
				<td>
					 
					 <input type="text" r:context="invite_student" r:name="keyword" 
						   r:suggest="search" r:suggestName="selected"
						   r:suggestExpression="#{name}"
						   r:suggestTemplate="suggest-tpl"
						   style="width:350px"/>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td valign="top">
					<table r:context="invite_student" r:items="data.invitees" r:varName="item" r:name="invitee" width="40%">
						<tr>
							<td valign="top" width="50">
								<img src="#{!item.profile ? 'blank.jpg' : item.profile + '/thumbnail.jpg'}"/>
							</td>
							<td valign="top">#{item.name}</td>
							<td valign="top" align="right">
								<a r:context="invite_student" r:name="removeInvitee" style="border:1px solid lightgrey;" title="Remove Invite">x</a>
							</td>
						</tr>
					</table>				
				</td>
			</tr>
			<tr>
				<td valign="top" align="right">Message</td>
				<td valign="top">
					<textarea r:context="invite_student" r:name="data.msg" style="width:350px;" />		
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="button" r:context="invite_student" r:name="submit" value="Submit" />
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:popup>
