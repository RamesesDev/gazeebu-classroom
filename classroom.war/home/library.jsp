<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>


<t:content title="Library">
	<jsp:attribute name="actions">
			
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id: "#tag", context:"tag" } );
		$register( {id: "#resource", context:"resource" } );
	
		$put("library", 
			new function() {
				this._controller;
				var svc = ProxyService.lookup( "LibraryService" );
				var self = this;
				
				this.selectedItem;
				this.listModel = {
					fetchList: function(o) {
						var m = {};
						if(self.selectedTag) m.tagid = self.selectedTag.objid;
						return svc.getResources(m);
					}
				}
				this.showResources = function() {
					this.listModel.refresh(true);
				}
				
				this.selectedTag;
				this.tags;
				
				this.onload = function() {
					this.tags = svc.getTags();
				}
				
				this.addTag = function() {
					var f = function(o) {
						svc.addTag(o);
						self._controller.refresh();
					}
					return new DropdownOpener( "#tag", {handler: f, tag: {} } );
				}
				
				this.addResource = function() {
					var f = function(o) {
						svc.addResource(o);
						self.listModel.refresh(true);
					}
					var res = { tags: [{objid: self.selectedTag.objid}] }
					return new DropdownOpener( "#resource", {handler: f, resource: res} );
				}
				
				
			}
		);	
		
		$put( "tag", 
			new function() {
				this.handler;
				this.tag;
				this.save = function() {
					this.handler(this.tag);
					return "_close";
				}
			}
		);	
		
		$put( "resource", 
			new function() {
				this.handler;
				this.resource;
				this.save = function() {
					this.handler(this.resource);
					return "_close";
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="tag" style="display:none;">
			Tag Title <input type="text" r:context="tag" r:name="tag.title" /><br> 
			<input type="button" r:context="tag" r:name="save" value="OK"/>
			<input type="button" r:context="tag" r:name="_close" value="Cancel"/>
		</div>
		
		<div id="resource" style="display:none;">
			Resource <input type="text" r:context="resource" r:name="resource.title" /><br> 
			<input type="button" r:context="resource" r:name="save" value="OK"/>
			<input type="button" r:context="resource" r:name="_close" value="Cancel"/>
		</div>

	</jsp:attribute>
	
	<jsp:body>
		<table width="90%" cellpadding="2" cellspacing="2">
			<tr>
				<td colspan="2">
					<input type="button" r:context="library" r:name="addTag" value="Add Tag"/>
					<input type="button" r:context="library" r:name="addResource" value="Add Resource"/>
				</td>
			</tr>
			<tr>
				<td valign="top" width="100">
					
					<!-- TAG SECTION -->
					<table r:context="library" r:items="tags" r:varName="tag" r:name="selectedTag" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td><a r:context="library" r:name="showResources">#{tag.title}</a></td>
						</tr>	
					</table>
					
				</td>
				<td valign="top">
					<table r:context="library" r:model="listModel" r:varName="item" r:name="selectedItem" border="1"
						cellpadding="0" cellspacing="0" width="100%">
						<thead>
							<tr>
								<td>Title</td>
								<td>Content Type</td>
								<td>Resource Name</td>
								<td>Resource Type</td>
								<td>Tags</td>
							</tr>	
						</thead>
						<tbody>
							<tr>
								<td>#{item.title}</td>
								<td>#{item.contenttype}</td>
								<td>#{item.resname}</td>
								<td>#{item.restype}</td>
								<td>#{item.tags}</td>
							</tr>	
						</tbody>
					</table>
				</td>
			</tr>
		</table>
	
	</jsp:body>
	
</t:content>

