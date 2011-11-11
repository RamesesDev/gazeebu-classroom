<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Grading">

   <jsp:attribute name="script">
		$put( "grading", 
			new function() {
				this.objid;
				this.entity = {}
				this._controller;
				this.gradinglist = [];
				this.addEntry = function() {
					var lastscore = 0;
					if(this.gradinglist.length > 0 ) {
						lastscore = this.gradinglist[this.gradinglist.length-1].to;
					}	
					this.gradinglist.push({from: lastscore});
				}
			}
		);	
   </jsp:attribute>
   
   <jsp:body>
		Define Grading for this class
		<table r:context="grading" r:items="gradinglist" r:varName="item" r:varStatus="stat" border="1" cellpadding="2" cellspacing="0" width="300">
			<thead>
				<tr>
					<td rowspan="2">Grade</td>
					<td colspan="2" align="center">% Range</td>
				</tr>
				<tr>
					<td align="center" width="100">From</td>
					<td align="center" width="100">To</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type=text r:context="grading" r:name="gradinglist[#{stat.index}].grade"/></td>
					<td width="100">#{item.from}</td>
					<td width="100"><input type=text r:context="grading" r:name="gradinglist[#{stat.index}].to" style="width:100%"/></td>
				</tr>
			</tbody>
		</table>	
		<a r:context="grading" r:name="addEntry">Add Entry</a> 
   </jsp:body>
   
</t:content>
