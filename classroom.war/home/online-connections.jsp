<script type="text/javascript">
	$put(
		'online-connections',
		new function()
		{
			var svc = ProxyService.lookup("ClassConnectionService");
			var self = this;
		
			this.listModel = {
				fetchList: function(o) {
					svc.getOnlineConnections(function(list){
						self.listModel.setList( list );
					});
				}
			}

			this.onload = function() {
				Session.handlers.classroom = function(o) {
					if(o.classroom && o.classroom == classid ) {
						self.listModel.refresh(true);
					}
				}
			}
		}
	);
</script>

<div class="section-title">
	Online Connections
</div>
<div class="hr"></div>
<div class="online-list scrollpane">
	<table r:context="online-connections" r:model="listModel" r:varName="item" width="100%" cellspacing="0">
		<tr>
			<td width="30">
				<div class="thumb">
					<img src="profile/photo.jsp?id=#{item.objid}&t=thumbnail&v=${item.info.photoversion}"
						 width="25"/>
				</div>
			</td>
			<td>
				<span class="capitalized">
					#{item.lastname}, #{item.firstname}
				</span>
			</td>
		</tr>
	</table>
</div>