<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:popup>
	<jsp:attribute name="script">
		$put("class_welcome",
			new function() 
			{
				this.classid;
				this.classinfo;
				this.userid;
				this.haveRead;
				this.syllabus;
				
				this.onload = function() {
					if( this.classinfo )
						this.syllabus = this.classinfo.syllabus;
				}
				
				this.activate = function() {
					if( !this.haveRead ) {
						$('#welcome_message_err').fadeIn();
						return;
					}
					ProxyService.lookup("ClassroomService").activateMembership( this.classid, this.userid );
					return '_close';
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<button r:context="class_welcome" r:name="_close">Skip</button>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<button r:context="class_welcome" r:name="activate">Proceed</button>
	</jsp:attribute>
	
	<jsp:body>
		<h2>Message from your teacher.</h2>
		<div id="welcome_message_err" style="color:red;display:none">
			<b>Please confirm that you have read everything.</b>
			<br/><br/>
		</div>
		<div class="box-outer">
			<table width="100%" class="box">
				<tr>
					<td valign="top">
						<div style="height:200px;overflow:auto;">
							<label r:context="class_welcome" style="display:block;">
								#{classinfo.welcome_message? classinfo.welcome_message : '<i>No welcome message yet</i>.'}
							</label>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<h3>Course Syllabus</h3>
		<div>
			<c:set var="RES_PATH" value="${pageContext.servletContext.contextPath}/apps/classinfo/syllabus_resource.jsp"/>
			<label r:context="class_welcome" r:visibleWhen="#{!syllabus}">
				<i>No syllabus attached.</i>
			</label>
			<label r:context="class_welcome" r:visibleWhen="#{syllabus}">
				#{syllabus.filename}
			</label>
			<span class="controls" r:context="class_welcome" r:visibleWhen="#{syllabus}">
				<label r:context="class_welcome">
					&nbsp;&nbsp;
					<a href="${RES_PATH}?t=dl&id=#{syllabus.fileid}&fn=#{syllabus.filename}&ct=#{syllabus.content_type}" target="_blank">
						Download
					</a> |
					<a href="${RES_PATH}?t=vw&id=#{syllabus.fileid}&fn=#{syllabus.filename}&ct=#{syllabus.content_type}" target="_blank">
						View
					</a>
				</label>
			</span>
		</div>
		<br/>
		<div>
			<label>
				<input type="checkbox" r:context="class_welcome" r:name="haveRead"/>
				I have read everything.
			</label>
		</div>
	</jsp:body>
	
</t:popup>


