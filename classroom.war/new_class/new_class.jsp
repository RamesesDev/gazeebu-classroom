<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:popup>
	<jsp:attribute name="script">
		$put(
			"new_class",
			new function() 
			{
				var svc = ProxyService.lookup("ClassService");
				var self = this;
				
				this.saveHandler;
				this.classinfo = {info:{}};
				this.editmode = "new";
				this._controller;
				
				this.save = function() {
					if( this.page == 'page2' ) {
						svc.update( this.classinfo );
						return "_close";
					}
					else {
						this.classinfo = svc.create( this.classinfo );
						if( !this.classinfo.info ) this.classinfo.info = {};
						if(this.saveHandler) this.saveHandler();
						return (this.page="page2");
					}
				}
				
				this.afterAttach = function(o) {
					this.classinfo.info.syllabus = o;
					svc.update( this.classinfo );
				}
				
				this.removeSyllabus = function() {
					$.ajax({
						url: 'apps/classinfo/syllabus_resource.jsp',
						type: 'GET',
						data: {
							t:'rm',
							id: self.classinfo.info.syllabus.fileid, 
							objid: self.classinfo.objid
						},
						async: false,
						success: function() {
							self._controller.refresh();
						},
						error: function() {
							alert('An error has occured while performing this action.');
						}
					});
				}
			},
			{
				"default" : "new_class/page1.jsp",
				"page2" : "new_class/page2.jsp"
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" value="Skip" r:context="new_class" r:name="_close" r:visibleWhen="#{page=='page2'}"/>	
	</jsp:attribute>

	<jsp:attribute name="rightactions">
		<input type="button" value="Save" r:context="new_class" r:name="save"/>	
	</jsp:attribute>
	
	<jsp:body>
		<div r:controller="new_class"></div>
	</jsp:body>	
</t:popup>	