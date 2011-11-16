<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:popup>
	<jsp:attribute name="script">
		$put("attach_syllabus",
			new function() 
			{
				this.handler;
				this.classinfo;
				this._controller;
				
				this.description;
				
				this.onload = function() {
					if( !this.classinfo.info )
						this.classinfo.info = {};
				}
				
				this.save = function() {
					var svc = ProxyService.lookup('ClassService');
					svc.update(this.classinfo);
					if( this.handler ) this.handler();
					return '_close';
				}
				
				this.upload_complete = function( o ) {
					o.description = this.description;
					this.classinfo.info.syllabus = o;
					this.save();
					this._controller.navigate('_close');
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="attach_syllabus" r:name="_close" value="Cancel"/>
	</jsp:attribute>
	
	<jsp:body>
		<table>
			<tr>
				<td valign="top" width="80">Description</td>
				<td>
					<input type="text" r:context="attach_syllabus" r:name="description" size="50"/>
				</td>
			</tr>
			<tr>
				<td valign="top">File</td>
				<td>
				   <input type="file" 
						  r:context="attach_syllabus" 
						  r:caption="Upload File"
						  r:oncomplete="upload_complete"
						  r:url="apps/classinfo/upload_syllabus.jsp"/>
				</td>
			</tr>			
		</table>
	</jsp:body>
	
</t:popup>


