<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Grading Criteria">

   <jsp:attribute name="script">
		$register({id:"#entry", context:"grading_criteria"});
		$register({id:"#categories", context:"grading_criteria"});
		
		$put( "grading_criteria", 
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
			
				this._controller;
				this._caller;
				this.saveHandler;
				
				var self = this;
				this.entries = [];
				
				this.onload = function() {
					this.entries = svc.getList( {classid: "${param['classid']}"} );
				}
				this.editCriteria = function() {
					var saver = function(list) {
						svc.saveCriteria( list );	
						self._controller.reload();	
					}
					return new PopupOpener("#entry", {saveHandler: saver});
				}
				this.addCriteria = function() {
					this.entries.push({classid: "${param['classid']}" });
				}
				this.saveCriteria = function() {
					this.saveHandler(this.entries);
				}
				this.selected;
				
				this.selectedCategories;
				this.editCategories = function() {
					if(this.selected) {
						this.selectedCategories = svc.getCategories(this.selected.objid);
						return new PopupOpener("#categories");
					}
				}
				this.addCategory = function() {
					this.selectedCategories.push( {criteriaid: self.selected.objid} );	
				}
				this.saveCategory = function() {
					svc.saveCategories(this.selectedCategories);
					self._controller.reload();	
				}

			}
		);	
   </jsp:attribute>
   
   <jsp:attribute name="sections">
		<div id="entry" style="display:none">
			<table r:context="grading_criteria" r:items="entries" r:varName="item" r:varStatus="stat" border="1">
				<thead>
					<tr>
						<td>Title</td>
						<td>Weight</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" r:context="grading_criteria" r:name="entries[#{stat.index}].title"/></td>
						<td><input type="text" r:context="grading_criteria" r:name="entries[#{stat.index}].weight"/></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<a r:context="grading_criteria" r:name="addCriteria">Add More</a>
						</td>
					</tr>
				</tfoot>
			</table>	
			<input type="button" r:context="grading_criteria" r:name="saveCriteria" value="Save"/>
		</div>

		<div id="categories" style="display:none">
			<label r:context="grading_criteria">Category : #{selected.title}</label>
			<table r:context="grading_criteria" r:items="selectedCategories" r:varName="item" r:varStatus="stat" border="1">
				<thead>
					<tr>
						<td>Title</td>
						<td>Weight</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" r:context="grading_criteria" r:name="selectedCategories[#{stat.index}].title"/></td>
						<td><input type="text" r:context="grading_criteria" r:name="selectedCategories[#{stat.index}].weight"/></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<a r:context="grading_criteria" r:name="addCategory">Add More</a>
						</td>
					</tr>
				</tfoot>
			</table>	
			<input type="button" r:context="grading_criteria" r:name="saveCategory" value="Save"/>
		</div>
		
   </jsp:attribute>
   
   <jsp:body>
		Define the types of activities and their relative weight factors
		<a r:context="grading_criteria" r:name="editCriteria">Edit</a> 
		<table r:context="grading_criteria" r:items="entries" r:varName="item" r:name="selected">
			<thead>
				<tr>
					<td>Activity Type</td>
					<td>Weight</td>
					<td>&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{item.title}</td>
					<td>#{item.weight}</td>
					<td><a r:context="grading_criteria" r:name="editCategories">Category</a></td>
				</tr>
			</tbody>
		</table>
   </jsp:body>
   
</t:content>
