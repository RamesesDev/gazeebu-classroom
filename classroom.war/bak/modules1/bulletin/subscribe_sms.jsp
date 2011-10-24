<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>


<script>	
    $put("subscribe_sms", 
	
        new function() {
			this.entry = {messageTypes:[]};
			
			var svc = ProxyService.lookup("SMSSubscriptionService");
			this.onload = function() {
				this.entry.messageTypes = svc.getSubscriptions();		
			}
		
			this.subscribe = function() {
				svc.create( this.entry );
				return "_close";
			}
        }
    );    
</script>

<t:popup>

	<jsp:attribute name="leftactions">
		<input type="button" context="subscribe_sms" name="subscribe" value="Subscribe"/>
	</jsp:attribute>
	
	<jsp:body>
		At this time, only Sun phones can be registered. If you're using sun 
		cellular. Please read disclaimer first before proceeding.<br><br>
		<input type="checkbox" name="entry.messageTypes" context="subscribe_sms" mode="set" checkedValue="announcement"/>Announcements<br>
		<input type="checkbox" name="entry.messageTypes" context="subscribe_sms" mode="set" checkedValue="grade"/>Grades<br>
		<input type="checkbox" name="entry.messageTypes" context="subscribe_sms" mode="set" checkedValue="todo"/>To do<br>
		<input type="checkbox" name="entry.messageTypes" context="subscribe_sms"  mode="set" checkedValue="examresult"/>Exam Results<br>
		
	</jsp:body>
	
</t:popup>

