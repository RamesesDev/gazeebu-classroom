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
				//alert( $.toJSON(this.entry) );
				//svc.create( this.entry );
				return "_close";
			}
        }
    );    
</script>

<t:popup>

	<jsp:attribute name="leftactions">
		<input type="button" r:context="subscribe_sms" r:name="subscribe" value="Subscribe"/>
	</jsp:attribute>
	
	<jsp:body>
		At this time, only Sun phones can be registered. If you're using sun 
		cellular. Please read disclaimer first before proceeding.<br><br>
		<input type="checkbox" r:name="entry.messageTypes" r:context="subscribe_sms" r:mode="set" r:checkedValue="announcement"/>Announcements<br>
		<input type="checkbox" r:name="entry.messageTypes" r:context="subscribe_sms" r:mode="set" r:checkedValue="grade"/>Grades<br>
		<input type="checkbox" r:name="entry.messageTypes" r:context="subscribe_sms" r:mode="set" r:checkedValue="todo"/>To do<br>
		<input type="checkbox" r:name="entry.messageTypes" r:context="subscribe_sms"  r:mode="set" r:checkedValue="examresult"/>Exam Results<br>
		
	</jsp:body>
	
</t:popup>

