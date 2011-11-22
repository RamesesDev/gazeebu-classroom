<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getAll" params="${params}" var="INFO"/>
<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="CLASS_INFO"/>

<t:content title="Grade Settings">

	<jsp:attribute name="head">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/js/ext/colorpicker/colorpicker.css"></link>
		<script src="${pageContext.request.contextPath}/js/ext/colorpicker/colorpicker.js"></script>
	</jsp:attribute>

   <jsp:attribute name="script">
		$register({id:"edit_criteria", page:"apps/grading/edit_criteria.jsp", title:"Grading Criteria", context:"edit_criteria", options:{width:500,height:400}});
		$register({id:"edit_period", page:"apps/grading/edit_period.jsp", title:"Grading Period", context:"edit_period", options:{width:600,height:400}});
		$register({id:"edit_eq", page:"apps/grading/edit_eq.jsp", title:"Grading Equivalents", context:"edit_eq", options:{width:350,height:500}});
		
		$put( "grading_criteria", 
			new function() {
				this._controller;
				var self = this;
				var saveHandler = function(){self._controller.reload();} 
				this.editCriteria = function() {
					return new PopupOpener("edit_criteria", {saveHandler: saveHandler} );
				}
				this.editPeriod = function() {
					return new PopupOpener("edit_period", {saveHandler: saveHandler});
				}
				this.editEq = function() {
					return new PopupOpener("edit_eq", {saveHandler: saveHandler});
				}
			}
		);	
   </jsp:attribute>
   
   <jsp:attribute name="style">
		.subtitle {
			background-color: lightgrey;
			padding:5px;
		}
		.subtitle-font {
			font-size:18px;
			font-weight:bolder;
			background-color: lightgrey;
			padding:5px;
		}
   </jsp:attribute>
   
   <jsp:body>
		<c:if test="${CLASS_INFO.usertype == 'teacher'}">
			<p>
				Configure the settings that you will need to compute the grades. Click <a>Here</a> to view how this works. 
			</p>
		</c:if>
		
		<table width="80%" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2" class="subtitle-font">Grading Criteria</td>
				<td align="right" class="subtitle">
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						<a r:context="grading_criteria" r:name="editCriteria">Edit</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<c:forEach items="${INFO.criteriaList}" var="item">
				<tr>
					<td width="50" align="center"><div style="width:10px;height:10px;background-color:${item.colorcode}">&nbsp;</div></td>
					<td style="font-size:12px;font-weight:bolder;">${item.title} &nbsp;&nbsp;&nbsp;(${item.weight}%)</td>
					<td>&nbsp;</td>
				</tr>
				<c:if test="${! empty item.subcriteria}">
					<tr>
						<td>&nbsp;</td>
						<td colspan="2" style="padding-left:10px;font-size:10px;">
							<c:forEach items="${item.subcriteria}" var="cat">
								${cat.title} &nbsp;&nbsp;&nbsp;(${cat.weight}%)<br>
							</c:forEach>
						</td>
					</tr>
				</c:if>			
			</c:forEach>
		</table>
		
		<br>
		<table width="80%" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="3" class="subtitle-font">Grading Period (Optional)</td>
				<td align="right" class="subtitle">
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						<a r:context="grading_criteria" r:name="editPeriod">Edit</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<c:forEach items="${INFO.gradingPeriods}" var="item">
				<tr>
					<td width="50">&nbsp;</td>
					<td style="font-size:12px;font-weight:bolder;">${item.title}</td>
					<td>from ${item.fromdate} to ${item.todate}</td>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
		
		
		<br>
		<table width="80%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="subtitle-font">Grade Equivalents</td>
				<td align="right" class="subtitle">
					<c:if test="${CLASS_INFO.usertype == 'teacher'}">
						<a r:context="grading_criteria" r:name="editEq">Edit</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<c:if test="${! empty INFO.gradingEq}">
				<tr>
					<td style="padding-left:10px;">
						<table width="300">
							<tr>
								<th>From</th>
								<th>To</th>
								<th>Eq. Grade</th>
							</tr>
							<c:forEach items="${INFO.gradingEq}" var="item">
								<tr>
									<td align="center">${item.rangefrom} %</td>
									<td align="center">${item.rangeto} %</td>
									<td align="center">${item.title}</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
			</c:if>
		</table>	
		
   </jsp:body>
   
</t:content>
