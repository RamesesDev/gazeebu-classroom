<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
	
	<script>
		$put( "test",
			new function() {
				this.list = [{uid:"1", msg:"Hello"},{uid:"2", msg:"Hello2"},{uid:"1", msg:"Hello3"} ];
				this.links = {
					"1" : {name:"Elmo"},
					"2" : {name:"Jay"},
					"3" : {name:"Windhel"}
				}
			}
		);	
	</script>
	
	<table r:context="test" r:items="list" r:varName="item">
		<tr>
			<td>#{item.msg} #{item['uid']}</td>
		</tr>
	</table>
	
</t:public>