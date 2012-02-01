<div id="attachment_info" style="display:none;width:250px;">
	<div r:type="label" r:context="thread" style="display:block;">
		<div style="font-size:11px;color:#444;font-weight:normal;">
			<b>Description: </b><i>#{selectedAttachment.message? selectedAttachment.message : 'No description.'}</i>						
			<br/>
			<span style="color:gray">
				#{users[selectedAttachment.userid].lastname}, #{users[selectedAttachment.userid].firstname}
				<br/>
				Posted #{selectedAttachment.dtposted}
			</span>
		</div>
		<div class="hr"></div>
		<div class="align-r">
			<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'link'}">
				<a href="#{selectedAttachment.linkref}" target="_blank">View</a>
			</span>
			<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'embed'}">
				<a r:context="thread" r:name="viewEmbed">View</a>
			</span>
			<span r:context="thread" r:visibleWhen="#{selectedAttachment.reftype == 'library'}">
				<span r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'doc'}">
					<a href="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
						View
					</a>
				</span>
				&nbsp;
				<span r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'doc'}">
					<a href="library/downloadres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
						Download
					</a>
				</span>
				<span class="photo" r:context="thread" r:visibleWhen="#{selectedAttachment.libtype == 'picture'}">
					<a href="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" target="_blank">
						<img src="library/viewres.jsp?id=#{selectedAttachment.linkref}&ct=#{selectedAttachment.content_type}" height="20px" />
					</a>
				</span>
			</span>
			&nbsp;
			<a r:context="thread" r:name="editAttachment" r:visibleWhen="#{selectedAttachment.userid == '${SESSION_INFO.userid}'}"
			   title="edit attachment">
				edit
			</a>
			&nbsp;
			<a r:context="thread" r:name="removeAttachment" r:visibleWhen="#{selectedAttachment.userid == '${SESSION_INFO.userid}'}"
			   title="remove attachment">
				remove
			</a>
		</div>
	</div>
</div>