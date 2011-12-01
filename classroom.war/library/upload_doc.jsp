<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
	
	<jsp:attribute name="style">
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("upload_doc",
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				this.handler;
				this.entry = {category: "doc"};
				var self = this;
				this._controller;
				this.save = function() {
					svc.uploadResource(this.entry);
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

	<jsp:body>
		<div>
			<input type="file"
			r:context="upload_doc" 
			r:caption="1. Select file to upload"
			r:oncomplete="afterAttach"
			r:expression="1. #{filename} &nbsp;&nbsp;&nbsp;&nbsp;size:#{filesize}"
			r:onremove="removeAttachment"
			r:url="library/upload_temp.jsp"/>
		</div>
		<br>
		<div class="label">2. Enter Title</div>
		<div><input type="text" r:context="upload_doc" r:name="entry.title" r:hint="Enter Title" style="width:380px;"/></div>	
		<br>
		<div class="label">3. Enter Description <i>( put in notes so you can remember what this file is about)</i></div>
		<div><textarea r:context="upload_doc" r:name="entry.description" style="width:380px;"></textarea></div>	
		<br>
		<div class="label">4. Enter Keywords <i>( to help you find your documents easier )</i></div>
		<div><textarea r:context="upload_doc" r:name="entry.keywords" style="width:380px;"></textarea></div>	
		<br>
		<button style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px">
			<a r:context="upload_doc" r:name="save">Save</a>
		</button>
	</jsp:body>
	
</t:popup>

