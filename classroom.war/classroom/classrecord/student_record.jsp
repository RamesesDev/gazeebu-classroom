<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>


<%
	Map map = new HashMap();
	map.put( "classid", request.getParameter("classid"));
	map.put( "studentid", request.getParameter("studentid") );
	request.setAttribute( "params", map );
%>

<s:invoke service="ClassrecordService2" method="getStudentRecord" params="${params}" var="INFO" debug="true"/>

<t:content>
	
	<jsp:attribute name="style">
		.activities {
			border-right: solid 1px #bbb;
			border-bottom: solid 1px #bbb;
			box-shadow: 0 4px 10px #bbb;
			-moz-box-shadow: 0 4px 10px #bbb;
			-webkit-box-shadow: 0 4px 10px #bbb;
		}
		.activities td.first,
		.activities th.first { border-left: solid 1px #bbb; }

		.activities td,
		.activities th { 
			padding: 2px 3px;
			border-bottom: solid 1px #ccc;
			border-right: solid 1px #bbb;
		}
		
		.activities tr.activity { background: #c5c5f0; }
		.activities tr.activity .title { text-indent: 10px; }
		.activities tr.period .title { text-indent: 20px; }
		.activities td.item { text-indent: 30px; }
		
		.activities tr.criteria td { 
			background: #a3a3c2; 
			border-bottom: solid 1px #bbb;
			padding: 4px 3px;
			font-size: 13px;
			font-weight: bold;
		}
		.activities tr.period td { 
			background: #d6fac8; 
			font-weight: bold;
		}
		.activities span.block {
			display: inline-block;
			width: 150px;
		}
		.activities .failed { color:red; }
	</jsp:attribute>
	
	<jsp:attribute name="title">
		<table class="page-form-table" width="80%" cellpadding="0" cellspacing="0">
            <tr>
                <td rowspan="4" width="60" style="padding-right:10px;">
					<img src="profile/photo.jsp?id=${INFO.student.objid}&t=thumbnail"/>
                </td>
            </tr>
            <tr>
                <td class="caption capitalized" style="font-size:14px;">
                    ${INFO.student.firstname} ${INFO.student.lastname}
                </td>
                <td>
                    <img src="img/phone.png" style="padding-right:5px;"/>
                    ${INFO.student.mobile}
                </td>
            </tr>
            <tr>
                <td>
                    <i>${INFO.student.username}</i>
                </td>
                <td>
                    <img src="img/email.png" style="padding-right:5px;"/>
                    ${INFO.student.email}
                </td>
            </tr>
			<tr>
                <td>
                    ${INFO.student.usertype} ${INFO.student.objid=='${USER_INFO.objid}' ? '(me)' : ''}
                </td>
            </tr>			
        </table>
	</jsp:attribute>
	
	<jsp:attribute name="rightpanel">
		<div class="right" style="width:90%">
			<c:if test="${not empty INFO.criteriaTitles}">
				<h3>Criteria</h3>
				<div class="hr"></div>
				<ul>
					<c:forEach items="${INFO.criteriaTitles}" var="item">
						<li><b>${item.title}</b> (${item.weight}%)</li>
					</c:forEach>
				</ul>
				<br/>
			</c:if>
			
			<c:if test="${not empty INFO.periodList}">
				<h3>Periods</h3>
				<div class="hr"></div>
				<ul>
					<c:forEach items="${INFO.periodList}" var="item">
						<li><b>${item.title}</b></li>
					</c:forEach>
				</ul>
				<br/>
			</c:if>
		</div>
	</jsp:attribute>	
		
	<jsp:body>
		<h3>
			Activities
		</h3>
		<div class="hr"></div>
		
		<c:if test="${empty INFO.activities}">
			<div>
				<i>No activity.</i>
			</div>
		</c:if>
		
		<c:forEach items="${INFO.activities}" var="item" varStatus="stat">
			<c:set var="criteria" value="${INFO.criteria[item.criteriaid]}"/>
			<table class="activities" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr class="criteria">
					<td class="first" colspan="6" align="left">
						${criteria.title }
						<span class="right align-r">
							<span class="block">
								Total: ${empty criteria.score? '-' : criteria.score} / ${empty criteria.totalscore? '-' : criteria.totalscore}
							</span>
							<span class="block">
								Percentage: ${empty criteria.percentage? '-' : criteria.percentage} ${empty criteria.percentage? '' : '%'}
							</span>
						</span>
					</td>
				</tr>
				<tr class="activity">
					<th class="title first" width="120px" align="left">Activity</th>
					<th width="100px">Date</th>
					<th width="60px" align="center">Score Result</th>
					<th width="60px" align="center">Percentage</th>
					<th width="60px">Passing Score</th>
					<th>Remarks</th>
				</tr>
				<c:forEach items="${item.items}" var="activity">
					<c:set var="period" value="${empty activity.periodid? null : INFO.periodMap[activity.periodid]}"/>
					<c:if test="${prev_period.title != period.title}">
						<c:set var="pkey" value="${item.criteriaid}${activity.periodid}"/>
						<c:set var="ptotal" value="${INFO.periodTotals[pkey]}"/>
						<tr class="period">
							<td class="title first" colspan="6">
								${period.title} (Period)
								<span class="right align-r">
									<span class="block">
										Total: ${ptotal.score} / ${ptotal.totalscore}
									</span>
									<span class="block">
										Percentage: ${empty ptotal.percentage? '-' : ptotal.percentage} ${empty ptotal.percentage? '' : '%'}
									</span>
								</span>
							</td>
						</tr>
					</c:if>
					<tr class="period-${period.index}">
						<td class="item first" valign="top">
							${activity.title}
						</td>
						<td align="center" valign="top">
							${activity.activitydate}
						</td>
						<td align="center" valign="top">
							<span class="${activity.scorestate}">
								${empty activity.score ? '-' : activity.score}
							</span>
							/ ${activity.totalscore}
						</td>
						<td class="${activity.scorestate}" align="center" valign="top">
							${empty activity.percentage? '-' : activity.percentage}
							${not empty activity.percentage? '%' : ''}
						</td>
						<td align="center" valign="top">
							${empty activity.passingscore? '-' : activity.passingscore}
						</td>
						<td valign="top">
							${empty activity.remarks? '-' : activity.remarks}
						</td>
					</tr>
					<c:set var="prev_period" value="${period}"/>
				</c:forEach>
			</table>
			<br/>
		</c:forEach>
	</jsp:body>
	
</t:content>


	