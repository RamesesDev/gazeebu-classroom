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
				this.subscriptions = svc.getSubscriptions( {userid: "${SESSION_INFO.userid}"} );
			}
		);
	</script>
	<div>
		<table r:context="mobilesettings" r:items="subscriptions" 
		       r:emptyText="You don't have any sms subscription yet." r:emptyTextStyle="font-style:italic;font-weight:bold"
			   class="page-form-table" style="border-bottom:1px solid #a5aa84;"
			   width="100%" cellpadding="0" cellspacing="0" border="0" >
			<tbody>
				<tr>
					<td>#{msgtype}</td>
					<td>#{phone}</td>
				</tr>
			</tbody>
		</table>
	</div>
</t:content>
