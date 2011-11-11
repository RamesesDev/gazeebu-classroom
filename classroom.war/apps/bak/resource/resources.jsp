<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<script>
	$put("resources",
		new function(){
			this.categories = [ {name:"Syllabus"}, {name:"Exam Templates"}, {name:"Research"} ]
		}
	);
</script>
<style>
	ul {
		font-size:11px;
		list-style-type:square;
	}
	li.selected {
		background-color:red;	
	}
</style>


<t:content title="Resources">

	<jsp:attribute name="actions">
		<input type="button" r:context="resources" r:name="save" value="Add" /> 
	</jsp:attribute>

	<jsp:body>
		<table width="100%" cellpadding=0" cellspacing="0">
			<tr>
				<td valign="top" width="150">
					<ul r:context="resources" r:items="categories" r:varName="item">
						<li>#{item.name}</li> 
					</ul>
				</td>
				<td valign="top">
					<table border="1" cellpadding="0" cellspacing="0" class="attendance" r:context="edit_attendance" r:items="list" r:varName="item" r:varStatus="stat" width="100%">
					</table>
				</td>
			</tr>
			
		</table>
	
	</jsp:body>
	
</t:content>


