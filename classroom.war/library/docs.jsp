<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Documents">
   
	<jsp:attribute name="script">
		$register({id:"upload_doc_form",context:"upload_doc_form",page:"library/upload_doc_form.jsp", title:"Upload Document to Library", options: {height:400,width:500}}); 
		$put("docs", 
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.qry = {}
				this.add = function() {
					var h = function(o) {
						self.listModel.refresh(true);
					}
					return new PopupOpener( "upload_doc_form", {handler:h} );	
				}
				this.search = function() {
					alert('search');
				}
				this.selectedItem;
				
				this.listModel = {
					fetchList : function(o) {
						var m = {category : "doc"};
						return svc.getResources( m );
					}
				}
				
				this.removeIds = [];
				this.removeSelected = function() {
					if( this.removeIds.length >0 && confirm("Removing these files will affect all its link references. Continue?")) {
						svc.removeResources( this.removeIds );
						self.removeIds = [];
						self.listModel.refresh(true);
					}	
				}
			}
		);	
		
	</jsp:attribute>

	<jsp:attribute name="style">
		.colhead {
			background-color:lightgrey;
			font-weight:bolder;
		}
		.label {
			font-weight:bolder;
			font-size:12px;
		}
		.selector a {
			font-size:12px;
			font-weight:bolder;
		}
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input type=text r:context="docs" r:name="qry.search" r:hint="Type Search Keyword"/>
		<input type="button" r:context="docs" r:name="search"	value="Search"/>
		
	</jsp:attribute>
	
   <jsp:body>
		<input type="button" r:context="docs" r:name="add"	value="Add"/>
		<input type="button" r:context="docs" r:name="removeSelected" value="Remove"/>
		<br>
		<table r:context="docs" r:model="listModel" r:varName="item" r:name="selectedItem"
			width="100%" cellpadding="4" cellspacing="1" cellspacing="1">
			<thead>
				<tr>
					<td class="colhead" width="25">&nbsp;</td>
					<td class="colhead">Title</td>
					<td class="colhead">Description</td>
					<td class="colhead" width="80" align="center">size</td>
					<td class="colhead" width="80" align="center">Date</td>
					<td class="colhead">&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" r:context="docs" r:name="removeIds" r:mode="set" r:checkedValue="#{item.objid}"/></td>
					<td>#{!item.title ? '' : item.title}</td>
					<td>
						#{!item.description ? '' : item.description}
					</td>
					<td align="center">#{item.filesize}</td>
					<td align="center">#{item.dtfiled}</td>
					<td align="center">
						<a href="library/viewres.jsp?id=#{item.fileurl}&ct=#{item.content_type}" target="_blank">View</a> 
						&nbsp;
						<a href="library/downloadres.jsp?id=#{item.fileurl}&ct=#{item.content_type}" target="_blank">Download</a> 
					</td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
</t:content>

