{include file='documentHeader'}

<head>
	<title>{$room} - {lang}wcf.chat.title{/lang} - {PAGE_TITLE|language}</title>
	
	{include file='headInclude' sandbox=false}
	
	<style type="text/css">
		#chatBox {
			padding: 0;
		}
		
		#chatBox > div {
			text-align: center;
		}
		
		#chatBox aside, #chatRoomContent {
			text-align: left;
		}
		
		.sidebar {
			margin-bottom: -20px !important;
		}
		
		aside {
			overflow: auto;
			padding: 0 1px 0 0;
			width: 190px;
		}
		
		aside h2 {
			margin: auto;
			text-align: center;
			font-size: 130%;
			color: #336699;
			cursor: default;
			font-weight: bold;
			margin-top: 5px;			
		}

		aside ul li a {
			color: #6699CC;
			display: block;
			padding: 5px 25px 7px 35px;
			text-shadow: 0 1px 0 #FFFFFF;
		}
		
		#topic, #smileyList, #chatOptions {
			padding: 5px;
		}	
		
		.chatMessageContainer {
			height: 200px;
			overflow-y: scroll;
		}
		
		#smileyList .smilies li, .smallButtons li {
			display: inline;
			margin-right: 5px;
			margin-top: 5px;
		}
		
		#chatForm {
			margin-top: 15px;
			white-space: nowrap;
			margin-top: 10px;
			/* Fix to align chatInput in center */
			text-align: center;
		}
		
		#chatInput {
			position: relative;
			z-index: 10;
		}
		
		#chatOptions {
			display: inline-block;
		}

		#chatUserList > li > .bgFix a {
			background-image: url({icon size='S'}arrowRight{/icon});
			background-position: 15px center;
			background-repeat: no-repeat;
			background-size: 16px auto;
		}
		
		#chatUserList > li.activeMenuItem > .bgFix a {
			background-image: url({icon size='S'}arrowDown{/icon});
		}
		
		#chatUserList .chatUserMenu li a {
			margin-left: 30px !important;
		}
		
		#chatUserList .chatUserMenu {
			display: none;
		}
		
		#chatUserList > li a {
			margin-left: 20px;
		}
		
		.chatMessage time, .chatMessage time::before, .chatMessage time::after {
			font-size: .8em;
		}
		.chatMessage time::before {
			content: "[";
		}
		
		.chatMessage time::after {
			content: "]";
		}
		
		.chatMessage {
			padding-left: 16px;
			min-height: 16px;
		}
		{assign var='type' value='\wcf\data\chat\message\ChatMessage::TYPE_'}
		.chatMessage{$type|concat:'JOIN'|constant}, .chatMessage{$type|concat:'LEAVE'|constant} {
			background-position: left top;
			background-repeat: no-repeat;
			
		}
		
		.chatMessage{$type|concat:'JOIN'|constant} {
			background-image: url({icon size='S'}toRight1{/icon});
		}
		
		.chatMessage{$type|concat:'LEAVE'|constant} {
			background-image: url({icon size='S'}toLeft1{/icon});
		}
		
		.chatMessageContainer {
			padding-left: 7px !important;
		}
		
		.ajaxLoad {
			background-position: right center;
			background-repeat: no-repeat;
			background-image: url({icon size='S'}spinner1{/icon});
		}
		
		.bgFix {
			display: block;
		}
		
		.chatSidebarTabs {
		    height: 30px;
		}
		
		.chatSidebarTabs ul li {
			width: 50%;
			float: left;
			text-align: center;
		}
		
		.chatSidebarTabs ul li a {
			background-color: rgba(0, 0, 0, 0.2);
			border-bottom: 1px solid #FFFFFF;
			color: rgba(0, 0, 0, 0.4);
			text-shadow: none;
			height: 17px;
			padding: 3px 0 0;
			
			-moz-transition-property: border-radius, background-color, height, font-size; -moz-transition-duration: .2s; 
 			-webkit-transition-property: border-radius, background-color, height, font-size; -webkit-transition-duration: .2s; 
 			transition-property: border-radius, background-color, height, font-size; transition-duration: .2s; 
		}
		
		.chatSidebarTabs ul li:first-child a {
			border-right: 1px solid #BBCCDD;
		}
		
		.chatSidebarTabs ul li.active a {
			background-color: #FFFFFF;
			border-bottom: 1px solid #BBCCDD;
			border-radius: 0 0 7px 7px;
			color: #000000;
			font-size: 130%;
			font-weight: bold;
			height: 23px;
			padding: 7px 0 0;
		}
		
		.chatSidebarTabs ul li:first-child.active a {
			border-radius: 0 0 7px 0;
		}
		
		.chatSidebarTabs ul li:last-child.active a {
			border-radius: 0 0 0 7px;
		}
		
		#chatRoomList {
			margin-top: 5px;
		}
		
		#sidebarContainer {
			overflow-y: auto;
			height: 420px;
			width: 100%;
		}
		
		.hidden {
			display: none;
		}
		
		.counterContainer {
			display: table;
		}
		
		.counterContainer > div {
			display: table-row;
		}
		
		.counterInput {
			height: 16px;
		}
		
		.counterInput, .counter {
			display: table-cell;
		}
		
		.counterInput, .counterContainer {
			width: 100%;
		}
		
		.counter {
			background-color: rgba(0, 0, 0, 0.7);
			padding: 0 5px 0 10px;
			position: relative;
			z-index: 0 !important;
			border-radius: 0px 5px 5px 0px;
			border: 1px solid rgba(255, 255, 255, 0.3);
			width: 30px;
		}
		
		.counter.color-1 {
			color: #FFFFFF;
		}
		.counter.color-2 {
			color: rgba(255,255,255,0.5);
		}
		.counter.color-3 {
			color: #D40D12;
		}
	</style>
