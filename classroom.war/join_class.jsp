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
		$put("join_class",
			new function() {
				var svc = ProxyService.lookup( "ClassInvitationService" );
				this.keyword;
				var self = this;
				this.selected;
				this.data = { classes: [] }
				this._controller;
				this.search = function(txt) {
					return svc.findTeacherClass( {name:txt, classid: "${param['classid']}"} );
				}
				this.propertyChangeListener = {
					'selected' : function(o) {
						self.data.classes.push(o);
						self.keyword = "";
						self._controller.refresh();						
					}
				}
				this.classinfo;
				
				this.removeClass = function() {
					if(self.classinfo) {
						self.data.classes.removeAll( function(o) {  return o.objid == self.classinfo.objid }   );
						self._controller.refresh();						
					}
				}
				
				this.submit = function() {
					svc.sendRequestToJoin( this.data );
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
						<td valign="top" rowspan="3">
							<img src="${pageContext.request.contextPath}/profile/photo.jsp?id=#{teacherid}&t=thumbnail"/>
						</td>
						<td valign="top">
							#{name}
						</td>
					</tr>
					<tr>	
						<td valign="top">
							#{classname}
						</td>
					</tr>
					<tr>	
						<td valign="top" style="font-size:10px;">
							#{schedules}
						</td>
					</tr>
				</table>
			</a>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<table>
			<tr>
				<td align="right">Find class</td>
				<td>
				   <input type="text" r:context="join_class" r:name="keyword" 
				   r:suggest="search" r:suggestName="selected"
				   r:suggestExpression="#{name}"
				   r:suggestTemplate="suggest-tpl"
				   style="width:320px"/>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><i>Type in Lastname, firstname of teacher</i></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<table r:context="join_class" r:items="data.classes" r:varName="item" r:name="classinfo" width="50%">
						<tr>
							<td valign="top" rowspan="3" width="40">
								<img src="profile/photo.jsp?id=#{item.teacherid}&t=thumbnail"/>
							</td>
							<td valign="top">
								#{item.name}
							</td>
							<td valign="top" align="right" rowspan="3">
								<a r:context="join_class" r:name="removeClass" title="Remove">x</a>
							</td>
						</tr>
						<tr>	
							<td valign="top">
								#{item.classname}
							</td>
						</tr>
						<tr>	
							<td valign="top" style="font-size:10px;">
								#{item.schedules}
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top" align="right">Message</td>
				<td valign="top">
					<textarea r:context="join_class" r:name="data.msg" style="width:320px" />		
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
				<td>
					<input type="button" r:context="join_class" r:name="submit" value="Submit" />
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:popup>
