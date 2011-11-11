<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getList" params="${params}" var="INFO"/>


<t:popup>
	<jsp:attribute name="script">
		$put( "edit_grading_criteria",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this._caller;
				this.entries;
				
				this.entries = [];
				<c:forEach items="${INFO}" var="item">
				this.entries.push( {objid:"${item.objid}", classid:"${param['classid']}", title:"${item.title}", weight: ${item.weight}, colorcode:"${item.colorcode}"} );
				</c:forEach>
				
				this.saveCriteria = function() {
					svc.saveCriteria( {list:this.entries} );	
					this.saveHandler(this.entries);
					return "_close";
				}
				this.addItem = function() {
					this.entries.push({classid: "${param['classid']}" });
				}

			}
			
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_grading_criteria" r:name="saveCriteria" value="Save"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
	
					$register({id:"#categories", context:"grading_criteria"});

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
		<table r:context="edit_grading_criteria" r:items="entries" r:varName="item" r:varStatus="stat">
			<thead>
				<tr>
					<td>Title</td>
					<td>Weight</td>
					<td>Color Code</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" r:context="edit_grading_criteria" r:name="entries[#{stat.index}].title"/></td>
					<td><input type="text" r:context="edit_grading_criteria" r:name="entries[#{stat.index}].weight"/></td>
					<td><input type="text" r:context="edit_grading_criteria" r:name="entries[#{stat.index}].colorcode"/></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<a r:context="edit_grading_criteria" r:name="addItem">Add More</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</jsp:body>
   
</t:popup>
