<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Videos">
	<jsp:attribute name="head">
		<script src="${pageContext.servletContext.contextPath}/js/ext/jyoutube.js"></script> 
	</jsp:attribute>
	<jsp:attribute name="script">
		$register({id:"#view-vid",context:"view-vid", title:"View Video", options: {height:400,width:500}});
		$register({id:"#add-vid",context:"add-vid", title:"Add Video", options: {height:400,width:500}});
	
		$put("videos", 
			new function() {
				var svc = ProxyService.lookup("LibraryService");
				var self = this;
				this.videos = [
					{filename:"http://www.youtube.com/watch?v=GOS_ALul1Y8&feature=g-comedy"},
					{filename:"http://www.youtube.com/watch?v=u7PdcFijqgk&feature=related"},
					{filename:"http://www.youtube.com/watch?v=tuIQHiAHExg&feature=related"}
				];
				this._controller;
				this.videothumbnails = [];
				this.selectedvid;
				this.video;
				
				this.onload = function() {
					var m = {category : "video"};
					//this.videos = svc.getResources( m );
					
					for(var i=0 ; i<=this.videos.length -1 ; i++) {
						this.videothumbnails.push({img:$.jYoutube(this.videos[i].filename, "small"), filename:this.videos[i].filename.replace("watch?v=","v/").replace(this.videos[i].filename.substring(this.videos[i].filename.lastIndexOf('&')), "?autoplay=1")});
					}
				}
				
				this.viewvid = function() {
					return new PopupOpener( 
						"#view-vid", 
						{
							vidpath:this.selectedvid.filename
						} 
					);
				}
				
				this.add = function() {
					var h = function(o) {
						o.category = "video";
						svc.uploadResource(o);
						this.videos = null;
						self.onload();
						self._controller.refresh();
					}
					return new PopupOpener( "#add-vid", {handler:h, entry: {}} );	
				}
				
				$put("add-vid",
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
							this.entry.tmpfileid = o.fileid;
							this.entry.content_type = o.content_type;
							this.entry.filesize = o.filesize;
							this.entry.ext = o.ext;
							this.entry.filedir = o.filedir;
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
			}
		);
		
		$put("view-vid", 
			new function() {
				this.vidpath;
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="style">
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
		<input type="button" r:context="videos" r:name="add"	value="Add Video"/>
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="view-vid" style="padding:5px;margin:10px;display: table-cell; vertical-align: middle;padding:10px;text-align:center;width:100%;">
			<label r:context="view-vid">
				<embed src="#{vidpath}" width="320" height="240">
			</label>
		</div>
		
		<div id="add-vid" style="display:none">
			<div>
				<div>
					<input type="file"
					r:context="add-vid" 
					r:name="video"
					r:caption="1. Select video to upload"
					r:oncomplete="afterAttach"
					r:expression="1. #{filename} &nbsp;&nbsp;&nbsp;&nbsp;size:#{filesize}"
					r:onremove="removeAttachment"
					r:url="library/upload_temp.jsp"/>
				</div>
				<br>
				<div class="label">2. Enter Title</div>
				<div><input type="text" r:context="add-vid" r:name="entry.title" r:hint="Enter Title" style="width:300px;"/></div>	
				<br>
				<div class="label">3. Enter Description <i>( put in notes so you can remember what this picture is about)</i></div>
				<div><textarea r:context="add-vid" r:name="entry.description" style="width:300px;"></textarea></div>	
				<br>
				<div class="label">4. Enter Keywords <i>( to help you find your pictures easier )</i></div>
				<div><textarea r:context="add-vid" r:name="entry.keywords" style="width:300px;"></textarea></div>	
				<br>
				<button style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px">
					<a r:context="add-vid" r:name="save">Save</a>
				</button>
			</div>
		</div>
	</jsp:attribute>
	
   <jsp:body>
		<!-- FOR YOUTUBE Videos ONLY -->
		<ul r:context="videos" r:items="videothumbnails" r:name="selectedvid">
			<li>
				<div style="border:1px solid #cecfce;padding:5px;margin:10px;">
					<a r:context="videos" r:name="viewvid">
						<div style="display: table-cell; vertical-align: middle;padding:10px;background:#efefef;text-align:center;width:#{IMGCONT_WIDTH}px;height:#{IMGCONT_HEIGHT}px;line-height:#{IMGCONT_HEIGHT}-2px;">
							<img src="#{img}">
						</div>
					</a>
				</div>
			</li>
		</ul>
		<!--
		<ul r:context="videos" r:items="videos">
			<li>
				<div style="border:1px solid #cecfce;padding:5px;margin:10px;">
					<video width="320" height="240" controls="controls">
						<source src='library/viewres.jsp?id=#{fileurl}' type='#{content_type}' codecs='theora, vorbis'>
						Your browser does not support the video tag.
					</video>
				</div>
			</li>
		</ul>
		-->
	</jsp:body>
</t:content>

