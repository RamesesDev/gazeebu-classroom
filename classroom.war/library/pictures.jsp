<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Pictures">
	<jsp:attribute name="script">
		$register({id:"#add-picture",context:"add-picture", title:"Upload picture", options: {height:400,width:500}}); 
		$register({id:"#pic-view",context:"pic-view", title:"View picture", options: {height:400,width:500}});
		$register({id:"#actual-view",context:"actual-view", title:"View the picture in its actual size", options: {height:400,width:500}});
				
		function calcHeightRatio(img, height, width) {
			if(img.height <= height && img.width <= width)
			{
				return;
			}
		
			if(img.height == img.width) 
			{
				img.width = width;
				return;
			}
				
			if(img.width >= width && img.height <= height)
			{
				img.width = width;
				return;
			}
				
			if(img.height >= height && img.width <= width)
			{
				img.height = height;
				return;
			}
			
			if(img.width > img.height)
			{
				img.width = width;
				return;
			}
			
			if(img.height > img.width)
			{
				img.height = height;
			}
		}
		
		$put("pictures", 
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.qry = {};
				this._controller;
				this.IMGCONT_WIDTH = 80; // IMAGE CONTAINER WIDTH
				this.IMGCONT_HEIGHT = 80; // IMAGE CONTAINER HEIGHT 
				this.add = function() {
					var h = function(o) {
						o.category = "picture";
						svc.uploadResource(o);
						this.list = null;
						self.onload();
						self._controller.refresh();
					}
					return new PopupOpener( "#add-picture", {handler:h, entry: {}} );	
				}
				this.search = function() {
					alert('search');
				}
				this.selectedItem;
				this.list;
				
				this.onload = function() {
					var m = {category : "picture"};
					this.list = svc.getResources( m );
				}
				
				this.listModel = {
					fetchList : function(o) {
						var m = {category : "picture"};
						return svc.getResources( m );
					}
				}
				
				this.viewpic = function() {
					var imgpath = "library/viewres.jsp?id="+ this.selectedItem.fileurl + "&ct=" + this.selectedItem.content_type;
					return new PopupOpener( 
						"#pic-view", 
						{
							imgpath: imgpath, 
							title:this.selectedItem.title, 
							desc:this.selectedItem.description, 
							dtfiled:this.selectedItem.dtfiled, 
							keywords:this.selectedItem.keywords
						} 
					);
				}
				
			}
		);	
		
		$put("add-picture",
			new function() {
				this.handler;
				this.entry;
				this.photo;
				var self = this;
				this._controller;
				this.width;
				this.save = function() {
					this.handler(this.entry);
					return "_close";	
				}	
				this.afterAttach = function(o) {
					this.entry.filename = o.filename;
					this.entry.tmpfileid = o.fileid;
					this.entry.content_type = o.content_type;
					this.entry.filesize = o.filesize;
					this.entry.ext = o.ext;
				}
				this.removeAttachment = function() {
					var c = this.entry;
					this.entry = {};
					this.entry.title = c.title;
					this.entry.description = c.description;
					this.entry.keywords = c.keywords;
					
					this.photo = null;
					self._controller.refresh();
				}
			}
		);	
		
		$put("pic-view", 
			new function() {
				this.imgpath;
				this.width;
				
				this.viewActualPic = function() {
					return new PopupOpener( "#actual-view", {imgpath: this.imgpath } );
				}
				
			}
		);	
		
		$put("actual-view", 
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
		
		ul
		{
			list-style: none;
		}
		
		li
		{
			float:left;
			display: block;
		}
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input type=text r:context="pictures" r:name="qry.search" r:hint="Type Search Keyword"/>
		<input type="button" r:context="pictures" r:name="search"	value="."/>
		<input type="button" r:context="pictures" r:name="add"	value="Add picture"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="add-picture" style="display:none">
			<div style="width:80px;height:100%;float:left;"
					r:context="add-picture" 
					r:visibleWhen="#{photo}" 
					r:depends="photo">
				<label r:context="add-picture" r:depends="photo">
					<div style="padding:5px;border:1px solid #cccccc;">
					<img id="pic" src="library/viewres.jsp?id=#{photo.fileid}#{photo.ext}&ct=#{photo.content_type}" 
						width="100%">
					</div>
				</label>
			</div>
			<div style="float:right;width:350px;">
				<div>
					<input type="file"
					r:context="add-picture" 
					r:name="photo"
					r:caption="1. Select picture to upload"
					r:oncomplete="afterAttach"
					r:expression="1. #{filename} &nbsp;&nbsp;&nbsp;&nbsp;size:#{filesize}"
					r:onremove="removeAttachment"
					r:url="library/upload_temp.jsp"/>
				</div>
				<div>
					<br>
					<div class="label">2. Enter Title</div>
					<div><input type="text" r:context="add-picture" r:name="entry.title" r:hint="Enter Title" style="width:300px;"/></div>	
					<br>
					<div class="label">3. Enter Description <i>( put in notes so you can remember what this picture is about)</i></div>
					<div><textarea r:context="add-picture" r:name="entry.description" style="width:300px;"></textarea></div>	
					<br>
					<div class="label">4. Enter Keywords <i>( to help you find your pictures easier )</i></div>
					<div><textarea r:context="add-picture" r:name="entry.keywords" style="width:300px;"></textarea></div>	
					<br>
					<button style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px">
						<a r:context="add-picture" r:name="save">Save</a>
					</button>
				</div>
			</div>
			
		</div>
		<div id="pic-view" style="display:none">
			<label r:context="pic-view">
				<img src="#{imgpath}" onload="calcHeightRatio(this, 250, 250)"/><br/>
				<span style="color:#333333;font-weight:bold;font-size:14px;">#{title}</span><br/>
				<span style="color:#333333;">#{desc}</span><br/>
				<span style="color:#808080;">Uploaded on</span> #{dtfiled}<br/>
				<span style="color:#808080;">Keyword: </span> #{keywords}<br/>
			</label>
			<a href="#"  r:context="pic-view" r:name="viewActualPic">View Actual Size</a>
		</div>
		<div id="actual-view" style="display:none">
			<label r:context="actual-view">
				<img src="#{imgpath}" /><br/>
			</label>
		</div>
	</jsp:attribute>
	
   <jsp:body>
		<ul r:context="pictures" r:items="list" r:name="selectedItem">
			<li>
				<div style="border:1px solid #cecfce;padding:5px;margin:10px;">
					<a r:context="pictures" r:name="viewpic" >
						<div style="display: table-cell; vertical-align: middle;padding:10px;background:#efefef;text-align:center;width:#{IMGCONT_WIDTH}px;height:#{IMGCONT_HEIGHT}px;line-height:#{IMGCONT_HEIGHT}-2px;">
							<img src="library/viewres.jsp?id=#{fileurl}&ct=#{content_type}"
							 onload="calcHeightRatio(this, #{IMGCONT_HEIGHT}, #{IMGCONT_WIDTH})">
						</div>
					</a>
				</div>
			</li>
		</ul>
	</jsp:body>
</t:content>



