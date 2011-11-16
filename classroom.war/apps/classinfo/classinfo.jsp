<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="INFO"/>

<t:content title="Class Profile">
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.css" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.js"></script>
	</jsp:attribute>
	<jsp:attribute name="style">
		.section {
			overflow: hidden;
			background-color: lightgrey;		
			margin-bottom: 10px;
			padding:5px;
		}
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
				this.classInfo;
				
				this.onload = function() {
					this.classInfo = svc.read({objid: '${INFO.objid}'});
				}
				
				this.inviteStudents = function() {
					return new PopupOpener("invite_student");
				}
				
				this.edit = function() {
					var o = new PopupOpener('classinfo:edit_info');
					o.title = 'Class Information';
					return o;
				}
				
				this.editWelcome = function() {
					var o = new PopupOpener('classinfo:edit_welcome',{classInfo: this.classInfo, handler:function(){ self.onload(); }});
					o.title = 'Welcome Message';
					o.options = {width: 650, height: 500};
					return o;
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
				<span class="controls">
					<a r:context="classinfo" r:name="edit">Edit</a>
				</span>
			</div>
			<table style="margin-left:20px;">
				<tr>
					<td valign="top" width="100">Name</td>
					<td><label r:context="classinfo">#{classInfo.name}</label></td>
				</tr>
				<tr>
					<td valign="top">Description</td>
					<td><label r:context="classinfo">#{classInfo.description}</label></td>
				</tr>			
			</table>
			<br/>
			
			<div class="section">
				<span class="sectiontitle">
					Welcome Message
				</span>
				<span class="controls">
					<a r:context="classinfo" r:name="editWelcome">Edit</a>
				</span>
			</div>
			<div style="padding-left:20px;">
			<p>
				Write a welcome message for your students.
			</p>
			<div class="box-outer">
				<table width="100%" height="200" class="box">
					<tr>
						<td valign="top">
							<label r:context="classinfo" style="display:block;">
								#{classInfo.info.welcome_message? classInfo.info.welcome_message : '<i>No welcome message yet</i>.'}
							</label>
						</td>
					</tr>
				</table>
			</div>
			<br/>
			
			<div class="section">
				<span class="sectiontitle">
					Course Syllabus
				</span>
			</div>
			<button r:context="classinfo" r:name="attach">Attach</button>
		</div>
	</jsp:body>
	
</t:content>
