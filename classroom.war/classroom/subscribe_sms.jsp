<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>

    <jsp:attribute name="style">
        
    </jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"subscribe_sms",
			new function() {
				this.saveHandler;
				this.thread;
				this.msgtype;
				this._caller;
				this.data = { classid: "${param['classid']}" };
				this.subscribed = "0";
				
				this.onload = function() {
					
				}
				
				this.subscribe = function() {
					alert('save')
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="subscribe_sms" r:name="subscribe" value="Subscribe" />
	</jsp:attribute>
	
    <jsp:body>
		<div>
			<input type="checkbox" r:context="subscribe_sms" r:name="subscribed" />
			<label r:context="subscribe_sms">I want to receive messages from the <b>#{msgtype} feed<b></label>
		</div>
		<br>
		
		<div>Your Mobile phone No:</div>
		<div><input type="text" r:context="subscribe_sms" r:name="data.phone"/>
		<div>Enter Keyword to send messages from the phone</div>
		<div><input type="text" r:context="subscribe_sms" r:name="data.keyword"/>
    </jsp:body>
	
</t:popup>
