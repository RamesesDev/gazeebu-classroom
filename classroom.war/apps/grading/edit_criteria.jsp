<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getGradingCriteria" params="${params}" var="INFO"/>


<t:popup>
	<jsp:attribute name="script">
		$put( "edit_criteria",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this.entries = [];
				this.removedItems = [];
				this.saveHandler;
				this._controller;
				
				<c:forEach items="${INFO}" var="item">
				this.entries.push( {objid:"${item.objid}", classid:"${param['classid']}", title:"${item.title}", weight: ${item.weight}, colorcode:"${item.colorcode}"} );
				</c:forEach>
				
				this.save = function() {
					svc.saveCriteria( {list:this.entries, removedItems: this.removedItems } );	
					this.saveHandler();
					return "_close";
				}
				this.addItem = function() {
					this.entries.push({classid: "${param['classid']}" });
				}
				this.removeIndex;
				this.removeItem = function() {
					var o = this.entries[this.removeIndex];
					this.removedItems.push( o );
					this.entries.remove( this.removeIndex );
					this._controller.refresh();
				}
			}
			
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_criteria" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="edit_criteria" r:items="entries" r:varName="item" r:varStatus="stat" width="450">
			<thead>
				<tr>
					<td width="180px">Title</td>
					<td width="40px">Weight</td>
					<td width="100px" align="center">Color Code</td>
					<td align="center">&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" r:context="edit_criteria" r:name="entries[#{stat.index}].title" style="width:180px;"/></td>
					<td><input type="text" r:context="edit_criteria" r:name="entries[#{stat.index}].weight" style="width:40px;"/></td>
					<td align="center">
						<span r:type="colorpicker" r:context="edit_criteria" r:name="entries[#{stat.index}].colorcode"></span> 
					</td>
					<td align="center">
						<a r:context="edit_criteria" r:name="removeItem" r:params="{removeIndex:#{stat.index}}">Remove</a>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						<a r:context="edit_criteria" r:name="addItem">Add More</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
