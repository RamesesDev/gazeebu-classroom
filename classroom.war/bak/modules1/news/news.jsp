<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
	$put( "news" ,
		new function() {
			var svc = ProxyService.lookup("NewsfeedService");
			this.list;
			var self = this;
			this._controller;
			this.classid = "${param['classid']}";
			this.onload = function() {
				this.list = svc.getUserMessages({channelid: this.classid});
				Session.handler = function( o ) {
					if(o.msgtype) {
						self.list.push( o );
						self._controller.refresh();
					}
				}
			}
		}
	);	
</script>

<style>
	.bulletin td{
		font-size:12px;font-family:arial;padding:6px;
	}
	.announcement {
		background-color:green;color:white;padding:4px;text-align:center;font-size:10px;;
	}
</style>

<t:content title="News">
	<div id="msg"></div>
	<table width="100%">
		<tr>
			<td valign="top">
				<div r:context="news" r:visibleWhen="#{list.length != 0}">
					<table width="550" r:context="news" r:items="list" r:varName="item" cellpadding="0" cellspacing="0" class="bulletin">
						<tbody>
							<tr>
								<td valign="top" align="left" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="2">
									<div class="#{item.msgtype}">#{item.msgtype}</div>
								</td>
								<td valign="top">
									#{item.message}	
								</td>
							</tr>
							<tr>
								<td style="border-bottom:1px solid lightgrey">
									<div style="font-size:11px;color:gray;">posted on #{item.dtfiled} by #{item.sendername}</div> 
								</td>
							</tr>
						</tbody>
					</table>	
				</div>
				<div r:context="news" r:visibleWhen="#{list.length==0}">
					<i>There are no messages yet</i>
				</div>	
			</td>
			<td valign="top" width="150">
				<table style="font-size:11px;">
					<tr>
						<td style="font-size:12px;">
							Go Mobile!<br>
							<a r:context="news" r:name="subscribe">Subscribe to SMS</a> 
							to see messages posted in this bulletin sent to your cellphone. 	
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</t:content>

