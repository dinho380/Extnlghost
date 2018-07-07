filename =  nil
loaded = false

function init()
  connect(g_game, { onProtocolVersionChange = load })
  connect(g_game, {onClientVersionChange = onClientVersionChange})
end

function terminate()
  disconnect(g_game, { onProtocolVersionChange = load })
end

function setFileName(name)
  filename = name
end

function isLoaded()
  return loaded
end


function load()
  local version = g_game.getClientVersion()

  local datPath, sprPath
  if filename then
    datPath = resolvepath('/things/' .. filename)
    sprPath = resolvepath('/things/' .. filename)
  else
    datPath = resolvepath('/things/debug/ExTNL')
    sprPath = resolvepath('/things/debug/ExTNL')
  end

  local errorMessage = ''
  if not g_things.loadDat(datPath) then
    errorMessage = errorMessage .. tr("Unable to load dat file, please place a valid dat in '%s'", datPath) .. '\n'
  end
  if not g_sprites.loadSpr(sprPath) then
    errorMessage = errorMessage .. tr("Unable to load spr file, please place a valid spr in '%s'", sprPath)
  end

  loaded = (errorMessage:len() == 0)

  if errorMessage:len() > 0 then
    local messageBox = displayErrorBox(tr('Error'), errorMessage)
    addEvent(function() messageBox:raise() messageBox:focus() end)

    disconnect(g_game, { onProtocolVersionChange = load })
    g_game.setProtocolVersion(0)
    connect(g_game, { onProtocolVersionChange = load })
  end
  g_game.enableFeature(GameBlueNpcNameColor)
end