</head>

<body id="tpl{$templateName|ucfirst}">
{capture assign='sidebar'}
<div id="sidebar">
	<nav class="chatSidebarTabs">
		<ul>
			<li id="toggleUsers" class="active"><a href="javascript:;" title="{lang}wcf.chat.users{/lang}">{lang}wcf.chat.users{/lang}</a></li>
			<li id="toggleRooms"><a href="javascript:;" title="{lang}wcf.chat.rooms{/lang}" data-refresh-url="{link controller="Chat" action="RefreshRoomList"}{/link}">{lang}wcf.chat.rooms{/lang}</a></li>
		</ul>
	</nav>
	
	<div id="sidebarContainer">
		<ul id="chatUserList">
		{section name=user start=1 loop=26}
			<li id="user-{$user}" class="chatUser">
				<span class="bgFix"><a class="chatUserLink" href="javascript:;">User {$user}</a></span>
				<ul class="chatUserMenu">
					<li>
						<a href="javascript:;">Query</a>
						<a href="javascript:;">Kick</a>
						<a href="javascript:;">Ban</a>
						<a href="{link controller="User" id=$user}{/link}">Profile</a>
					</li>
				</ul>
			</li>
		{/section}
		</ul>
		<nav id="chatRoomList" class="sidebarMenu hidden">
			<div>
				<ul>
				{foreach from=$rooms item='roomListRoom'}
					<li{if $roomListRoom->roomID == $room->roomID} class="activeMenuItem"{/if}>
						<a href="{link controller='Chat' object=$roomListRoom}{/link}" class="chatRoom">{$roomListRoom}</a>
					</li>
				{/foreach}
				</ul>
			</div>
		</nav>
	</div>
</div>
{/capture}
{include file='header' sandbox=false sidebarDirection='left'}

<div id="chatRoomContent">
	<div id="topic" class="border"{if $room->topic|language === ''} style="display: none;"{/if}>{$room->topic|language}</div>
	<div class="chatMessageContainer border content">
		<ul></ul>
	</div>
	
	<form id="chatForm" action="{link controller="Chat" action="Send"}{/link}" method="post">
		<input type="text" id="chatInput" class="inputText long counterInput" name="text" autocomplete="off" maxlength="{CHAT_LENGTH}" required="required" placeholder="{lang}wcf.chat.submit.default{/lang}" />
	</form>
	
	<div id="chatControls">
		<div id="smileyList" class="border">
			<ul class="smilies">
				{foreach from=$smilies item='smiley'}
					<li>
						<img src="{$smiley->getURL()}" alt="{$smiley->smileyCode}" title="{$smiley->smileyCode}" class="smiley" />
					</li>
				{/foreach}
			</ul>
		</div>
		<div id="chatOptions" class="border">
			<div class="smallButtons">
				<ul>
					<li>
						<a id="chatAutoscroll" href="javascript:;" class="chatToggle balloonTooltip" title="{lang}wcf.global.button.disable{/lang}" data-disable-message="{lang}wcf.global.button.disable{/lang}" data-enable-message="{lang}wcf.global.button.enable{/lang}" data-status="1">
							<img alt="" src="{icon}enabled1{/icon}" /> <span>{lang}wcf.chat.scroll{/lang}</span>
						</a>
					</li>
					<li>
						<a id="chatNotify" href="javascript:;" class="chatToggle balloonTooltip" title="{lang}wcf.global.button.enable{/lang}" data-disable-message="{lang}wcf.global.button.disable{/lang}" data-enable-message="{lang}wcf.global.button.enable{/lang}" data-status="0">
							<img alt="" src="{icon}disabled1{/icon}" /> <span>{lang}wcf.chat.notify{/lang}</span>
						</a>
					</li>
					<li>
						<a id="chatSmilies" href="javascript:;" class="chatToggle balloonTooltip" title="{lang}wcf.global.button.disable{/lang}" data-disable-message="{lang}wcf.global.button.disable{/lang}" data-enable-message="{lang}wcf.global.button.enable{/lang}" data-status="1">
							<img alt="" src="{icon}enabled1{/icon}" /> <span>{lang}wcf.chat.smilies{/lang}</span>
						</a>
					</li>
					<li>
						<a id="chatClear" href="javascript:;" class="balloonTooltip" title="Clear the chat">
							<img alt="" src="{icon}delete1{/icon}" /> <span>{lang}wcf.chat.clear{/lang}</span>
						</a>
					</li>
					<li>
						<a id="chatMark" href="javascript:;" class="balloonTooltip" title="Show checkboxes">
							<img alt="" src="{icon}check1{/icon}" /> <span>{lang}wcf.chat.mark{/lang}</span>
						</a>
					</li>											
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//<![CDATA[
		TimWolla.WCF.Chat.titleTemplate = new WCF.Template('{ldelim}$title} - {'wcf.chat.title'|language|encodeJS} - {PAGE_TITLE|language|encodeJS}');
		{capture assign='chatMessageTemplate'}{include file='chatMessage'}{/capture}
		TimWolla.WCF.Chat.messageTemplate = new WCF.Template('{@$chatMessageTemplate|encodeJS}');
		TimWolla.WCF.Chat.init({$room->roomID}, 1);
		TimWolla.WCF.Chat.handleMessages([
			{implode from=$newestMessages item='message'}
				{@$message->jsonify()}
			{/implode}
		]);

		TimWolla.WCF.Chat.config = { 
					reloadTime: {CHAT_RELOADTIME},
					animations: {CHAT_ANIMATIONS},
					maxTextLength: {CHAT_LENGTH}
		}

		$('#chatInput').jCounter();
		$('#sidebar').wcfSidebar();
	//]]>
</script>

{include file='footer' sandbox=false}
</body>
</html>