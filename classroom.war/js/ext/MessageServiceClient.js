function MessageServiceClient( _msgtype, _channelid, _threadid ) {
	
	this.msgtype = _msgtype;
	this.channelid = _channelid;
	this.threadid = _threadid;
	this.eof = "false";
	
	var svc = ProxyService.lookup("MessageService");
	var self = this;
	
	this.messageList = {
		fetchList: function( p, last ){
			var m = {channelid: self.channelid};
			m.msgtype = self.msgtype;
			if( self.threadid ) m.threadid = self.threadid;  
			if(last) m.lastmsgid = last.objid; 
			var list =  svc.getMessages( m );
			if(list.length==0) {
				self.eof = "true";
			}	
			return list;
		},
		showComments: function() {
			var selected = this.getSelectedItem();
			var msgid = selected.objid;
			selected._expanded = "true";
			selected.notifycount = null;
			if( !self.comments[msgid] ) {
				self.comments[msgid] = svc.getResponses( {objid: msgid } );
			}
		},
		hideComments: function() {
			var selected = this.getSelectedItem();
			selected._expanded = null;
			self.comments[selected.objid] = null;
		},
		isEOF: function() {
			return self.eof;
		},
		removeItem: function() {
			if( !this.getSelectedItem() ) return;
			self.removeMessage( this.getSelectedItem().objid );
		},
		getCommentsIndex: function() {
			return self.comments;
		}
	};
	
	this.comments = {};
	
	this.commentList = {
		fetchList: function(o) {
			return svc.getResponses({objid: self.parentid});
		}
	};
	
	this.subscriberList = {
		fetchList: function(o) {
			return svc.getSubscribers({msgid: self.parentid});
		}
	};

	//find if parent exists and load it if it does exist
	this.loadMessageResponses = function(msgid) {
		var thread = self.messageList.getList().find(
			function(x) { return x.objid == msgid } 
		);
		if( thread ) {
			//force the load so it will get the new comments
			self.comments[msgid] = svc.getResponses( {objid: msgid, msgtype: self.msgtype } );
			thread.replies = self.comments[msgid].length;
			
			console.log('receiving....');
			if(thread._expanded != "true" ) {
				self.comments[msgid] = null;
				if(thread.notifycount==null) thread.notifycount = 0;
				thread.notifycount = thread.notifycount+1;
			}
			self.messageList.refresh();	
		}
	}
	
	//sets the handlers
	this.init = function() {
		Session.handler = function( o ) {
			if(o.channelid == self.channelid && o.msgtype == self.msgtype ) {
				self.messageList.prependItem( o );
			}
			else if( !self.parentid && o.channelid == self.channelid && o.msgtype == (self.msgtype+'-removed') ) {
				self.messageList.refresh(true);
			}
			else if( !self.parentid && o.channelid == self.channelid && o.msgtype == (self.msgtype+'-response') ) {
				self.loadMessageResponses( o.msgid );
			}
			else if( o.msgid == self.parentid ) {
				if( self.commentList.prependItem ) {
					self.commentList.prependItem( o );
				}
				if( self.subscriberList.refresh ) {
					self.subscriberList.refresh(true);
				}
			}
		}
	}

	this.post = function(msg) {
		if(!msg.message || !msg.message.trim()) 
			throw new Error("Please provide a message" );
			
		msg.msgtype  = this.msgtype;
		msg.channelid = this.channelid;
		if( this.threadid ) msg.threadid = this.threadid;
		
		svc.send( msg );
	}

	this.respond = function( msgid, resp ) {
		resp.msgid = msgid;
		resp.channelid = this.channelid;
		if( this.threadid ) resp.threadid = this.threadid;
		svc.respond( resp );
	}
	
	this.removeMessage = function(msgid) {
		if(confirm("Removing this message will also remove associated comments. Continue?")) {
			svc.removeMessage( {objid: msgid, channelid: this.channelid, msgtype: this.msgtype} );
		}
	}

}
