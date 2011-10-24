<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<script>
	$put( "discussion",
		new function() {
			this.listModel = {
				rows: 10,
				fetchList : function(o) {
					return [
						{topic: "Regarding lesson today, what does it mean to be 'human'?", poster:"elmo"}
					];
				}
			};
		}
	);
</script>


<t:content title="Discussion"> 
	<jsp:attribute name="actions">
		
	</jsp:attribute>
	
	<jsp:body>
		<table width="100%" cellpadding="0" cellspacing="0">
		
			<tr>
				<td valign="top">
					<table width="100%" context="discussion" model="listModel" cellpadding="0" cellspacing="0" varName="item">
						<tbody>
							<tr>
								<td>#{item.topic}</td>
							</tr>
						</tbody>
					</table>				
				</td>
				<td>
				
				
				</td>
			</tr>
		
		</table>
		
		
		
	</jsp:body>

</t:content>








