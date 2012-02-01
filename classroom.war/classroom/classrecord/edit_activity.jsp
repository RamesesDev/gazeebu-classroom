<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassrecordService2" method="getActivityResult" params="${param['activityid']}" var="INFO"/>

<t:popup>

	<jsp:attribute name="style">
		.edit_result td {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("edit_result",
			new function() {
				var svc = ProxyService.lookup( "ClassrecordService2" );
				this.results = [];
				this.saveHandler;
				<c:forEach items="${INFO.results}" var="item">
				this.results.push( {objid:"${item.objid}", studentid:"${item.studentid}", activityid: "${item.activityid}", score:"${item.score}", remarks:"${item.remarks}"}  );
				</c:forEach>	
				
				this.save = function() {
					svc.saveActivityResults( this.results );
					this.saveHandler(); 
					return "_close";
				}
			}
		);	
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_result" r:name="save" value="Save"/>
	</jsp:attribute>
	
	<jsp:body>
		<table class="edit_result">
			<tr>
				<td width="100"><b>Title</b></td>
				<td>:</td>
				<td>${INFO.title}</td>
				<td width="50">&nbsp;</td>
				<td><b>Highest Possible Score</b></td>
				<td>:</td>
				<td>${INFO.totalscore}</td>
			</tr>
			<tr>
				<td><b>Date</b></td>
				<td>:</td>
				<td>${INFO.activitydate}</td>
				<td>&nbsp;</td>
				<td><b>Passing Score</b></td>
				<td>:</td>
				<td>${empty INFO.passingscore? '-' : INFO.passingscore}</td>
			</tr>
		</table>
	
		<p>
			Enter the results for this activity. If not applicable to a particular student, leave it blank.
		</p>
		<table class="edit_result">
			<tr>
				<td width="100"><b>Student</b></td>
				<td width="50"><b>Raw Score</b></td>
				<td width="200"><b>Remarks</b></td>
			</tr>
			<c:forEach items="${INFO.results}" var="item" varStatus="stat">
				<tr>
					<td width="100">${item.lastname},${item.firstname}</td>
					<td><input type="text" r:context="edit_result" r:name="results[${stat.index}].score" style="width:50"/></td>
					<td><input type="text" r:context="edit_result" r:name="results[${stat.index}].remarks" style="width:200"/></td>
				</tr>
			</c:forEach>
		</table>
	</jsp:body>
	
</t:popup>


