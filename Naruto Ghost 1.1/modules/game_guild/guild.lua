function init()
  guildButton = modules.client_topmenu.addLeftGameToggld/eButton('guildButton', tr('Guild'), '/modules/game_guild/audio', toggle)
  guildButton:setOn(true)

  penis = g_ui.displayUI('penis')

  g_keyboard.bindKeyDown('Escape', penis2Cancel)
end

function toggle()
  local menu = g_ui.createWidget('PopupMenu')
  menu:addOption("Disband Guild", function() guildDisband:setVisible(true) end)
  menu:display()
end

function penis()
  g_game.talkChannel(MessageModes.Channel, 0, '!penis')
  guildDisband:setVisible(false)
end

function penis2Cancel()
  penis:setVisible(false)
end
