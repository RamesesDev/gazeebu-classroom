<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_USER_INFO"/>
<s:invoke service="ClassroomService" method="getClassInfo" params="${param['classid']}" var="CLASS_INFO"/>

<t:content title="Discussion" subtitle="Topics for discussion">
	
	<jsp:attribute name="style">
		.threads .top {
			font-size:15px;font-weight:bold;color:darkslateblue;padding-top:10px;
		}
		.threads .desc {
			font-size:10px;font-style:italic;
		}
		.threads .hr {
			border-top: 1px solid #D2D9E7;
		}
	</jsp:attribute>

	<jsp:attribute name="script">
		$register( {id:"new_thread", context:"new_thread", page:"classroom/discussion/new_thread.jsp", title:"New Discussion Thread", options: {width:500,height:420}} );
		$put("discussion", 
			new function() 
			{
				var svc = ProxyService.lookup("DiscussionService");
				var self = this;
				this.classid = "${param['classid']}";
				this.eof = "false";
				this.users;
				
				this.selected;
				
				this.onload = function() {
					this.users = $ctx('classroom').members;
				}
				
				this.listModel = {
					fetchList: function( p, last ){
						var m = {classid: self.classid};
						if(last) m.lastmsgid = last.objid; 
						var list =  svc.getThreads( m );
						if(list.length==0) {
							self.eof = "true";
						}	
						return list;
					}
				}
				
				this.create = function() {
					var s = function(o) {
						svc.addThread( o );
						self.listModel.refresh(true); 
					}
					return new PopupOpener("new_thread", {saveHandler: s});
				}
				
				this.edit = function() {
					var s = function(o) {
						svc.updateThread( o );
						self.listModel.refresh(true); 
					}
					var o = new PopupOpener("new_thread", {saveHandler: s, entry: this.selected});
					o.title = "Edit Discussion Thread";
					return o;
				}
			}
		);	
	</jsp:attribute>

	<jsp:attribute name="actions">
		<c:set var="RES_PATH" value="${pageContext.servletContext.contextPath}/classroom/classinfo/syllabus_resource.jsp"/>
		<c:set var="syllabus" value="${CLASS_INFO.info.syllabus}"/>
		<a href="${RES_PATH}?t=vw&id=${syllabus.fileid}&fn=${syllabus.filename}&ct=${syllabus.content_type}" target="_blank">
			View Syllabus
		</a>
		&nbsp;&nbsp;
	
		<c:if test="${CLASS_USER_INFO.usertype == 'teacher'}">
			<input type="button" r:context="discussion" r:name="create" value="New Thread"/>
		</c:if>
	</jsp:attribute>
	
		
	<jsp:attribute name="rightpanel">
		
	</jsp:attribute>	
		
	<jsp:body>
		<table r:context="discussion" r:model="listModel" r:varName="item" r:name="selected" r:emptyText="No discussion posted"
			   class="threads" cellpadding="0" cellspacing="0" width="95%">
			<tr>
				<td class="top">
					<a href="#discussion:thread?objid=#{item.objid}">
						#{item.subject}
					</a>
					( #{item.topic_count != 0 ? ( item.topic_count!=1 ? item.topic_count + ' topics' : '1 topic') : 'No topics posted'} )
				</td>
				<td width="50px" align="right" class="top">
					<c:if test="${fn:contains(SESSION_INFO.roles,'teacher')}">
						<a r:context="discussion" r:name="edit">Edit</a>
					</c:if>
				</td>
			</tr>
			<tr>	
				<td colspan="2" valign="top" class="desc">
					Posted on #{item.dtposted}
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="hr"></div>
				</td>
			</tr>
		</table>
	</jsp:body>
	
</t:content>


	