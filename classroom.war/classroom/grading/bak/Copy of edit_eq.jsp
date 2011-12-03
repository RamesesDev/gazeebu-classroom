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
		$put( "edit_eq",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this.saveHandler;
				this.listorder = "${INFO.sortorder}";
				this._controller;
				this.listorders = ["ascending", "descending"];
				
				this.entries = [];
				<c:forEach items="${INFO.list}" var="item">
				this.entries.push( {objid:"${item.objid}", classid:"${param['classid']}", title:"${item.title}", score: ${item.toscore} } );
				</c:forEach>
				
				
				this.save = function() {
					svc.saveGradingEq( {list:this.entries, listorder: this.listorder, removedItems: this.removedItems} );	
					this.saveHandler();
					return "_close";
				}
				this.addItem = function() {
					this.entries.push({classid: "${param['classid']}" });
				}
				this.removedItems = [];
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
		<input type="button" r:context="edit_eq" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		Arrange raw scores in <select r:context="edit_eq" r:items="listorders" r:name="listorder"/> order.<br>
		<br>
		<p>Starting From
		<label r:context="edit_eq" r:visibleWhen="#{listorder=='ascending'}" r:depends="listorder">0</label>
		<label r:context="edit_eq" r:visibleWhen="#{listorder=='descending'}" r:depends="listorder">100</label>.
		Leave the last entry blank.
		</p>
		<br><br>				
		<table r:context="edit_eq" r:items="entries" r:varName="item" r:varStatus="stat" width="300">
			<thead>
				<tr>
					<td><b>Eq. Grade</b></td>
					<td>
						<b>
						<label r:context="edit_eq" r:visibleWhen="#{listorder=='ascending'}" r:depends="listorder">% less than or equal to</label>
						<label r:context="edit_eq" r:visibleWhen="#{listorder=='descending'}" r:depends="listorder">% greater than or equal to</label>
						</b>
					</td>
					<td>&nbsp;</td>
				</tr>
				
			</thead>
			<tbody>
				<tr>
					<td><input type="text" r:context="edit_eq" r:name="entries[#{stat.index}].title"/></td>
					<td><input type="text" r:context="edit_eq" r:name="entries[#{stat.index}].score"/></td>
					<td><a r:context="edit_eq" r:name="removeItem" r:params="{removeIndex:#{stat.index}}">Remove</a></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3">
						<a r:context="edit_eq" r:name="addItem">Add More</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
