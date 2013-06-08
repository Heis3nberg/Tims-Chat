<div class="tabMenuContainer chatTabMenuContainer containerPadding">
	<nav class="menu chatSidebarMenu">
		<ul>
			<li id="toggleUsers" class="ui-state-active"><a href="{@$__wcf->getAnchor('timsChatUserList')}" title="{lang}chat.general.users{/lang}">{lang}chat.general.users{/lang} <span class="badge">0</span></a></li>
			<li id="toggleRooms"><a href="{@$__wcf->getAnchor('timsChatRoomList')}" title="{lang}chat.general.rooms{/lang}">{lang}chat.general.rooms{/lang} <span class="badge">0</span></a></li>
		</ul>
	</nav>
	
	<section id="sidebarContent" class="tabMenuContent">
		<fieldset id="timsChatUserList">
			<nav>
				<ul>
				</ul>
			</nav>
		</fieldset>
		
		<fieldset id="timsChatRoomList" style="display: none;">
			<nav>
				<ul>
				</ul>
			</nav>
			<div><button type="button">{lang}chat.general.forceRefresh{/lang}</button></div>
		</fieldset>
	</section>
</div>
