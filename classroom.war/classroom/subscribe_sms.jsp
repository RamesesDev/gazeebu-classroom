<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>

    <jsp:attribute name="style">
        
    </jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"subscribe_sms",
			new function() {
				var svc = ProxyService.lookup("SMSSubscriptionService");
				this.thread;
				this.msgtype;
				this._caller;
				this.data;
				this.subscribed = "0";
				
				this.onload = function() {
					var m = {classid: "${param['classid']}", msgtype: this.msgtype }
					this.data = svc.getSubscription( m );	
					if(!this.data) {
						this.subscribed = "0";
						this.data = {classid: "${param['classid']}", msgtype: this.msgtype};
					}	
					else {
						this.subscribed = "1";
					}
				}
				
				this.subscribe = function() {
					svc.subscribe( this.data );
					return "_close";
				}
				
				this.update = function() {
					svc.update( this.data );
					return "_close";			
				}
				
				this.unsubscribe = function() {
					if(confirm("You are about to remove your subscription from this feed. Continue?") == true ) {
						svc.unsubscribe( this.data );
						return "_close";
					}
				}
				
				this.propertyChangeListener = {
					"subscribed" : function(o) {
							
					}
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="subscribe_sms" r:name="subscribe" value="Subscribe" r:visibleWhen="#{subscribed == '0'}"/>
		
		<input type="button" r:context="subscribe_sms" r:name="unsubscribe" value="Unsubscribe" r:visibleWhen="#{subscribed == '1'}"/>
		<input type="button" r:context="subscribe_sms" r:name="update" value="Update" r:visibleWhen="#{subscribed == '1'}"/>
	</jsp:attribute>
	
    <jsp:body>
		<div>
			<input id="subscribe_sms" type="checkbox" r:context="subscribe_sms" r:name="subscribed" r:checkedValue="1"/>
			<label for="subscribe_sms" r:context="subscribe_sms">I want to receive messages from the <b>#{msgtype} feed<b></label>
		</div>
		<br>
		<br>
		<div>Your Mobile phone No:</div>
		<div><input type="text" r:context="subscribe_sms" r:name="data.phone"/>
		<br>
		<br>
		<div>Enter Keyword to send messages from the phone</div>
		<div><input type="text" r:context="subscribe_sms" r:name="data.keyword"/>
    </jsp:body>
	
</t:popup>
