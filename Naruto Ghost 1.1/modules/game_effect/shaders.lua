MAP_SHADERS = {
  { name = 'Default', frag = '/shaders/default.frag' },
  { name = 'Bloom', frag = '/shaders/bloom.frag'},
  { name = 'Sepia', frag ='/shaders/sepia.frag' },
  { name = 'Grayscale', frag ='/shaders/grayscale.frag' },
  { name = 'Pulse', frag = '/shaders/pulse.frag' },
  { name = 'Old Tv', frag = '/shaders/oldtv.frag' },
  { name = 'Fog', frag = '/shaders/fog.frag', tex1 = '/shaders/clouds.png' },
  { name = 'Party', frag = '/shaders/party.frag' },
  { name = 'Radial Blur', frag ='/shaders/radialblur.frag' },
  { name = 'Zomg', frag ='/shaders/zomg.frag' },
  { name = 'Heat', frag ='/shaders/heat.frag' },
  { name = 'Noise', frag ='/shaders/noise.frag' },
  { name = 'Desert', frag = '/shaders/desert.frag', tex1 = '/shaders/desert.png' },
  { name = 'Rain', frag = '/shaders/rain.frag', tex1 = '/shaders/rain.png' },
  { name = 'Snow', frag = '/shaders/snow.frag', tex1 = '/shaders/snow.png' },
}

local lastShader
local areas = {
{from = {x = 1002, y = 1049, z = 6}, to = {x = 1005, y = 1052, z = 6}, name = 'Fog'},
{from = {x = 1010, y = 1030, z = 7}, to = {x = 1029, y = 1039, z = 7}, name = 'Fog'},
{from = {x = 1019, y = 1024, z = 7}, to = {x = 1021, y = 1032, z = 7}, name = 'Fog'},
{from = {x = 1028, y = 1013, z = 6}, to = {x = 1037, y = 1024, z = 6}, name = 'Fog'},
{from = {x = 1019, y = 1018, z = 6}, to = {x = 1030, y = 1024, z = 6}, name = 'Fog'},
{from = {x = 1019, y = 1012, z = 5}, to = {x = 1037, y = 1031, z = 5}, name = 'Fog'},
{from = {x = 1019, y = 1013, z = 7}, to = {x = 1021, y = 1018, z = 7}, name = 'Fog'},
{from = {x = 1007, y = 1004, z = 7}, to = {x = 1030, y = 1012, z = 7}, name = 'Fog'},
{from = {x = 997, y = 1008, z = 6}, to = {x = 1007, y = 1034, z = 6}, name = 'Fog'},
{from = {x = 990, y = 1041, z = 7}, to = {x = 1009, y = 1061, z = 7}, name = 'Fog'},
{from = {x = 1013, y = 1045, z = 7}, to = {x = 1023, y = 1056, z = 7}, name = 'Fog'},
{from = {x = 1010, y = 1040, z = 6}, to = {x = 1025, y = 1057, z = 6}, name = 'Fog'},
}

function isInRange(position, fromPosition, toPosition)
    return (position.x >= fromPosition.x and position.y >= fromPosition.y and position.z >= fromPosition.z and position.x <= toPosition.x and position.y <= toPosition.y and position.z <= toPosition.z)
end

function init()
   if not g_graphics.canUseShaders() then return end
   for _i,opts in pairs(MAP_SHADERS) do
     local shader = g_shaders.createFragmentShader(opts.name, opts.frag)

     if opts.tex1 then
       shader:addMultiTexture(opts.tex1)
     end
     if opts.tex2 then
       shader:addMultiTexture(opts.tex2)
     end
   end

   connect(LocalPlayer, {
     onPositionChange = updatePosition
   })
  
   local map = modules.game_interface.getMapPanel()
   map:setMapShader(g_shaders.getShader('Default'))
end

function terminate()

end

function updatePosition()
  local player = g_game.getLocalPlayer()
  if not player then return end
  local pos = player:getPosition()
  if not pos then return end
  
  local name = 'Default'  
  
  for _, TABLE in ipairs(areas) do
      if isInRange(pos, TABLE.from, TABLE.to) then
         name = TABLE.name
      end
  end
  if lastShader and lastShader == name then return true end
  
  lastShader = name
  local map = modules.game_interface.getMapPanel()
  map:setMapShader(g_shaders.getShader(name))
end       