<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
	
	<jsp:attribute name="style">
		.list th { background: #bbb; }
		.list tr.selected { background: #ddd; }
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register({id:"library:upload_doc_form", context:"upload_doc_form", page:"library/upload_doc_form.jsp", title:"Upload Document to Library", options: {height:400,width:500}});

		$put("res_lookup",
			new function() 
			{
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.categories = [{id:'doc',caption:'Documents'}];
				this.category = this.categories[0];
				
				this.selectedItem;
				this.handler;
				
				this.listModel = {
					fetchList: function(o) {
						var m = {category: self.category.id};
						return svc.getResources(m);
					}
				};
				
				this.select = function() {
					if(this.handler) this.handler(this.selectedItem);
					return '_close';
				}
				
				this.upload = function() {
					var h = function() {
						self.listModel.refresh(true);
					}
					return new PopupOpener("library:upload_doc_form",{handler: h});
				}
			}
		);	
	</jsp:attribute>

	<jsp:body>
		<select r:context="res_lookup" r:name="category" r:items="categories" r:itemLabel="caption">
		</select>
		<button type="button" r:context="res_lookup" r:name="upload">
			Upload Resource
		</button>
		<table r:context="res_lookup" r:model="listModel" r:varName="item" r:name="selectedItem"
			   class="list" cellpadding="4" cellspacing="1" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th align="left" width="100px">Title</th>
					<th align="left">Description</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{!item.title ? '' : item.title}</td>
					<td>
						#{!item.description ? '' : item.description}
					</td>
					<td>
						<a r:context="res_lookup" r:name="select">Select</a>
					</td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
	
</t:popup>

