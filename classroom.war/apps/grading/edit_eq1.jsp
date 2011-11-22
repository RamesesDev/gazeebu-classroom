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
				
				var self = this;
				this.entries = [];
				this.entry = {}
				this.listorder;
				
				this.save = function() {
					svc.saveGradingEq( {list:this.entries, listorder: this.listorder, removedItems: this.removedItems} );	
					this.saveHandler();
					return "_close";
				}
				
				this.removedItems = [];
				this.selectedItem;
				
				this.removeItem = function() {
					/*
					var o = this.entries[this.removeIndex];
					this.removedItems.push( o );
					this.entries.remove( this.removeIndex );
					*/
					alert("removing " + $.toJSON(this.selectedItem));
				}
				
				this.addItem = function() {
					var lorder = this.listorder;
					if(!this.listorder) {
						lorder = (this.entry.rangefrom == "100") ? "desc" : "asc"; 
					}
					if(lorder=="desc" && parseFloat(this.entry.rangefrom) <= parseFloat(this.entry.rangeto)) {
						alert("To value must be less than from value");
					}
					else if(lorder=="desc" && parseFloat(this.entry.rangeto) < 0 ) {
						alert("To value must not be lower than 0");
					}
					else if(lorder=="asc" && parseFloat(this.entry.rangefrom) >= parseFloat(this.entry.rangeto)) {
						alert("To value must be greater than from value");
					} 
					else if(lorder=="asc" && parseFloat(this.entry.rangeto) > 100 ) {
						alert("To value must be not be greater than 100");
					} 
					else {
						this.entries.push( this.entry );
						this.entry = { rangefrom: this.entry.rangeto };
						if(!this.listorder) this.listorder = lorder;
					}	
				}
				
				this.defaultStart = ["0","100"];
				this.onload = function() {
						
				}
				
			}
			
		);	
		
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_eq" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<label r:context="edit_eq">#{listorder}</label>
		<table r:context="edit_eq" r:items="entries" r:varName="item" r:name="selectedItem" width="300" border="1" cellpadding="2" cellspacing="0">
			<thead>
				<tr>
					<td colspan="2" valign="top"  align="center" width="120px">
						Range %	
					</td>
					<td style="font-weight:bolder;" rowspan="2" align="center">Eq. Grade</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td style="font-weight:bolder;" align="center">From (%)</td>
					<td style="font-weight:bolder;" align="center">To (%)</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center" width="60px">#{item.rangefrom}</td>
					<td align="center" width="60px">#{item.rangeto}</td>
					<td align="center" width="60px">#{item.title}</td>
					<td><a r:context="edit_eq" r:name="removeItem">Remove</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td align="center">
						<select r:context="edit_eq" r:name="entry.rangefrom" r:allowNull="true" r:items="defaultStart" style="width:50px;text-align:center;" r:visibleWhen="#{!listorder}" ></select> 
						<label r:context="edit_eq" r:visibleWhen="#{listorder}">#{entry.rangefrom}</label> 
					</td>
					<td align="center">
						<input type="text" r:context="edit_eq" r:name="entry.rangeto" style="width:50px;text-align:center;" /> 
					</td>
					<td align="center">
						<input type="text" r:context="edit_eq" r:name="entry.title" style="width:50px;text-align:center;" /> 
					</td>
					<td align="center">
						<a r:context="edit_eq" r:name="addItem">Add</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
