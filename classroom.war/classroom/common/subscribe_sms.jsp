<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<s:invoke service="ClassroomService" method="getCurrentUserInfo" params="${param['classid']}" var="USER_INFO"/>

<t:popup>

	<jsp:attribute name="head">
		<script type="text/javascript">
			$put(
				"subscribe_sms",
				new function() 
				{
					var self = this;
					var svc = ProxyService.lookup("SMSSubscriptionService");
					
					this._controller;
					this.thread;
					this.msgtype;
					this._caller;
					this.data = {classid: "${param['classid']}", msgtypes:[]};				
					
					this.msgtypes = ['bulletin','discussion','private'];				
					this.usertype = "${USER_INFO.usertype}";
					
					this.sendsms;
					this.keyword;
					
					this.onload = function() {
						var m = {classid: "${param['classid']}", msgtype: this.msgtypes }
						var subs = svc.getSubscriptions( m );	
						if(subs.length > 0) {
							this.data.phone = subs[0].phone;
							$(subs).each(function(i,e){
								if( e.keyword ) {
									if( self.usertype == 'teacher' && e.msgtype == 'bulletin' )
										self.sendsms = true;
									else if( e.msgtype == 'private' && e.keyword )
										self.sendsms = true;
										
									if( self.sendsms ) {
										self.keyword = e.keyword;
										self.propertyChangeListener.sendsms(true);
									}
								}
								self.data.msgtypes.push(e.msgtype); 
							});
						}
					}

					this.update = function() {
						this.data.oldmsgtypes = this.msgtypes;
						
						if( this.sendsms ) {
							if( !this.keyword ) throw new Error('Keyword is required.');

							if( this.usertype == 'teacher' ) {
								this.data.bulletin_keyword = this.keyword;
								if( this.data.msgtypes.indexOf('bulletin') < 0 ) {
									this.data.msgtypes.push('bulletin');
								}
							}
							else {
								this.data.private_keyword = this.keyword;
								if( self.data.msgtypes.indexOf('private') < 0 ) {
									this.data.msgtypes.push('private');
								}
							}
						}
						
						svc.updateSubscriptions( this.data );
						return "_close";			
					}
					
					this.propertyChangeListener = {
						'sendsms' : function(o) {
							var inp = $('#send_sms_keyword');
							if( o ) inp.removeAttr('readonly');
							else    inp.attr('readonly', 'readonly');
						}
					};
				}
			);
		</script>
	</jsp:attribute>
	
	<jsp:attribute name="rightactions">
		<input type="button" r:context="subscribe_sms" r:name="update" value="Save"/>
		<input type="button" r:context="subscribe_sms" r:name="_close" r:immediate="true" value="Cancel"/>
	</jsp:attribute>
	
    <jsp:body>
		<div><b>Your Mobile phone No:</b></div>
		<div><input type="text" r:context="subscribe_sms" r:name="data.phone" r:required="true" r:caption="Mobile number"/>
		<br>
		<h2>Receiving Messages</h2>
		<label>
			<input type="checkbox" r:context="subscribe_sms" r:name="data.msgtypes" r:mode="set" r:checkedValue="bulletin" r:depends="bulletin_sms">
			Receive messages from bulletin board
		</label>
		<br>
		<label>
			<input type="checkbox" r:context="subscribe_sms" r:name="data.msgtypes" r:mode="set" r:checkedValue="discussion">
			Receive messages from discussion board
		</label>
		<br>
		<label>
			<input type="checkbox" r:context="subscribe_sms" r:name="data.msgtypes" r:mode="set" r:checkedValue="private" r:depends="private_sms">
			Receive private messages
		</label>
		<br>
		
		<h2>Sending Messages using mobile.</h2> 
		<label>
			<input type="checkbox" r:context="subscribe_sms" r:name="sendsms">
			I want to send message from my mobile phone.
		</label>
		<br/>
		<i>Type in your keyword and send to 09229990188.</i><br>
		<c:if test="${USER_INFO.usertype=='teacher'}">
			<input id="send_sms_keyword" type="text" r:context="subscribe_sms" r:name="keyword" readonly="readonly">Send message to bulletin.<br>
		</c:if>
		<c:if test="${USER_INFO.usertype=='student'}">
			<input id="send_sms_keyword" type="text" r:context="subscribe_sms" r:name="keyword" readonly="readonly">Send message to teacher<br>
		</c:if>
    </jsp:body>
	
</t:popup>
