<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="cui" %>
<%@ page import="java.util.*" %>


<t:popup>

	<jsp:attribute name="script">
		$register({id:"library:upload_doc_form", context:"upload_doc_form", page:"library/upload_doc_form.jsp", title:"Upload Document to Library", options: {height:400,width:500}});
		$register({id:"library:res_lookup", context:"res_lookup", page:"library/res_lookup.jsp", title:"Select Resource from Library", options: {height:400,width:500}});
		
		$put("add_attachment", 	
			new function() 
			{
				var self = this;
				this.resource =  {subscribers:[]}
				this.linktypes = ["link", "embed", "library"];
				
				//passed by the caller
				this.parentid;
				this.senderid;
				this.handler;
				this.subscribers;
				
				this.libtype;
				this.libtypes = ["doc"];

				this.users;
				this.allowAlso = false;
				this.allowed = [];
				
				this.onload = function() {
					this.users = $ctx('classroom').usersIndex;
					if( this.subscribers ) {
						var ss = [];
						this.subscribers.each(function(o){
							if( o.userid != '${SESSION_INFO.userid}' ) ss.push(o);
						});
						this.subscribers = ss;
					}					
				}

				this.save = function() {
					if( this.senderid )
						this.resource.subscribers.push({userid: this.senderid});
						
					if( this.allowed.length > 0 )
						this.allowed.each(function(o){ self.resource.subscribers.push({userid: o}) });
					
					this.resource.refid = this.parentid;
					ProxyService.lookup("AttachmentService").addAttachment(this.resource);
					if( this.handler ) this.handler(this.resource);
					return "_close";
				}
				
				this.uploadFile = function() {
					var h = function(o) {
						self.resource.libid = o.objid;
						self.resource.libtype = o.category;
						self.resource.content_type = o.content_type;
						self.resource.linkref = o.fileurl;
					}
					return new PopupOpener( "library:upload_doc_form", {handler:h} );		
				}
				
				this.title;
				this.searchLib = function(txt) {
					var m = {category: self.libtype, title: txt};
					return ProxyService.lookup("LibraryService").findResources( m );
				}
				
				this.propertyChangeListener = {
					'selected' : function(o) {
						self.resource.libid = o.objid;
						self.resource.libtype = o.category;
						self.resource.content_type = o.content_type;
						self.resource.linkref = o.fileurl;
					}
				}
			}
		);	
 	</jsp:attribute>
	
	<jsp:attribute name="style">
		.label {
			font-weight:bolder;
		}
 	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="search_tpl" style="display:none;">
			<a>#{title}</a>
		</div>
	</jsp:attribute>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="add_attachment" r:name="save" value="OK"/>
	</jsp:attribute>
	
	<jsp:body>
		<div class="label">Subject</div>
		<input type="text"  r:context="add_attachment" r:name="resource.subject" style="width:300px" r:required="true" r:caption="Title"/>
		<br>
		<div class="label">Add a short message</div>
		<textarea  r:context="add_attachment" r:name="resource.message" style="width:300px;height:50px;"></textarea>
		<br>
		
		<div class="label">Select a reference type</div>
		<select r:context="add_attachment" r:items="linktypes" r:name="resource.reftype" r:allowNull="true" r:emptyText="-select reference type-"/>
		
		<div r:context="add_attachment" r:depends="resource.reftype" r:visibleWhen="#{resource.reftype == 'link'}">
			<div class="label">Link Reference</div>
			<input type="text" r:context="add_attachment" r:name="resource.linkref" r:required="true" style="width:300px;" r:caption="Link Reference"/>
		</div>
		
		<div r:context="add_attachment" r:depends="resource.reftype" r:visibleWhen="#{resource.reftype == 'embed'}">
			<div class="label">Enter Embedded Code</div>
			<textarea r:context="add_attachment" r:name="resource.embedcode" r:required="true" style="width:300px;height:50px;"></textarea>
		</div>
		
		<div r:context="add_attachment" r:depends="resource.reftype" r:visibleWhen="#{resource.reftype == 'library'}">
			<div class="label">Select from Library</div>
			<select r:context="add_attachment" r:items="libtypes" r:name="libtype" r:allowNull="true" r:emptyText="-select a library resource type-"/>
			<br>
			<br>
			<br>
		</div>	
		<div r:context="add_attachment" r:depends="libtype,resource.reftype" r:visibleWhen="#{resource.reftype == 'library' && libtype=='doc'}">
			<div>Search document: </div>
			 <input type="text" r:context="add_attachment" r:name="title" 
						   r:suggest="searchLib" r:suggestName="selected"
						   r:suggestExpression="#{title}"
						   r:suggestTemplate="search_tpl" 
						   style="width:350px"/>
			
			OR 	<input type="button" r:context="add_attachment" r:name="uploadFile" value="Upload New Document" r:immediate="true" />  
		</div>
		<div r:context="add_attachment" r:depends="libtype,resource.reftype" r:visibleWhen="#{resource.reftype == 'library' && libtype=='picture'}">
			<div>
				Search picture:
				<input type="text" r:context="add_attachment" r:name="title" 
						   r:suggest="searchLib" r:suggestName="selected"
						   r:suggestExpression="#{title}"
						   r:suggestTemplate="search_tpl" 
						   style="width:350px"/>
			</div> 
			OR <input type="button" r:context="add_attachment" r:name="uploadFile" value="Upload New Picture" r:immediate="true" />  
		</div>
		
		<div r:context="add_attachment" r:visibleWhen="#{subscribers != null && subscribers.length > 0}">
			<br/>
			<br/>
			<label>
				<input type="checkbox" r:context="add_attachment" r:name="allowAlso">
				Allow also the following to view this attachment:
			</label>
			<br/>
			<div r:context="add_attachment" r:visibleWhen="#{allowAlso == true}" r:depends="allowAlso">
				<table r:context="add_attachment" r:items="subscribers" r:varName="item" 
					   class="message" cellpadding="0" cellspacing="0" border="0">
					<tbody>
						<tr>
							<td valign="top">
								<input type="checkbox" r:context="add_attachment" r:name="allowed" r:mode="set" r:checkedValue="#{item.userid}" />
							</td>
							<td valign="top" align="center">
								<img src="profile/photo.jsp?id=#{item.userid}&t=thumbnail&v=#{users[item.userid].info.photoversion}}" width="${!empty picSize ? picSize : '40px'}"/>
							</td>
							<td valign="top" class="subject message-head capitalized" style="padding-left:4px;">
								#{users[item.userid].lastname}, #{users[item.userid].firstname}
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
	</jsp:body>
	
</t:popup>


	