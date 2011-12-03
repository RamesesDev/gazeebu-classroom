<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:popup>

    <jsp:attribute name="style">
        
    </jsp:attribute>

	<jsp:attribute name="script">
		$put(
			"lookup_member",
			new function() {
				this.selectHandler;
				this.members;
				this.userid;
				var self = this;
				this.selection = [];
				
				this.onload = function() {
					this.members = $ctx('classroom').classInfo.members;
					this.members.removeAll(
						function(o) {
							return o.objid == "${SESSION_INFO.userid}";
						}
					)	
				}
				this.select = function() {
					var bag = [];
					this.selection.each(
						function(idx) {
							bag.push( self.members[idx] );
						}
					)
					this.selectHandler(bag);
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="lookup_member" r:name="select" value="OK"/>
	</jsp:attribute>
	
    <jsp:body>
		<table r:context="lookup_member" r:items="members" r:varName="item" r:varStatus="stat">
			<tr>
				<td rowspan="2" valign="top" width="25">
					<input type="checkbox" r:context="lookup_member" r:name="selection" r:mode="set" r:checkedValue="#{stat.index}"/>
				</td>
				<td rowspan="2" valign="top">
					<img width="30px" src="profile/photo.jsp?id=#{item.objid}&t=thumbnail&v=#{item.info.photoversion}">
				</td>
				<td>#{item.lastname}, #{item.firstname}</td>
			</tr>
			<tr>
				<td><i>#{item.usertype}</i></td>
			</tr>
		</table>
    </jsp:body>
	
</t:popup>
