<?php
namespace chat\system\command;
use \wcf\system\event\EventHandler;

/**
 * Default implementation for commands.
 *
 * @author 	Tim Düsterhus
 * @copyright	2010-2013 Tim Düsterhus
 * @license	Creative Commons Attribution-NonCommercial-ShareAlike <http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode>
 * @package	be.bastelstu.chat
 * @subpackage	system.chat.command
 */
abstract class AbstractCommand implements ICommand {
	/**
	 * Instance of the CommandHandler
	 * 
	 * @var \chat\system\command\CommandHandler
	 */
	public $commandHandler = null;
	
	/**
	 * Should HTML be enabled?
	 * 
	 * @var integer
	 * @see \chat\system\command\ICommand::SETTING_OFF
	 * @see \chat\system\command\ICommand::SETTING_ON
	 */
	public $enableHTML = ICommand::SETTING_OFF;
	
	/**
	 * Should smilies be enabled?
	 * 
	 * @var integer
	 * @see \chat\system\command\ICommand::SETTING_OFF
	 * @see \chat\system\command\ICommand::SETTING_ON
	 * @see \chat\system\command\ICommand::SETTING_USER
	 */
	public $enableSmilies = ICommand::SETTING_OFF;
	
	public function __construct(CommandHandler $commandHandler) {
		EventHandler::getInstance()->fireAction($this, 'shouldInit');
		$this->commandHandler = $commandHandler;
	}
	
	/**
	 * Fires the didInit-event.
	 * You should call this when everything is properly inserted.
	 */
	public function didInit() {
		EventHandler::getInstance()->fireAction($this, 'didInit');
	}
	
	/**
	 * Default-Receiver: Everyone
	 * 
	 * @see \chat\system\command\ICommand::getReceiver()
	 */
	public function getReceiver() {
		return null;
	}
	
	/**
	 * No additionaldata by default.
	 */
	public function getAdditionalData() {
		return null;
	}
}
