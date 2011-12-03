<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:secured>

	<jsp:attribute name="style">
		.title {
			font-weight:bolder;
			color:darkslateblue;
			size:15px;
			padding-top:10px;
		}	
		.submenu {
			padding-left:10px;
			size: 12px;
		}
		.menupanel {
			padding: 5px;
			padding-left:15px;
		}
		.panel {
			background-color: white;
			border:1px solid lightgrey;			
		}
	</jsp:attribute>
	
	<jsp:attribute name="script">
		$register({id: "docs", page: "library/docs.jsp", context: "docs"});

		$put("library",
			new function() {
				if(! window.location.hash ) {
					window.location.hash = "docs";
				}
			}
		);	
	</jsp:attribute>

	
	<jsp:body>
		<table width="100%" height="520" class="panel">
			<tr>
				<td valign="top" width="120" height="100%" class="menupanel">
					<div class="title">LIBRARY</div>
					<div class="submenu"><a href="#docs">Documents</a></div>
					<div class="title">STORE</div>
				</td>
				<td style="border-left:1px solid lightgrey;width:5px;">&nbsp;</td>
				<!-- RIGHT PANEL -->
				<td valign="top" id="content">
					&nbsp;
				</td>
			</tr>
		</table>	
   </jsp:body>

</t:secured>
