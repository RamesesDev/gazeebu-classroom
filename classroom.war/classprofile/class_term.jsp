<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Class Term">

   <jsp:attribute name="script">
		$register({id:"#class_term_form", context:"class_term"});
		$put( "class_term", 
			new function() {
				var svc = ProxyService.lookup( "ClassTermService" );
			
				this.entity = {classid: "${param['classid']}"};
				this._controller;
				this.saveHandler;
				
				var self = this;
				this.entries = [];
				
				this.onload = function() {
					this.entries = svc.getList( {classid: "${param['classid']}"} );
				}
				this.addType = function() {
					var saver = function(o) {
						svc.create( o );	
						self._controller.reload();	
					}
					return new PopupOpener("#class_term_form", {saveHandler: saver});
				}
				this.save = function() {
					this.saveHandler(this.entity);
					return "_close";
				}
			}
		);	
   </jsp:attribute>
   
   <jsp:attribute name="sections">
		<div id="class_term_form" style="display:none">
			Term <input type="text" r:context="class_term" r:name="entity.term" r:caption="Term" r:required="true"/><br>
			From Date <input type="text" r:datatype="date" r:context="class_term" r:name="entity.fromdate" r:caption="From Date" r:required="true"/><br>			
			To Date <input type="text" r:datatype="date" r:context="class_term" r:name="entity.todate" r:caption="To Date" r:required="true"/><br>			
			<input type="button" r:context="class_term" r:name="save" value="Save"/>
		</div>
   </jsp:attribute>
   
   <jsp:body>
		Define the types of activities and their relative weight factors
		<a r:context="class_term" r:name="addType">Add Type</a> 
		<table r:context="class_term" r:items="entries" r:varName="item" cellpadding="2" cellspacing="2" border="1">
			<thead>
				<tr>
					<td>Term</td>
					<td>From Date</td>
					<td>To Date</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{item.term}</td>
					<td>#{item.fromdate}</td>
					<td>#{item.todate}</td>
				</tr>
			</tbody>
		</table>
   </jsp:body>
   
</t:content>
