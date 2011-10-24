<script>
	$put(
		"student_search",
		new function() 
		{
			this.name;
			this.items;
			this.selected;
			this.handler;
			
			var studsvc = ProxyService.lookup("StudentService");

			this.search = function() {
				this.items = studsvc.findStudents( this.name );
				if( !this.items || this.items.length == 0 )
					$('#no_result').fadeIn();
				else
					$('#no_result').fadeOut(0);
			}
			
			this.select = function() {
				if( this.handler ) {
					this.handler( this.selected );
				}
				return '_close';
			}
		}
	);
</script>

<style>
	#student_search ul li {
		border-top: solid 1px #ddd;
		border-bottom: solid 1px #bbb;
		padding: 4px 3px;
		cursor: pointer;
	}
	#student_search ul li.selected {
		background: #ccc;
	}
</style>

<div id="student_search">
	<table height="100%" width="100%">
		<tr>
			<td height="30px">
				<label>Search Student: </label>
				<input type="text" class="text" r:context="student_search" r:name="name"/>
				<button r:context="student_search" r:name="search">Search</button>
				<hr/>
				Search Results:
				<br/>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<b id="no_result" style="display:none;">No result found.</b>
				<ul r:context="student_search" r:items="items" r:name="selected" r:varName="item" style="list-style:none;margin:0;padding:0">
					<li>#{item.lastname}, #{item.firstname}</li>
				</ul>
			</td>
		</tr>
		<tr>
			<td align="right" height="30px">
				<button r:context="student_search" r:name="select">Select</button>
				<button r:context="student_search" r:name="_close">Cancel</button>
			</td>
		</tr>
	</table>
</div>
   
