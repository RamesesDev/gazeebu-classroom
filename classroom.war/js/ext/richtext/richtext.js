/*
 CLEditor WYSIWYG HTML Editor v1.3.0
 http://premiumsoftware.net/cleditor
 requires jQuery v1.4.2 or later

 Copyright 2010, Chris Landowski, Premium Software, LLC
 Dual licensed under the MIT or GPL Version 2 licenses.
*/
(function(e){function aa(a){var b=this,c=a.target,d=e.data(c,x),h=s[d],f=h.popupName,i=p[f];if(!(b.disabled||e(c).attr(n)==n)){var g={editor:b,button:c,buttonName:d,popup:i,popupName:f,command:h.command,useCSS:b.options.useCSS};if(h.buttonClick&&h.buttonClick(a,g)===false)return false;if(d=="source"){if(t(b)){delete b.range;b.$area.hide();b.$frame.show();c.title=h.title}else{b.$frame.hide();b.$area.show();c.title="Show Rich Text"}setTimeout(function(){u(b)},100)}else if(!t(b))if(f){var j=e(i);if(f==
"url"){if(d=="link"&&M(b)===""){z(b,"A selection is required when inserting a link.",c);return false}j.children(":button").unbind(q).bind(q,function(){var k=j.find(":text"),o=e.trim(k.val());o!==""&&v(b,g.command,o,null,g.button);k.val("http://");r();w(b)})}else f=="pastetext"&&j.children(":button").unbind(q).bind(q,function(){var k=j.find("textarea"),o=k.val().replace(/\n/g,"<br />");o!==""&&v(b,g.command,o,null,g.button);k.val("");r();w(b)});if(c!==e.data(i,A)){N(b,i,c);return false}return}else if(d==
"print")b.$frame[0].contentWindow.print();else if(!v(b,g.command,g.value,g.useCSS,c))return false;w(b)}}function O(a){a=e(a.target).closest("div");a.css(H,a.data(x)?"#FFF":"#FFC")}function P(a){e(a.target).closest("div").css(H,"transparent")}function ba(a){var b=a.data.popup,c=a.target;if(!(b===p.msg||e(b).hasClass(B))){var d=e.data(b,A),h=e.data(d,x),f=s[h],i=f.command,g,j=this.options.useCSS;if(h=="font")g=c.style.fontFamily.replace(/"/g,"");else if(h=="size"){if(c.tagName=="DIV")c=c.children[0];
g=c.innerHTML}else if(h=="style")g="<"+c.tagName+">";else if(h=="color")g=Q(c.style.backgroundColor);else if(h=="highlight"){g=Q(c.style.backgroundColor);if(l)i="backcolor";else j=true}b={editor:this,button:d,buttonName:h,popup:b,popupName:f.popupName,command:i,value:g,useCSS:j};if(!(f.popupClick&&f.popupClick(a,b)===false)){if(b.command&&!v(this,b.command,b.value,b.useCSS,d))return false;r();w(this)}}}function C(a){for(var b=1,c=0,d=0;d<a.length;++d){b=(b+a.charCodeAt(d))%65521;c=(c+b)%65521}return c<<
16|b}function R(a,b,c,d,h){if(p[a])return p[a];var f=e(m).hide().addClass(ca).appendTo("body");if(d)f.html(d);else if(a=="color"){b=b.colors.split(" ");b.length<10&&f.width("auto");e.each(b,function(i,g){e(m).appendTo(f).css(H,"#"+g)});c=da}else if(a=="font")e.each(b.fonts.split(","),function(i,g){e(m).appendTo(f).css("fontFamily",g).html(g)});else if(a=="size")e.each(b.sizes.split(","),function(i,g){e(m).appendTo(f).html("<font size="+g+">"+g+"</font>")});else if(a=="style")e.each(b.styles,function(i,
g){e(m).appendTo(f).html(g[1]+g[0]+g[1].replace("<","</"))});else if(a=="url"){f.html('Enter URL:<br><input type=text value="http://" size=35><br><input type=button value="Submit">');c=B}else if(a=="pastetext"){f.html("Paste your content here and click submit.<br /><textarea cols=40 rows=3></textarea><br /><input type=button value=Submit>");c=B}if(!c&&!d)c=S;f.addClass(c);l&&f.attr(I,"on").find("div,font,p,h1,h2,h3,h4,h5,h6").attr(I,"on");if(f.hasClass(S)||h===true)f.children().hover(O,P);p[a]=f[0];
return f[0]}function T(a,b){if(b){a.$area.attr(n,n);a.disabled=true}else{a.$area.removeAttr(n);delete a.disabled}try{if(l)a.doc.body.contentEditable=!b;else a.doc.designMode=!b?"on":"off"}catch(c){}u(a)}function v(a,b,c,d,h){D(a);if(!l){if(d===undefined||d===null)d=a.options.useCSS;a.doc.execCommand("styleWithCSS",0,d.toString())}d=true;var f;if(l&&b.toLowerCase()=="inserthtml")y(a).pasteHTML(c);else{try{d=a.doc.execCommand(b,0,c||null)}catch(i){f=i.description;d=false}d||("cutcopypaste".indexOf(b)>
-1?z(a,"For security reasons, your browser does not support the "+b+" command. Try using the keyboard shortcut or context menu instead.",h):z(a,f?f:"Error executing the "+b+" command.",h))}u(a);return d}function w(a){setTimeout(function(){t(a)?a.$area.focus():a.$frame[0].contentWindow.focus();u(a)},0)}function y(a){if(l)return J(a).createRange();return J(a).getRangeAt(0)}function J(a){if(l)return a.doc.selection;return a.$frame[0].contentWindow.getSelection()}function Q(a){var b=/rgba?\((\d+), (\d+), (\d+)/.exec(a),
c=a.split("");if(b)for(a=(b[1]<<16|b[2]<<8|b[3]).toString(16);a.length<6;)a="0"+a;return"#"+(a.length==6?a:c[1]+c[1]+c[2]+c[2]+c[3]+c[3])}function r(){e.each(p,function(a,b){e(b).hide().unbind(q).removeData(A)})}function U(){var a=e("link[href$='jquery.cleditor.css']").attr("href");return a.substr(0,a.length-19)+"images/"}function K(a){var b=a.$main,c=a.options;a.$frame&&a.$frame.remove();var d=a.$frame=e('<iframe frameborder="0" src="javascript:true;">').hide().appendTo(b),h=d[0].contentWindow,f=
a.doc=h.document,i=e(f);f.open();f.write(c.docType+"<html>"+(c.docCSSFile===""?"":'<head><link rel="stylesheet" type="text/css" href="'+c.docCSSFile+'" /></head>')+'<body style="'+c.bodyStyle+'"></body></html>');f.close();l&&i.click(function(){w(a)});E(a);if(l){i.bind("beforedeactivate beforeactivate selectionchange keypress",function(g){if(g.type=="beforedeactivate")a.inactive=true;else if(g.type=="beforeactivate"){!a.inactive&&a.range&&a.range.length>1&&a.range.shift();delete a.inactive}else if(!a.inactive){if(!a.range)a.range=
[];for(a.range.unshift(y(a));a.range.length>2;)a.range.pop()}});d.focus(function(){D(a)})}(e.browser.mozilla?i:e(h)).blur(function(){V(a,true)});i.click(r).bind("keyup mouseup",function(){u(a)});L?a.$area.show():d.show();e(function(){var g=a.$toolbar,j=g.children("div:last"),k=b.width();j=j.offset().top+j.outerHeight()-g.offset().top+1;g.height(j);j=(/%/.test(""+c.height)?b.height():parseInt(c.height))-j;d.width(k).height(j);a.$area.width(k).height(ea?j-2:j);T(a,a.disabled);u(a)})}function u(a){if(!L&&
e.browser.webkit&&!a.focused){a.$frame[0].contentWindow.focus();window.focus();a.focused=true}var b=a.doc;if(l)b=y(a);var c=t(a);e.each(a.$toolbar.find("."+W),function(d,h){var f=e(h),i=e.cleditor.buttons[e.data(h,x)],g=i.command,j=true;if(a.disabled)j=false;else if(i.getEnabled){j=i.getEnabled({editor:a,button:h,buttonName:i.name,popup:p[i.popupName],popupName:i.popupName,command:i.command,useCSS:a.options.useCSS});if(j===undefined)j=true}else if((c||L)&&i.name!="source"||l&&(g=="undo"||g=="redo"))j=
false;else if(g&&g!="print"){if(l&&g=="hilitecolor")g="backcolor";if(!l||g!="inserthtml")try{j=b.queryCommandEnabled(g)}catch(k){j=false}}if(j){f.removeClass(X);f.removeAttr(n)}else{f.addClass(X);f.attr(n,n)}})}function D(a){l&&a.range&&a.range[0].select()}function M(a){D(a);if(l)return y(a).text;return J(a).toString()}function z(a,b,c){var d=R("msg",a.options,fa);d.innerHTML=b;N(a,d,c)}function N(a,b,c){var d,h,f=e(b);if(c){var i=e(c);d=i.offset();h=--d.left;d=d.top+i.height()}else{i=a.$toolbar;
d=i.offset();h=Math.floor((i.width()-f.width())/2)+d.left;d=d.top+i.height()-2}r();f.css({left:h,top:d}).show();if(c){e.data(b,A,c);f.bind(q,{popup:b},e.proxy(ba,a))}setTimeout(function(){f.find(":text,textarea").eq(0).focus().select()},100)}function t(a){return a.$area.is(":visible")}function E(a,b){var c=a.$area.val(),d=a.options,h=d.updateFrame,f=e(a.doc.body);if(h){var i=C(c);if(b&&a.areaChecksum==i)return;a.areaChecksum=i}c=h?h(c):c;c=c.replace(/<(?=\/?script)/ig,"&lt;");if(d.updateTextArea)a.frameChecksum=
C(c);if(c!=f.html()){f.html(c);e(a).triggerHandler(F)}}function V(a,b){var c=e(a.doc.body).html(),d=a.options,h=d.updateTextArea,f=a.$area;if(h){var i=C(c);if(b&&a.frameChecksum==i)return;a.frameChecksum=i}c=h?h(c):c;if(d.updateFrame)a.areaChecksum=C(c);if(c!=f.val()){f.val(c);e(a).triggerHandler(F)}}e.cleditor={defaultOptions:{width:500,height:250,controls:"bold italic underline strikethrough subscript superscript | font size style | color highlight removeformat | bullets numbering | outdent indent | alignleft center alignright justify | undo redo | rule image link unlink | cut copy paste pastetext | print source",
colors:"FFF FCC FC9 FF9 FFC 9F9 9FF CFF CCF FCF CCC F66 F96 FF6 FF3 6F9 3FF 6FF 99F F9F BBB F00 F90 FC6 FF0 3F3 6CC 3CF 66C C6C 999 C00 F60 FC3 FC0 3C0 0CC 36F 63F C3C 666 900 C60 C93 990 090 399 33F 60C 939 333 600 930 963 660 060 366 009 339 636 000 300 630 633 330 030 033 006 309 303",fonts:"Arial,Arial Black,Comic Sans MS,Courier New,Narrow,Garamond,Georgia,Impact,Sans Serif,Serif,Tahoma,Trebuchet MS,Verdana",sizes:"1,2,3,4,5,6,7",styles:[["Paragraph","<p>"],["Header 1","<h1>"],["Header 2","<h2>"],
["Header 3","<h3>"],["Header 4","<h4>"],["Header 5","<h5>"],["Header 6","<h6>"]],useCSS:false,docType:'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">',docCSSFile:"",bodyStyle:"margin:4px; font:10pt Arial,Verdana; cursor:text"},buttons:{init:"bold,,|italic,,|underline,,|strikethrough,,|subscript,,|superscript,,|font,,fontname,|size,Font Size,fontsize,|style,,formatblock,|color,Font Color,forecolor,|highlight,Text Highlight Color,hilitecolor,color|removeformat,Remove Formatting,|bullets,,insertunorderedlist|numbering,,insertorderedlist|outdent,,|indent,,|alignleft,Align Text Left,justifyleft|center,,justifycenter|alignright,Align Text Right,justifyright|justify,,justifyfull|undo,,|redo,,|rule,Insert Horizontal Rule,inserthorizontalrule|image,Insert Image,insertimage,url|link,Insert Hyperlink,createlink,url|unlink,Remove Hyperlink,|cut,,|copy,,|paste,,|pastetext,Paste as Text,inserthtml,|print,,|source,Show Source"},
imagesPath:function(){return U()}};e.fn.cleditor=function(a){var b=e([]);this.each(function(c,d){if(d.tagName=="TEXTAREA"){var h=e.data(d,Y);h||(h=new cleditor(d,a));b=b.add(h)}});return b};var H="backgroundColor",A="button",x="buttonName",F="change",Y="cleditor",q="click",n="disabled",m="<div>",I="unselectable",W="cleditorButton",X="cleditorDisabled",ca="cleditorPopup",S="cleditorList",da="cleditorColor",B="cleditorPrompt",fa="cleditorMsg",l=e.browser.msie,ea=/msie\s6/i.test(navigator.userAgent),
L=/iphone|ipad|ipod/i.test(navigator.userAgent),p={},Z,s=e.cleditor.buttons;e.each(s.init.split("|"),function(a,b){var c=b.split(","),d=c[0];s[d]={stripIndex:a,name:d,title:c[1]===""?d.charAt(0).toUpperCase()+d.substr(1):c[1],command:c[2]===""?d:c[2],popupName:c[3]===""?d:c[3]}});delete s.init;cleditor=function(a,b){var c=this;c.options=b=e.extend({},e.cleditor.defaultOptions,b);var d=c.$area=e(a).hide().data(Y,c).blur(function(){E(c,true)}),h=c.$main=e(m).addClass("cleditorMain").width(b.width).height(b.height),
f=c.$toolbar=e(m).addClass("cleditorToolbar").appendTo(h),i=e(m).addClass("cleditorGroup").appendTo(f);e.each(b.controls.split(" "),function(g,j){if(j==="")return true;if(j=="|"){e(m).addClass("cleditorDivider").appendTo(i);i=e(m).addClass("cleditorGroup").appendTo(f)}else{var k=s[j],o=e(m).data(x,k.name).addClass(W).attr("title",k.title).bind(q,e.proxy(aa,c)).appendTo(i).hover(O,P),G={};if(k.css)G=k.css;else if(k.image)G.backgroundImage="url("+U()+k.image+")";if(k.stripIndex)G.backgroundPosition=
k.stripIndex*-24;o.css(G);l&&o.attr(I,"on");k.popupName&&R(k.popupName,b,k.popupClass,k.popupContent,k.popupHover)}});h.insertBefore(d).append(d);if(!Z){e(document).click(function(g){g=e(g.target);g.add(g.parents()).is("."+B)||r()});Z=true}/auto|%/.test(""+b.width+b.height)&&e(window).resize(function(){K(c)});K(c)};var $=cleditor.prototype;e.each([["clear",function(a){a.$area.val("");E(a)}],["disable",T],["execCommand",v],["focus",w],["hidePopups",r],["sourceMode",t,true],["refresh",K],["select",
function(a){setTimeout(function(){t(a)?a.$area.select():v(a,"selectall")},0)}],["selectedHTML",function(a){D(a);a=y(a);if(l)return a.htmlText;var b=e("<layer>")[0];b.appendChild(a.cloneContents());return b.innerHTML},true],["selectedText",M,true],["showMessage",z],["updateFrame",E],["updateTextArea",V]],function(a,b){$[b[0]]=function(){for(var c=[this],d=0;d<arguments.length;d++)c.push(arguments[d]);c=b[1].apply(this,c);if(b[2])return c;return this}});$.change=function(a){var b=e(this);return a?b.bind(F,
a):b.trigger(F)}})(jQuery);



/*
 *	rameses-ui richtext behavior for textarea
 */
(function(){

	BindingUtils.handlers.div_richtext = renderer;
	
	function renderer( elem, controller, idx ) 
	{
		var n = R.attr(elem,'name');
		var value = n? controller.get(n) : null;
		
		if( $(elem).data('richtext') ) {
			var o = $(elem).data('richtext');
			if( n ) {
				o.txt.val( value );
				o.cle[0].updateFrame();
			}
			return;
		}
		
		var ta = $('<textarea></textarea');
		ta.val( value );
		var cle = ta.appendTo(elem)
		.cleditor({width:'100%',height:'100%',})
		.change(function(evt){
			if( n ) controller.set(n, ta.val());
		});
		
		cle[0].updateFrame();
		$(elem).data('richtext', {txt: ta, cle: cle});
	}

})();