<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ExamService" method="getExamResult" params="${param['examid']}" var="INFO"/>

<t:popup>

	<jsp:attribute name="style">
		.edit_result td {
			font-size:11px;
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$put("edit_result",
			new function() {
				var svc = ProxyService.lookup( "ExamService" );
				this.results = [];
				this.saveHandler;
				<c:forEach items="${INFO.results}" var="item">
				this.results.push( {objid:"${item.objid}", studentid:"${item.studentid}", examid: "${item.examid}", score:"${item.score}", remarks:"${item.remarks}"}  );
				</c:forEach>	
				
				this.save = function() {
					svc.saveResults( this.results );
					if(this.saveHandler) this.saveHandler(this.results); 
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
				<td>${INFO.title}</td>
				<td width="50">&nbsp;</td>
				<td><b>Max Score</b></td>
				<td>${INFO.maxscore}</td>
			</tr>
			<tr>
				<td><b>Date</b></td>
				<td>${INFO.examdate}</td>
				<td>&nbsp;</td>
				<td><b>Passing Score</b></td>
				<td>${INFO.passingscore}</td>
			</tr>
		</table>
	
		<table class="edit_result">
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


