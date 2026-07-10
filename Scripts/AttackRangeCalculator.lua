local buttonToggle = true

local scriptEnabled = nil

function onLoad()
  -- register to enable event listeners on the object
  self.registerCollisions()
  
  scriptEnabled = Global.call("scriptEnabled")

  -- Create an on/off toggle button
  self.createButton({
      label = "ON",
      click_function = "toggleScript",
      function_owner = self,
      position   = {0, 1.5, 1.70},
      rotation     = {0, 0, 0},
      color       = {r=0.1, g=0.1, b=0.1, a=1},
      hover_color = {r=0.1, g=0.2, b=0.3, a=1},
      font_color  = {r=0.6, g=0.8, b=1, a=1},
      width = 600,
      height = 260,
      font_size = 150,
      tooltip = "Forecast the attack range of the below card (after all previous attack forecasts)."
  })
end

-- Update the board display.
function boardUpdate()
  Global.call("boardUpdate")
end

function printDebug(message)
    if Global.call("isDebug") then
        print(message)
    end
end

function getButtonState()
  return buttonToggle
end

-- Function called when the toggle button is clicked
function toggleScript(obj, color)
    buttonToggle = not buttonToggle
    
    if buttonToggle then
        self.editButton({
            index = 0,
            label = "ON",
            font_color = {r=0.6, g=0.8, b=1, a=1}
            })
        boardUpdate()
    else
        self.editButton({
            index = 0,
            label = "OFF",
            font_color = {r=1, g=0.65, b=0.65, a=1}
            })
        boardUpdate()
    end
end

function payloadValidity(payload)
  -- Save last collision information
  local info = payload.info
  printDebug("RangeCalculator received collision with " .. tostring(info.collision_object))
  
  -- All Clad cards must have the BACL_BossActionCard tag.
  if not info.collision_object.hasTag("BACL_BossActionCard") then 
    printDebug("Collision with non-boss object, ignoring.")
    return false
  elseif info.collision_object.type ~= "Card" then
    printDebug("Collision with non-Card object, ignoring. (Possibly a deck?).")
    return false
  end
  
  -- Check the card is within proximity to be a valid card for the boardUpdate() function.
  -- Has a very lenient vertical distance, as lifted cards may be functionally very high above the
  --   slot by the time this runs.
  local selfPos = self.getPosition()
  local maxY = selfPos.y + 5.1
  local pos = info.collision_object.getPosition()
  local rot = info.collision_object.getRotation()
  local horizontalDistance = math.sqrt((pos.x - selfPos.x)^2 + (pos.z - selfPos.z)^2)
  
  if horizontalDistance < 1
    and pos.y < maxY
    and pos.y > selfPos.y 
    and (rot.z < 10 or rot.z > 350) then
    printDebug("Boss card object in range, updating...")
  else
    printDebug("Collision is too far to register for update, ignoring.")
    return false
  end 
  
  return true
end

function BACL_CollideEnter(payload)
    local validObject = payloadValidity(payload)
    if validObject then
      boardUpdate()
    end
end

function BACL_CollideExit(payload)
    local validObject = payloadValidity(payload)
    if validObject then
      boardUpdate()
    end
end
