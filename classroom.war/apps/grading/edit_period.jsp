<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getGradingPeriods" params="${params}" var="INFO"/>


<t:popup>
	<jsp:attribute name="script">
		$put( "edit_period",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this.saveHandler;
				this.removedItems = [];
				this.entries = [];
				this._controller;
				var self = this;
				<c:forEach items="${INFO}" var="item">
				this.entries.push( {objid:"${item.objid}", classid:"${param['classid']}", title:"${item.title}", fromdate:"${item.fromdate}", todate:"${item.todate}" } );
				</c:forEach>
				
				this.save = function() {
					svc.saveGradingPeriod( {list:this.entries, removedItems: this.removedItems} );	
					this.saveHandler();
					return "_close";
				}
				this.addItem = function() {
					this.entries.push({classid: "${param['classid']}" });
				}
				
				this.selectedItem;
				
				this.removeItem = function() {
					this.removedItems.push( this.selectedItem );
					this.entries.removeAll( function(o) { return o.objid ==self.selectedItem.objid} );
					this._controller.refresh();
				}
			}
			
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_period" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="edit_period" r:items="entries" r:varName="item" r:name="selectedItem" r:varStatus="stat">
			<thead>
				<tr>
					<td>Period</td>
					<td>From Date</td>
					<td>To Date</td>
					<td>&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" r:context="edit_period" r:name="entries[#{stat.index}].title"/></td>
					<td><input type="text" r:context="edit_period" r:name="entries[#{stat.index}].fromdate" r:datatype="date"/></td>
					<td><input type="text" r:context="edit_period" r:name="entries[#{stat.index}].todate" r:datatype="date"/></td>
					<td><a r:context="edit_period" r:name="removeItem">Remove</a></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<a r:context="edit_period" r:name="addItem">Add More</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
