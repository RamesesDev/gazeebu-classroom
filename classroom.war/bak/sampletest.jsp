
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:public redirect_session="false">
	<jsp:attribute name="head">
		<script src="js/ext/calendar.js"></script>
		<script>
			$put("sample", 
				new function() {
					var svc = ProxyService.lookup("EventService");
					this.events; 
					var self = this;
					this.calendar;	
					this.onload = function() {
						this.events = svc.getEvents();
						this.calendar = new Calendar();
						this.calendar.days = ["S","M","T","W","T","F","S"]
						this.calendar.div = document.getElementById( "calendar" );
						
						this.calendar.handler = {
							getCell : function(o) {
								return self.events[ o.getFullYear()+"-"+(o.getMonth()+1)+"-"+o.getDate() ];
							}		
						}
						
						this.calendar.show();
					}
				}
			);	
		</script>
		<style>
			.calendar-heading {
				background:yellow;
				font-weight:bolder;
			}
		</style>
	</jsp:attribute>
	
	<jsp:body>
		<table style="width:500;height:400">
			<tr>
				<td height="390">
					<div id="calendar" style="width:100%;height:100%"></div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" r:context="sample" r:name="calendar.movePrev" value="Prev"/>
					<input type="button" r:context="sample" r:name="calendar.moveNext" value="Next"/>		
				</td>
			</tr>
		</table>
	</jsp:body>
	
	
	
</t:public>