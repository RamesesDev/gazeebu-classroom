<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/ui" prefix="common" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<t:content title="My Connections">
	
	<jsp:attribute name="head">
		<link href="${pageContext.servletContext.contextPath}/css/connections.css?v=${APP_VERSION}" type="text/css" rel="stylesheet" />
		<link href="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.css?v=${APP_VERSION}" rel="stylesheet" />
		<script src="${pageContext.servletContext.contextPath}/js/ext/richtext/richtext.js?v=${APP_VERSION}"></script>
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put(
			"connections", 
			new function() 
			{
				var svc = ProxyService.lookup("ClassConnectionService");
				var self = this;
				
				this.onload = function() {
					var userid = '${SESSION_INFO.userid}';
				}
				
				this.connections = {
					fetchList: function(o) {
						svc.getAllConnections(function(list){
							self.connections.setList( list );
						});
					}
				}
				
				this.displayClassess = function( student ) {
					var arr = [];
					student.classess.each(function(it){
						var link = '<a href="classroom.jsp?classid=#{objid}" class="classname">#{name}<br/>(#{role})</a>'.evaluate(it);
						arr.push( link );
					});
					return arr.join('');
				}
			}
		);
	</jsp:attribute>
	
	<jsp:body>
		<table r:context="connections" r:model="connections" r:varName="item" width="100%" cellspacing="0" class="connections">
			<tr>
				<td width="100" valign="top">
					<div class="thumb">
						<img src="profile/photo.jsp?id=#{item.objid}&t=medium&v=${item.info.photoversion}" width="80"/>
					</div>
				</td>
				<td valign="top" width="200">
					<div class="name capitalized">
						#{item.lastname}, #{item.firstname}
					</div>
					<div class="details">
						#{item.username}
					</div>
					<div class="details">
						#{item.roles}
					</div>
				</td>
				<td valign="top">
					#{displayClassess(item)}
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="hr"></div>
				</td>
			</tr>
		</table>
	</jsp:body>
</t:content>