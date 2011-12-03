<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>
	<jsp:attribute name="script">
		$put("view_embed", 
			new function() {
				
				this.handler;
				
				this.showCode = function() {
					return this.handler();
				}
				
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="view_embed" r:name="_close" value="Close"/>
	</jsp:attribute>
	
   <jsp:body>
		<table width="100%" height="100%">
			<tr>
				<td align="center">
					<label r:context="view_embed">
						#{showCode()}
					</label>
				</td>
			</tr>
		</table>
		<div class="hr"></div>
	</jsp:body>
</t:popup>



