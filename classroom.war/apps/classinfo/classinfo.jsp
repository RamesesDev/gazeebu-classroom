<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_INFO"/>
<c:set var="RES_PATH" value="${pageContext.servletContext.contextPath}/apps/classinfo/syllabus_resource.jsp"/>

<t:content title="Class Profile">
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.css" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.js"></script>
	</jsp:attribute>
	<jsp:attribute name="style">
		.row, .section { overflow: hidden; }

		.section {
			background-color: lightgrey;		
			margin-bottom: 10px;
			padding:5px;
		}
		
		.row .controls,
		.section .controls {
			display: inline-block;
			float: right;
		}
		
		.sectiontitle {
			display: inline-block;
			font-size:14px;
			font-weight:bold;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put(
			"classinfo",
			new function() 
			{
			
				var svc = ProxyService.lookup('ClassService');
				var self = this;
				
				this.classinfo;
				this.syllabus;
				this._controller;
				
				this.onload = function() {
					this.classinfo = svc.read({objid: "${param['classid']}"});
					if( !this.classinfo.info ) this.classinfo.info = {};
					this.syllabus = this.classinfo.info.syllabus;
				}
				
				var afterUpdate = function() {
					self.onload();
					self._controller.refresh();
				}
				
				this.inviteStudents = function() {
					return new PopupOpener("invite_student");
				}
				
				this.edit = function() {
					var o = new PopupOpener('classinfo:edit_info',{classinfo:this.classinfo, handler:afterUpdate});
					o.options = {width: 500, height: 300};
					o.title = 'Class Information';
					return o;
				}
				
				this.editWelcome = function() {
					var o = new PopupOpener('classinfo:edit_welcome',{classinfo:this.classinfo, handler:afterUpdate});
					o.title = 'Welcome Message';
					o.options = {width: 650, height: 500};
					return o;
				}
				
				this.afterAttach = function(o) {
					this.classinfo.info.syllabus = o;
					svc.update( this.classinfo );
					this.onload();
					this._controller.refresh();
				}
				
				this.remove = function() {
					if( !confirm('Are you sure you want to remove this syllabus?') ) return;
					$.ajax({
						url: '${RES_PATH}',
						type: 'GET',
						data: {
							t:'rm',
							id: self.classinfo.info.syllabus.fileid, 
							objid: self.classinfo.objid
						},
						async: false,
						success: function() {
							self.onload();
							self._controller.refresh();
						},
						error: function() {
							alert('An error has occured while performing this action.');
						}
					});
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="actions">
		<input class="button" type="button" r:context="classinfo" r:name="inviteStudents" value="Invite Students" />
	</jsp:attribute>
	
	<jsp:body>
		<div style="width:80%">
			<div class="section">
				<span class="sectiontitle">
					Class Information
				</span>
				<c:if test="${CLASS_INFO.usertype == 'teacher'}">
					<span class="controls">
						<a r:context="classinfo" r:name="edit">Edit</a>
					</span>
				</c:if>
			</div>
			<table style="margin-left:20px;">
				<tr>
					<td valign="top" width="100">Name</td>
					<td><label r:context="classinfo">#{classinfo.name}</label></td>
				</tr>
				<tr>
					<td valign="top">Description</td>
					<td><label r:context="classinfo">#{classinfo.description? classinfo.description : '-'}</label></td>
				</tr>
				<tr>
					<td valign="top">Room Schedule</td>
					<td><label r:context="classinfo">#{classinfo.schedules? classinfo.schedules : '-'}</label></td>
				</tr>
				<tr>
					<td valign="top">School</td>
					<td><label r:context="classinfo">#{classinfo.school? classinfo.school : '-'}</label></td>
				</tr>
			</table>
			<br/>
			
			<div class="section">
				<span class="sectiontitle">
					Course Syllabus
				</span>
			</div>
			<div class="row" style="margin-left:20px;">
				<label r:context="classinfo" r:visibleWhen="#{syllabus}">
					#{syllabus.filename}
				</label>
				<span class="controls" r:context="classinfo" r:visibleWhen="#{syllabus}">
					<label r:context="classinfo">
						<a href="${RES_PATH}?t=dl&id=#{syllabus.fileid}&fn=#{syllabus.filename}&ct=#{syllabus.content_type}" target="_blank">
							Download
						</a> |
						<a href="${RES_PATH}?t=vw&id=#{syllabus.fileid}&fn=#{syllabus.filename}&ct=#{syllabus.content_type}" target="_blank">
							View
						</a>
					</label>
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						| <a r:context="classinfo" r:name="remove">Remove</a>
					</c:if>
				</span>
				<c:if test="${CLASS_INFO.usertype == 'teacher'}">
					<div r:context="classinfo" r:visibleWhen="#{!syllabus}">
						<input type="file"
							  r:context="classinfo" 
							  r:caption="Upload Syllabus"
							  r:oncomplete="afterAttach"
							  r:url="apps/classinfo/syllabus_upload.jsp"/>
					</div>
				</c:if>
			</div>
			<br/>
			
			<div class="section">
				<span class="sectiontitle">
					Welcome Message
				</span>
				<c:if test="${CLASS_INFO.usertype == 'teacher'}">
					<span class="controls">
						<a r:context="classinfo" r:name="editWelcome">Edit</a>
					</span>
				</c:if>
			</div>
			<div style="padding-left:20px;">
				<c:if test="${CLASS_INFO.usertype == 'teacher'}">
					<p>
						Write a welcome message for your students.
					</p>
				</c:if>
				<div class="box-outer">
					<table width="100%" class="box">
						<tr>
							<td valign="top">
								<div style="height:200px;overflow:auto;">
									<label r:context="classinfo" style="display:block;">
										#{classinfo.info.welcome_message? classinfo.info.welcome_message : '<i>No welcome message yet</i>.'}
									</label>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<br/>				
			</div>
		</div>
	</jsp:body>
	
</t:content>
