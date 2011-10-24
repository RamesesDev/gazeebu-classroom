<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Mobile Settings">
   <script>
		$register({id:"customkeyword", page:"profile/customkeyword.jsp", context:"customkeyword"});
	  
		$put(
			"mobilesettings",
			new function() 
			{
				var svc = ProxyService.lookup('sms/SubscriptionService');
				var self = this;
			
				this.userid = "${SESSION_INFO.userid}";
				this.oldentity;
				this.entity;
				this.subscriptions = svc.getSubscriptions( {userid: this.userid} );
				this.flag;

				this.onload = function() {
					this.oldentity = {};
					this.entity = {
						announcement: 0, 'private': 0, examresults: 0
					};
					this.subscriptions.each(function(it){
						if( it.msgtype == 'announcement' ) {
							self.entity.announcement = 1;
							self.entity.announcement_num = it.phone;
						}
						else if( it.msgtype == 'private' ) {
							self.entity.private = 1;
							self.entity.private_num = it.phone;
						}
						else if( it.msgtype == 'examresults' ) {
							self.entity.examresults = 1;
							self.entity.examresults_num = it.phone;
						}
					});
					for( var i in this.entity ) this.oldentity[i] = this.entity[i];
				}
				
				this.save = function() {
				   var stypes = [];
				   var utypes = [];
				   if( this.entity.announcement == 1 ) stypes.push('announcement'); else utypes.push('announcement');
				   if( this.entity.private == 1 ) stypes.push('private'); else utypes.push('private');
				   if( this.entity.examresults == 1 ) stypes.push('examresults'); else utypes.push('examresults');
				   
				   var p = {userid: this.userid, subscribe: stypes, unsubscribe: utypes};
				   this.subscriptions = svc.update(p);
				   this.onload();
				}

				this.remove = function() {
				   this.customkeywords.splice(this.flag, 1);
				}
			}
		);
   </script>
   <div style="float:top;">
      <table class="page-form-table" 
            style="border-bottom:1px solid #a5aa84;"
            width="100%" cellpadding="0" cellspacing="0" border="0" >
         <tr>
            <td>
               <b>Subscription</b>
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
				<label>
					<input type="checkbox" r:context="mobilesettings" r:name="entity.announcement" r:checkedValue="1" r:uncheckedValue="0"/>
					Announcement
				</label>
				<label r:context="mobilesettings">#{entity.announcement_num? '('+entity.announcement_num+')' : ''}</label>
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
				<label>
					<input type="checkbox" r:context="mobilesettings" r:name="entity.private" r:checkedValue="1" r:uncheckedValue="0"/>
					Private Message
				</label>
				<label r:context="mobilesettings">#{entity.private_num? '('+entity.private_num+')' : ''}</label>
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px;">
				<label>
					<input type="checkbox" r:context="mobilesettings" r:name="entity.examresults" r:checkedValue="1" r:uncheckedValue="0"/>
					Exam Results
				</label>
				<label r:context="mobilesettings">#{entity.examresults_num? '('+entity.examresults_num+')' : ''}</label>
            </td>
         </tr>
         <tr>
            <td style="padding-left:15px; padding-bottom:15px; margin-bottom:15px;">
               <input type="button" r:context="mobilesettings" r:name="save" value="Save Settings"/>
            </td>
         </tr>
      </table>
   </div>
</t:content>
