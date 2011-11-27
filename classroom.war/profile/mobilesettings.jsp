<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content title="Mobile Settings">
	<script>
		$register({id:"customkeyword", page:"profile/customkeyword.jsp", context:"customkeyword"});
	  
		$put(
			"mobilesettings",
			new function() 
			{
				var svc = ProxyService.lookup('SMSSubscriptionService');			
				
				var self = this;
				this._controller;
				this.subscriptions = svc.getSubscriptions( {userid: "${SESSION_INFO.userid}"} );
				this.selected;
				
				this.edit = function() {
					var op = new PopupOpener('editmobile', {entity:this.selected, hander:function(){ self._controller.reload(); }});
					op.title = 'Edit Subscription';
					op.options = {width: 400, height: 200};
					return op;
				}
				
				this.remove = function() {
					if( !confirm('Are you sure you want to remove this subscription?') ) return;
					svc.unsubscribe( this.selected );
					return '_reload';
				}
			}
		);
	</script>
	<style>
		.mobilesettings th { 
			text-align: left;
		}
		.mobilesettings tbody td { border-bottom: solid 1px #ddd; }
	</style>
	<div>
		<table r:context="mobilesettings" r:items="subscriptions" r:name="selected"
		       r:emptyText="You don't have any sms subscription yet." r:emptyTextStyle="font-style:italic;font-weight:bold"
			   class="page-form-table mobilesettings" style="border-bottom:1px solid #a5aa84;"
			   cellpadding="0" cellspacing="0" border="0" >
			<thead>
				<tr>
					<th width="80">Type</th>
					<th width="120">Mobile No.</th>
					<th width="200">Class</th>
					<th width="100">Keyword</th>
					<th>&nbsp;</th>
				</tr>
				<tr>
					<td colspan="5"><div class="hr"></div></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td valign="top">#{msgtype}</td>
					<td valign="top">#{phone}</td>
					<td valign="top">#{classname? classname : ''}#{schedules? '<br><i>'+schedules+'</i>' : ''}</td>
					<td valign="top">#{keyword? keyword : ''}</td>
					<td valign="top">
						<a r:context="mobilesettings" r:name="edit">Edit</a> |
						<a r:context="mobilesettings" r:name="remove">Remove</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</t:content>
