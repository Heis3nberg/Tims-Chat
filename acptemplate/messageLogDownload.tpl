{foreach from=$messages item=$rawMessage}{*
	*}{assign var=message value=$rawMessage->jsonify(true)}{*
	*}({$message['time']|date:'H:i:s'}) {$message[username]|str_pad:15:' ':STR_PAD_LEFT}{$message[separator]} {$message[message]}

{/foreach}
