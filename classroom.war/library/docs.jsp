<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Documents">

   
	<jsp:attribute name="script">
		$register({id:"#add-file",context:"add-file", title:"Upload Document", options: {height:400,width:500}}); 
		$put("docs", 
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.qry = {}
				this.add = function() {
					var h = function(o) {
						o.category = "doc";
						svc.uploadResource(o);
						self.listModel.refresh(true);
					}
					return new PopupOpener( "#add-file", {handler:h, entry: {}} );	
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
		
		$put("add-file",
			new function() {
				this.handler;
				this.entry;
				var self = this;
				this._controller;
				this.save = function() {
					this.handler(this.entry);
					return "_close";	
				}	
				this.afterAttach = function(o) {
					this.entry.filename = o.filename;
					this.entry.content_type = o.content_type;
					this.entry.tmpfileid = o.fileid;
					this.entry.filesize = o.filesize;
					this.entry.ext = o.ext;
				}
				this.removeAttachment = function() {
					var c = this.entry;
					this.entry = {};
					this.entry.title = c.title;
					this.entry.description = c.description;
					this.entry.keywords = c.keywords;
					self._controller.refresh();
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
	
	<jsp:attribute name="sections">
		<div id="add-file" style="display:none">
			<div>
				<input type="file"
				r:context="add-file" 
				r:caption="1. Select file to upload"
				r:oncomplete="afterAttach"
				r:expression="1. #{filename} &nbsp;&nbsp;&nbsp;&nbsp;size:#{filesize}"
				r:onremove="removeAttachment"
				r:url="library/upload_temp.jsp"/>
			</div>
			<br>
			<div class="label">2. Enter Title</div>
			<div><input type="text" r:context="add-file" r:name="entry.title" r:hint="Enter Title" style="width:380px;"/></div>	
			<br>
			<div class="label">3. Enter Description <i>( put in notes so you can remember what this file is about)</i></div>
			<div><textarea r:context="add-file" r:name="entry.description" style="width:380px;"></textarea></div>	
			<br>
			<div class="label">4. Enter Keywords <i>( to help you find your documents easier )</i></div>
			<div><textarea r:context="add-file" r:name="entry.keywords" style="width:380px;"></textarea></div>	
			<br>
			<button style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px">
				<a r:context="add-file" r:name="save">Save</a>
			</button>
		</div>
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
						<a href="javascript:window.open('library/viewres.jsp?id=#{item.fileurl}&ct=#{item.content_type}')">View</a> 
					</td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
</t:content>

