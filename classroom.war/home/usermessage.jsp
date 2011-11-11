<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:content>
    <jsp:attribute name="style">
        .message {
            font-size:11px;font-family:arial;padding:6px;
        }
        .news_action {
            font-size:11px;
        }
    </jsp:attribute>

    <jsp:body>
        <script>
            $put(
                "usermessage",
                new function() 
                {
                    var self = this;
                    var profSvc = ProxyService.lookup("UserProfileService");
                    var svc = ProxyService.lookup("MessageService");

                    this.objid;
                    this.user;
                    this.photo;
                    this.text = "";
                    this._controller;
                    this.mobile = '-';

                    this.classid = "${param['classid']}";
                    this.sending = "false";
                    this.message = {recipients: [] };
                    this.eof = "false";

                    this.listModel = {
                        fetchList : function(o, last) {
                            var m = {userid:self.objid, channelid: self.classid};
                            if(last) m.lastmsgid = last.objid;
                            var list = svc.getConversation( m );	
                            if(list.length==0) self.eof = "true";
                            return list;
                        }
                    }

                    this.onload = function() {
                        this.user = profSvc.getInfo({ objid: this.objid });
                        if( this.user && this.user.contacts ) {
                            var mb = this.user.contacts.find(function(it){ return it.type.toLowerCase() == 'mobile' });
                            if( mb ) {
                                this.mobile = mb.value;
                            }
                        }
                        Session.handler = function( o ) {
                            if(o.msgtype && o.channelid == self.classid ) {
                                self.listModel.prependItem( o );
                            }
                        }
                    }

                    this.send = function() {
                        this.message = {
                            channelid:this.classid,
                            recipients:[{userid: this.objid }],
                            message: this.text
                        };
                        svc.send( this.message );
                        this.text = '';
                    }

                    this.addPerson = function() {
                        alert("Add a Person");
                    }

                    this.atestfunction = function() {
                        alert("this is a test function");
                    }

                }
            );
        </script>


        <table class="page-form-table" width="80%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td rowspan="4" width="60" style="padding-right:10px;">
                    <label r:context="usermessage">
                        <img src="${pageContext.servletContext.contextPath}/#{user.info.photoversion == null? 'img/profilephoto.png' : user.profile+'/thumbnail.jpg?v='+user.info.photoversion}"/>
                    </label>
					<!--
					<c:if test="${empty SESSION_INFO.photoversion}">
						<img src="${pageContext.servletContext.contextPath}/img/profilephoto.png"/>
					</c:if>
					<c:if test="${!empty SESSION_INFO.photoversion}">
						<img src="${pageContext.servletContext.contextPath}/${SESSION_INFO.profile}/thumbnail.jpg?v=${SESSION_INFO.photoversion}"/>
					</c:if>
					-->
                </td>
            </tr>
            <tr>
                <td class="caption" style="font-size:14px;">
                    <label r:context="usermessage">#{user.firstname} #{user.lastname}</label>
                </td>
                <td>
                    <img src="img/phone.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{mobile}</label>
                </td>
            </tr>
            <tr>
                <td>
                    <label r:context="usermessage">#{user.usertype}</label>
                </td>
                <td>
                    <img src="img/email.png" style="padding-right:5px;"/>
                    <label r:context="usermessage">#{user.email}</label>
                </td>
            </tr>
        </table>

        <!-- POSTING A COMMENT HERE -->
        <div style="float:left;width:500px;">
            <t:textarea id="message" context="usermessage" name="text" hint="Write a message">
				<jsp:attribute name="leftcontrols">
					<a href="#" title="Attach a link"><img src="img/post-icons/doc-attach.png"/></a>
					<a href="#" title="Add another recipient"><img src="img/post-icons/doc-add.png"/></a>
				</jsp:attribute>
                <jsp:attribute name="rightcontrols">
                    <input type="button" value="Send" r:context="usermessage" r:name="send"/>
                </jsp:attribute>
            </t:textarea>

            <!-- POSTED MESSAGES ARE SHOW HERE -->
            <table width="100%" r:context="usermessage" r:model="listModel" r:varName="item" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td valign="top" align="left" width="50" style="padding-top:10px;border-bottom:1px solid lightgrey" rowspan="2">
                            <img src="${pageContext.servletContext.contextPath}/#{item.senderprofile ?  item.senderprofile + '/thumbnail.jpg' : 'img/profilephoto.jpg'}"></img>
                        </td>
                        <td valign="top" class="message">
                            #{item.message}	
                        </td>
                        <td valign="top" align="right">
                        </td>
                    </tr>
                    <tr>
                        <td style="border-bottom:1px solid lightgrey" colspan="2">
                            <div style="font-size:11px;color:gray;padding-left:6px;">posted on #{item.dtfiled} by #{item.sendername}</div> 
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- ACTIVITIES HERE -->
        <div style="float:right;width:200px;">
            <table class="page-form-table" width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th class="center" colspan="2">Recent Activities</th>
                </tr>
                <tr>
                    <td rowspan="2" valign="top">
                        picture here
                    </td>
					<td>
                        activity title here
                    </td>
                </tr>
                <tr>
                    <td>
                        activity details here
                    </td>
                </tr>
            </table>
        </div>
    </jsp:body>
</t:content>
