<?php
namespace wcf\data\chat\message;

/**
 * Provides functions to edit chat messages.
 *
 * @author 	Tim Düsterhus
 * @copyright	2010-2012 Tim Düsterhus
 * @license	Creative Commons Attribution-NonCommercial-ShareAlike <http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode>
 * @package	be.bastelstu.wcf.chat
 * @subpackage	data.chat.message
 */
class ChatMessageEditor extends \wcf\data\DatabaseObjectEditor {
	/**
	 * @see	\wcf\data\DatabaseObjectDecorator::$baseClass
	 */
	protected static $baseClass = '\wcf\data\chat\message\ChatMessage';
	
	/**
	 * Notify the Push-Server.
	 */
	public static function create(array $parameters = array()) {
		try {
			if (\wcf\util\ChatUtil::nodePushRunning()) {
				$sock = stream_socket_client('unix://'.WCF_DIR.'acp/be.bastelstu.wcf.chat.nodePush/data.sock', $errno, $errstr, 1);
				fclose($sock);
			}
		}
		catch (\Exception $e) { }
		
		return parent::create($parameters);
	}
}
