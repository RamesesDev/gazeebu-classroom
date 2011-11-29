<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Pictures">

   
	<jsp:attribute name="script">
		$register({id:"#add-picture",context:"add-picture", title:"Upload picture", options: {height:400,width:500}}); 
		$register({id:"#pic-view",context:"pic-view", title:"View picture", options: {height:400,width:500}});
		$put("pictures", 
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.qry = {}
				this.add = function() {
					var h = function(o) {
						o.category = "picture";
						svc.uploadResource(o);
						self.listModel.refresh(true);
					}
					return new PopupOpener( "#add-picture", {handler:h, entry: {}} );	
				}
				this.search = function() {
					alert('search');
				}
				this.selectedItem;
				
				this.listModel = {
					fetchList : function(o) {
						var m = {category : "picture"};
						return svc.getResources( m );
					}
				}
				
				this.viewPic = function() {
					var imgpath = "library/viewres.jsp?id="+ this.selectedItem.fileurl + "&ct=" + this.selectedItem.content_type;
					return new PopupOpener( "#pic-view", {imgpath: imgpath} );
				}
			}
		);	
		
		$put("add-picture",
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
		
		$put("pic-view", 
			new function() {
				this.imgpath;
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
		<input type=text r:context="pictures" r:name="qry.search" r:hint="Type Search Keyword"/>
		<input type="button" r:context="pictures" r:name="search"	value="."/>
		<input type="button" r:context="pictures" r:name="add"	value="Add picture"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="add-picture" style="display:none">
			<div>
				<input type="file"
				r:context="add-picture" 
				r:caption="1. Select picture to upload"
				r:oncomplete="afterAttach"
				r:expression="1. #{filename} &nbsp;&nbsp;&nbsp;&nbsp;size:#{filesize}"
				r:onremove="removeAttachment"
				r:url="library/upload_temp.jsp"/>
			</div>
			<br>
			<div class="label">2. Enter Title</div>
			<div><input type="text" r:context="add-picture" r:name="entry.title" r:hint="Enter Title" style="width:380px;"/></div>	
			<br>
			<div class="label">3. Enter Description <i>( put in notes so you can remember what this picture is about)</i></div>
			<div><textarea r:context="add-picture" r:name="entry.description" style="width:380px;"></textarea></div>	
			<br>
			<div class="label">4. Enter Keywords <i>( to help you find your pictures easier )</i></div>
			<div><textarea r:context="add-picture" r:name="entry.keywords" style="width:380px;"></textarea></div>	
			<br>
			<button style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px">
				<a r:context="add-picture" r:name="save">Save</a>
			</button>
		</div>
		<div id="pic-view" style="display:none">
			<label r:context="pic-view">
				<img src="#{imgpath}" height="100%"/>
			</label>
		</div>
	</jsp:attribute>
	
   <jsp:body>
		<table r:context="pictures" r:model="listModel" r:varName="item" r:name="selectedItem"
			width="100%" cellpadding="4" cellspacing="1" cellspacing="1">
			<thead>
				<tr>
					<td class="colhead">Title</td>
					<td class="colhead">Description</td>
					<td class="colhead" width="80" align="center">size</td>
					<td class="colhead" width="80" align="center">Date</td>
					<td class="colhead">&nbsp;</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>#{item.title}</td>
					<td>
						#{item.description}
					</td>
					<td align="center">#{item.filesize}</td>
					<td align="center">#{item.dtfiled}</td>
					<td align="center">
						<a r:context="pictures" r:name="viewPic">View</a> 
					</td>
				</tr>
			</tbody>
		</table>
	</jsp:body>
</t:content>



