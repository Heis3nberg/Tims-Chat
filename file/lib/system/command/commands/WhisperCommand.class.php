<?php
namespace chat\system\command\commands;
use \wcf\data\user\User;

/**
 * Whispers a message.
 *
 * @author 	Tim Düsterhus
 * @copyright	2010-2013 Tim Düsterhus
 * @license	Creative Commons Attribution-NonCommercial-ShareAlike <http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode>
 * @package	be.bastelstu.chat
 * @subpackage	system.chat.command.commands
 */
class WhisperCommand extends \chat\system\command\AbstractCommand {
	/**
	 * @see	\chat\system\command\AbstractCommand::$enableSmilies
	 */
	public $enableSmilies = self::SETTING_USER;
	public $user = null, $message = '';
	
	public function __construct(\chat\system\command\CommandHandler $commandHandler) {
		parent::__construct($commandHandler);
		
		try {
			list($username, $message) = explode(',', $commandHandler->getParameters(), 2);
			$this->message = \wcf\util\StringUtil::trim($message);
		}
		catch (\wcf\system\exception\SystemException $e) {
			throw new \chat\system\command\NotFoundException();
		}
		
		$this->user = User::getUserByUsername($username);
		if (!$this->user->userID) throw new \chat\system\command\UserNotFoundException($username);
		
		$this->didInit();
	}
	
	/**
	 * @see	\chat\system\command\ICommand::getType()
	 */
	public function getType() {
		return \chat\data\message\Message::TYPE_WHISPER;
	}
	
	/**
	 * @see	\chat\system\command\ICommand::getMessage()
	 */
	public function getMessage() {
		$this->message = \wcf\system\bbcode\PreParser::getInstance()->parse($this->message, explode(',', \wcf\system\WCF::getSession()->getPermission('user.chat.allowedBBCodes')));
		
		return $this->message;
	}
	
	/**
	 * @see	\chat\system\command\ICommand::getReceiver()
	 */
	public function getReceiver() {
		return $this->user->userID;
	}
	
	/**
	 * @see	\chat\system\command\ICommand::getAdditionalData()
	 */
	public function getAdditionalData() {
		return array(
			'receiverUsername' => $this->user->username
		);
	}
}
