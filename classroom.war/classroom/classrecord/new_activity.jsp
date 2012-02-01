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

<s:invoke service="GradingCriteriaService" method="getGradingCriteria" params="${params}" var="CRITERIA"/>
<s:invoke service="GradingCriteriaService" method="getGradingPeriods" params="${params}" var="PERIODS"/>



<t:popup>

	<jsp:attribute name="script">
		$put("new_activity",
			new function() {
				var svc = ProxyService.lookup("ClassrecordService2");
				var gradingSvc = ProxyService.lookup("GradingCriteriaService");

				var self = this;
				
				this.saveHandler;
				this.activity = {classid: "${param['classid']}", criteriaid: null};
			
				
				
				this.criteriaList = [];
				<c:forEach items="${CRITERIA}" var="item">
				this.criteriaList.push( {objid:"${item.objid}", title:"${item.title}" } );
				</c:forEach>
			
				this.periodList = [];
				<c:forEach items="${PERIODS}" var="item">
				this.periodList.push( {objid:"${item.objid}", title:"${item.title}"} );
				</c:forEach>
				
				this.hasSubcriteria = "false";
				this.subcriteriaList;
				this.propertyChangeListener = {
					"activity.criteriaid" : function(o) {
						self.activity.subcriteriaid = null;
						self.subcriteriaList = gradingSvc.getSubcriteria(o);
						self.hasSubcriteria = (self.subcriteriaList.length>0) ? "true" : "false"; 
					}
				}
				
				this.save = function() {
					svc.addActivity( this.activity );
					this.saveHandler();	
					return "_close";
				}	
				
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="new_activity" r:name="save" value="Save" /> 
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top">Activity Title</td>
				<td valign="top">
					<input type="text" r:context="new_activity" r:name="activity.title" r:caption="Title"  r:required="true" style="width:300px;"/>
					<span class="req"> *</span>
				</td>
			</tr>
			
			<tr>	
				<td valign="top">Date of activity</td>
				<td valign="top">
					<input type="text" r:context="new_activity" r:name="activity.activitydate" r:datatype="date"  r:required="true"  r:caption="Date of activity"/>
					<span class="req"> *</span>
				</td>
			</tr>
			<tr>
				<td valign="top">Highest Possible Score</td>
				<td>
					<input type="text" r:context="new_activity" r:name="activity.totalscore" r:caption="Highest Possible Score"  r:required="true" />
					<span class="req"> *</span>
				</td>
			</tr>
			<tr>
				<td valign="top">Passing Score</td>
				<td><input type="text" r:context="new_activity" r:name="activity.passingscore"/></td>
			</tr>
			<tr>
				<td>Grading Criteria</td>
				<td valign="top">
					<select r:context="new_activity" r:name="activity.criteriaid" r:allowNull="true" r:items="criteriaList" r:itemKey="objid" r:itemLabel="title"  r:caption="Grading Criteria" r:required="true"/>
					<select r:context="new_activity" r:name="activity.subcriteriaid" r:emptyText="Choose a subcriteria" r:depends="activity.criteriaid" 
						r:visibleWhen="#{hasSubcriteria == 'true'}" r:allowNull="true" r:items="subcriteriaList" 
						r:itemKey="objid" r:itemLabel="title"  r:caption="Subcriteria" r:required="true">
					</select>
					<span class="req"> *</span>
				</td>
			</tr>	
			<c:if test="${! empty PERIODS}">
				<td valign="top">Period</td>
				<td valign="top">
					<select r:context="new_activity" r:name="activity.periodid"  r:allowNull="true"  r:items="periodList" r:itemKey="objid" r:itemLabel="title"  r:caption="Grading Period"  r:required="true">
					</select>
					<span class="req"> *</span>
				</td>
			</c:if>
			<tr>	
				<td valign="top">Notes/Instructions</td>
				<td valign="top"><textarea r:context="new_activity" r:name="activity.notes" style="width:100%;height:50;"></textarea></td>
			</tr>
		</table>
	
	</jsp:body>
	
</t:popup>
