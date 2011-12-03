<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getGradingEquivalents" params="${params}" var="INFO"/>


<t:popup>
	<jsp:attribute name="script">
		$register( {id:"#entry", context:"eq_entry"} );
		
		$put( "edit_eq",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this._controller;
				this.saveHandler;
				
				var self = this;
				this.entries = [];
				this.from;
				this.save = function() {
					svc.saveGradingEq( {list:this.entries, listorder: this.listorder, removedItems: this.removedItems} );	
					this.saveHandler();
					return "_close";
				}
				this.listModel = {
					fetchList: function(o) {
						return self.entries;
					}
				}
				
				
				this.removedItems = [];
				this.removeIndex;
				this.removeItem = function() {
					var o = this.entries[this.removeIndex];
					this.removedItems.push( o );
					this.entries.remove( this.removeIndex );
					this._controller.refresh();
				}
				
				this.addItem = function() {
					var saveHandler = function(o) {
						self.entries.push ( o );
						self.from = o.rangeto;
						self.listModel.refresh(false);
					}
					alert('about to paste self from ' + self.from);
					return new DropdownOpener("#entry", {saveHandler:saveHandler, from:self.from} );
				}
				
			}
			
		);	
		$put( "eq_entry", 
			new function() {
				this.saveHandler;
				this.entry = {}
				this.from;
				this._caller;
				this.defaultFrom = ["0","100"];
				this.saveItem = function() {
					this.entry.rangefrom = this._caller.from;
					alert( this_caller.from );
					this.saveHandler( this.entry );
					this.entry = {};
					return "_close";
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_eq" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div style="display:none;" id="entry">
			Grade Eq. <br><input type="text" r:context="eq_entry" r:name="entry.title" style="width:30px;"/><br>
			
			%Range from <br>
			<select r:context="eq_entry" r:name="from" r:items="defaultFrom" r:allowNull="true" r:visibleWhen="#{!from}"></select>
			<input type="text" r:context="eq_entry" r:name="from" style="width:30px;" />
			&nbsp;to&nbsp;
			<input type="text" r:context="eq_entry" r:name="entry.rangeto" style="width:30px;"/><br>
			<input type="button" r:context="eq_entry" r:name="saveItem" value="OK"/>
		</div>
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="edit_eq" r:model="listModel" r:varName="item" r:varStatus="stat" width="300">
			<thead>
				<tr>
					<td style="font-weight:bolder;">Eq. Grade</td>
					<td style="font-weight:bolder;">From (%)</td>
					<td style="font-weight:bolder;">To (%)</td>
				</tr>
				
			</thead>
			<tbody>
				<tr>
					<td>#{item.title}</td>
					<td>#{item.rangefrom}</td>
					<td>#{item.rangeto}</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3">
						<a r:context="edit_eq" r:name="addItem">Add More</a>
					</td>
				</tr>
			
				<tr>
					<td colspan="3">
						<a r:context="edit_eq" r:name="addItem">Add More</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
