<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>
<%@ page import="java.util.*" %>

<%
	Map m = new HashMap();
	m.put("classid", request.getParameter("classid") );
	request.setAttribute( "params", m );
%>
<s:invoke service="GradingCriteriaService" method="getGradingEquivalents" params="${params}" var="INFO"/>


<t:popup>
	<jsp:attribute name="script">
		$register( {id:"#showbuild",context:"showbuild"} );
		$put( "edit_eq",
			new function() {
				var svc = ProxyService.lookup( "GradingCriteriaService" );
				this.saveHandler;
				this.entries = [];
				this.selectedItem;
				this.selectedIndex;
				var self = this;
				this.min;
				this.max;
				this._controller;
				this.listorder;
				
				this.onload = function() {
					this.entries = svc.getGradingEquivalents({classid: "${param['classid']}"});
					if(this.entries.length > 0) {
						this.min = this.entries[0].rangefrom;
						this.max = this.entries[this.entries.length-1].rangeto;
						this.listorder = (this.min == "0") ? "asc" : "desc";
					}
					else {
						//self.entries.push( {rangefrom: 0, rangeto: 100} );
					}
				}
				
				this.split = function() {
					var msg = "Enter ranges of numbers between " + this.selectedItem.rangefrom + " and " + this.selectedItem.rangeto + " and separate it with commas. ";
					var c = prompt( msg );	
					if(c) {
						var newlist = [];
						c.split(",").each(
							function(o) {
								try {
									var x = parseFloat(o);
									if( self.listorder == "asc" && x > self.selectedItem.rangefrom && x < self.selectedItem.rangeto ) {
										newlist.push( x );
									}
									else if(self.listorder == "desc" && x < self.selectedItem.rangefrom && x > self.selectedItem.rangeto ) {
										newlist.push( x );
									}
								}
								catch(e){}
							}
						)
						
						var tail = this.entries.splice( this.selectedIndex );
						var old = tail.splice(0, 1)[0];
						var sorted;
						if(this.listorder=="asc")
							sorted = newlist.sort(  function(a,b) {return a-b}  );
						else {
							sorted = newlist.sort(  function(a,b) {return b-a} );
						}	
						var sublist = [];	
						var t = {rangefrom:old.rangefrom};
						sorted.each(
							function(o) {
								if( t.rangefrom != o ) {
									t.rangeto = o;
									sublist.push(t);
									t = {rangefrom: o};	
								}
							}
						)
						t.rangeto = old.rangeto;
						sublist.push(t);
						this.entries = this.entries.concat(sublist,tail);
					}	
				}
				this.removeItem = function() {
					if(this.selectedIndex == 0 ) {
						this.entries.splice( 0, 1 );
						if(this.entries.length>0) this.entries[0].rangefrom = this.min;
					}
					else {
						var tail = this.entries.splice( this.selectedIndex ); 
						var old = tail.splice(0, 1)[0];
						if(tail.length>0) {
							tail[0].rangefrom = this.entries[this.entries.length-1].rangeto;
							this.entries = this.entries.concat( tail );							
						}	
						else {
							this.entries[ this.entries.length - 1 ].rangeto = this.max; 
						}
					}	
				}
				
				this.save = function() {
					var l = {list:this.entries, classid: "${param['classid']}"};
					svc.saveGradingEq(l);
					if(this.saveHandler) this.saveHandler();
					return "_close";
				}
				
				this.showBuild = function() {
					var f = function(lorder, mn, mx) {
						self.listorder = lorder;
						self.min = mn;
						self.max = mx;
						self.entries.push( {rangefrom: mn, rangeto: mx} );
						self._controller.refresh();
					}
					return new DropdownOpener("#showbuild", {buildHandler: f} );	
				}
				
			}
			
		);	
		
		$put("showbuild",
			new function() {
				this.listorder = "asc";
				this.buildHandler;
				this.build = function() {
					var mn = 0;
					var mx = "100";
					if(this.listorder == "desc") {
						mn = 100;
						mx = 0;
					}
					this.buildHandler(this.listorder, mn,mx);
					return "_close";
				}
			}
		);
	</jsp:attribute>
	
	<jsp:attribute name="sections">
		<div id="showbuild" style="display:none;">
			<p>Determine the order of the range of values</p><br>
			<input type="radio" r:context="showbuild" r:name="listorder" value="asc"/><b>Ascending</b> (from 0 to 100)<br>
			<input type="radio" r:context="showbuild" r:name="listorder" value="desc"/><b>Descending</b> (from 100 to 0)<br>
			<br>
			<input type="button" r:context="showbuild" r:name="build"  value="OK"/><br>
		</div>	
	</jsp:attribute>

	
	<jsp:attribute name="leftactions">
		<input type="button" r:context="edit_eq" r:name="save" value="Save"/>
	</jsp:attribute>
	
	
	<jsp:body>
		<table r:context="edit_eq" r:items="entries" r:varName="item" r:varStatus="stat" r:name="selectedItem" width="300" border="1" cellpadding="2" cellspacing="0">
			<thead>
				<tr>
					<td colspan="2" valign="top"  align="center" width="120px">
						Range %	
					</td>
					<td style="font-weight:bolder;" rowspan="2" align="center">Eq. Grade</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td style="font-weight:bolder;" align="center">From (%)</td>
					<td style="font-weight:bolder;" align="center">To (%)</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center" width="60px">#{item.rangefrom}</td>
					<td align="center" width="60px">#{item.rangeto}</td>
					<td align="center" width="60px">
						<input type="text" r:context="edit_eq" r:name="entries[#{stat.index}].title" style="width:90%;text-align:center"/>
					</td>
					<td>
						<a r:context="edit_eq" r:name="split" r:params="{selectedIndex: #{stat.index} }">Split</a>
						&nbsp;&nbsp;&nbsp;
						<a r:context="edit_eq" r:name="removeItem" r:params="{selectedIndex: #{stat.index} }">Remove</a>
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="button" r:context="edit_eq" r:name="showBuild" value="Build" r:visibleWhen="#{entries.length == 0}"/>
	</jsp:body>
   
</t:popup>
