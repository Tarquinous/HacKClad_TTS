-- Save the current state as a global variable (assuming initial state 1)
currentState = 3

FIELD_GRID_DISTANCE = 3.182  -- Adjust to fit new maps if necessary
BOSS_FIELD_MAX_DISTANCE = 10  -- Adjust to fit new maps if necessary

-- Global variables that store the script on/off state and last crash information.
scriptEnabled = true
legionToggle = true
ensnareToggle = false
TurnSlotGUID_1 = "27498e"
TurnSlotGUID_2 = "3d2065"
TurnSlotGUID_3 = "8cfc39"
lastCollisionPayload = nil

forecastObjects = {
    Attack        = {
        GUID           = nil,
        Name           = "CardCustom",
        Transform      = {
            posX   = 0,
            posY   = 0,
            posZ   = 0,
            rotX   = 0,
            rotY   = 0,
            rotZ   = 0,
            scaleX = 0.75,
            scaleY = 0.1,
            scaleZ = 0.75,
          },
        Nickname       = "",
        Description    = "ORIGIN",
        GMNotes        = "",
        Tags           = {"ArenaForecastMarker"},
        AltLookAngle   = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse   = {
            r = 0.0,
            g = 0.0,
            b = 0.0,
            a = 0.0
        },
        LayoutGroupSortIndex = 0,
        Value          = 0,
        Locked         = true,
        Grid           = true,
        Snap           = true,
        IgnoreFoW      = false,
        MeasureMovement  = false,
        DragSelectable = false,
        Autoraise      = true,
        Sticky         = false,
        Tooltip        = true,
        GridProjection = false,
        HideWhenFaceDown  = false,
        Hands          = false,
        CardID         = 100,
        SidewaysCard   = false,
        CustomDeck     = {
            [1] = {
                FaceURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_Attack.png",
                BackURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_Attack.png",
                NumWidth = 1,
                NumHeight = 1,
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0
                }
            },
        LuaScript      = "",
        LuaScriptState = "",
        XmlUI          = ""
        },
    Move          = {
        GUID           = nil,
        Name           = "CardCustom",
        Transform      = {
            posX   = 0,
            posY   = 0,
            posZ   = 0,
            rotX   = 0,
            rotY   = 0,
            rotZ   = 0,
            scaleX = 0.75,
            scaleY = 0.1,
            scaleZ = 0.75,
          },
        Nickname       = "",
        Description    = "ORIGIN",
        GMNotes        = "",
        Tags           = {"ArenaForecastMarker"},
        AltLookAngle   = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse   = {
            r = 0.0,
            g = 0.0,
            b = 0.0,
            a = 0.0
        },
        LayoutGroupSortIndex = 0,
        Value          = 0,
        Locked         = true,
        Grid           = true,
        Snap           = true,
        IgnoreFoW      = false,
        MeasureMovement  = false,
        DragSelectable = false,
        Autoraise      = true,
        Sticky         = false,
        Tooltip        = true,
        GridProjection = false,
        HideWhenFaceDown  = false,
        Hands          = false,
        CardID         = 100,
        SidewaysCard   = false,
        CustomDeck     = {
            [1] = {
                FaceURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_Move.png",
                BackURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_Move.png",
                NumWidth = 1,
                NumHeight = 1,
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0
                }
            },
        LuaScript      = "",
        LuaScriptState = "",
        XmlUI          = ""
        },
    Legion_Tail   = {
        GUID           = nil,
        Name           = "CardCustom",
        Transform      = {
            posX   = 0,
            posY   = 0,
            posZ   = 0,
            rotX   = 0,
            rotY   = 0,
            rotZ   = 0,
            scaleX = 0.75,
            scaleY = 0.1,
            scaleZ = 0.75,
          },
        Nickname       = "",
        Description    = "ORIGIN",
        GMNotes        = "",
        Tags           = {"ArenaForecastMarker"},
        AltLookAngle   = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse   = {
            r = 0.0,
            g = 0.0,
            b = 0.0,
            a = 0.0
        },
        LayoutGroupSortIndex = 0,
        Value          = 0,
        Locked         = true,
        Grid           = true,
        Snap           = true,
        IgnoreFoW      = false,
        MeasureMovement  = false,
        DragSelectable = false,
        Autoraise      = true,
        Sticky         = false,
        Tooltip        = true,
        GridProjection = false,
        HideWhenFaceDown  = false,
        Hands          = false,
        CardID         = 100,
        SidewaysCard   = false,
        CustomDeck     = {
            [1] = {
                FaceURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionMinor.png",
                BackURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionMinor.png",
                NumWidth = 1,
                NumHeight = 1,
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0
                }
            },
        LuaScript      = "",
        LuaScriptState = "",
        XmlUI          = ""
        },
    Legion_Head   = {
        GUID           = nil,
        Name           = "CardCustom",
        Transform      = {
            posX   = 0,
            posY   = 0,
            posZ   = 0,
            rotX   = 0,
            rotY   = 0,
            rotZ   = 0,
            scaleX = 0.75,
            scaleY = 0.1,
            scaleZ = 0.75,
          },
        Nickname       = "",
        Description    = "ORIGIN",
        GMNotes        = "",
        Tags           = {"ArenaForecastMarker"},
        AltLookAngle   = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse   = {
            r = 0.0,
            g = 0.0,
            b = 0.0,
            a = 0.0
        },
        LayoutGroupSortIndex = 0,
        Value          = 0,
        Locked         = true,
        Grid           = true,
        Snap           = true,
        IgnoreFoW      = false,
        MeasureMovement  = false,
        DragSelectable = false,
        Autoraise      = true,
        Sticky         = false,
        Tooltip        = true,
        GridProjection = false,
        HideWhenFaceDown  = false,
        Hands          = false,
        CardID         = 100,
        SidewaysCard   = false,
        CustomDeck     = {
            [1] = {
                FaceURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionMajor.png",
                BackURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionMajor.png",
                NumWidth = 1,
                NumHeight = 1,
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0
                }
            },
        LuaScript      = "",
        LuaScriptState = "",
        XmlUI          = ""
        },
    Legion_Attack = {
        GUID           = nil,
        Name           = "CardCustom",
        Transform      = {
            posX   = 0,
            posY   = 0,
            posZ   = 0,
            rotX   = 0,
            rotY   = 0,
            rotZ   = 0,
            scaleX = 0.75,
            scaleY = 0.1,
            scaleZ = 0.75,
          },
        Nickname       = "",
        Description    = "ORIGIN",
        GMNotes        = "",
        Tags           = {"ArenaForecastMarker"},
        AltLookAngle   = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse   = {
            r = 0.0,
            g = 0.0,
            b = 0.0,
            a = 0.0
        },
        LayoutGroupSortIndex = 0,
        Value          = 0,
        Locked         = true,
        Grid           = true,
        Snap           = true,
        IgnoreFoW      = false,
        MeasureMovement  = false,
        DragSelectable = false,
        Autoraise      = true,
        Sticky         = false,
        Tooltip        = true,
        GridProjection = false,
        HideWhenFaceDown  = false,
        Hands          = false,
        CardID         = 100,
        SidewaysCard   = false,
        CustomDeck     = {
            [1] = {
                FaceURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionAttack.png",
                BackURL = "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/c9b69d54dc63c3013680a4c169bea4b3e045a254/" ..
                          "Forecast/Forecast_LegionAttack.png",
                NumWidth = 1,
                NumHeight = 1,
                BackIsHidden = true,
                UniqueBack = false,
                Type = 0
                }
            },
        LuaScript      = "",
        LuaScriptState = "",
        XmlUI          = ""
        }
}

turnBoardSnapPoints = {
    cladDeckDrawPile      = {x= 6.596, z=-5.461},
    cladDeckDrawPile_Mark = {x= 6.596, z=-5.461, tags={"~Voltage1"}},
    cladDeckDiscardPile   = {x= 6.596, z=-11.20},
    cladDeckVoltage2      = {x= 2.765, z=-11.20},
    cladDeckVoltage2_Mark = {x= 2.765, z=-11.20, tags={"~Voltage2"}},
    cladDeckVoltage3      = {x=-0.582, z=-11.20},
    cladDeckVoltage3_Mark = {x=-0.582, z=-11.20, tags={"~Voltage3"}},
    cladSlot1           = {x= 2.765, z=-4.544},
    cladSlot2           = {x=-0.582, z=-4.544},
    cladSlot3           = {x=-3.954, z=-4.544},
    voltageMarker1 = {x=6.88, z=-2.79, rotation=225},
    voltageMarker2 = {x=6.56, z=-2.79, rotation=225},  
    voltageMarker3 = {x=6.24, z=-2.79, rotation=225},
    turnSlot1 = {x= 4.4614, z=0.1179},
    turnSlot2 = {x= 1.0918, z=0.1179},
    turnSlot3 = {x=-2.2613, z=0.1179},
    turnSlot4 = {x=-5.6432, z=0.1179}, 
    standbySlot1      = {x=-5.6432, z=5.1061}, 
    standbySlot1_Mark = {x=-5.6432, z=5.1061, tags={"~1"}}, 
    standbySlot2      = {x=-2.2612, z=5.1061}, 
    standbySlot2_Mark = {x=-2.2612, z=5.1061, tags={"~2"}}, 
    standbySlot3      = {x= 1.0918, z=5.1061}, 
    standbySlot3_Mark = {x= 1.0918, z=5.1061, tags={"~3"}}, 
    standbySlot4      = {x= 4.4614, z=5.1061},
    standbySlot4_Mark = {x= 4.4614, z=5.1061, tags={"~4"}}, 
    }

-- onLoad function: set global variables, register collisions, create an on/off toggle button, and create an auto-OFF timer.
function onLoad()

  self.interactable = false
  -- State 1 Button
  self.createButton({
      click_function = "changeState1",
      function_owner = self,
      label = "1",
      position = {-9.5, 0, -8.6},
      rotation = {0, 0, 0},
      width = 400,
      height = 400,
      font_size = 200,
      tooltip = "Wyrm Clad Board"
  })

  -- State 2 Button
  self.createButton({
      click_function = "changeState2",
      function_owner = self,
      label = "2",
      position = {-9.5, 0, -7.8},
      rotation = {0, 0, 0},
      width = 400,
      height = 400,
      font_size = 200,
      tooltip = "Shell Clad Board"
  })

  -- State 3 Button
  self.createButton({
      click_function = "changeState3",
      function_owner = self,
      label = "3",
      position = {-9.5, 0, -7.0},
      rotation = {0, 0, 0},
      width = 400,
      height = 400,
      font_size = 200,
      tooltip = "Hydra Clad Board"
  })
  
  -- Legion attack range button
  self.createButton({
      click_function = "toggleLegionCheck",
      function_owner = self,
      label = "Legion:\nON",
      position = {6.7, 0.65, -5.8},
      rotation = {0, 0, 0},
      color       = {r=0.1, g=0.1, b=0.1, a=1},
      hover_color = {r=0.1, g=0.2, b=0.3, a=1},
      font_color  = {r=0.6, g=0.8, b=1.0, a=1},
      width = 800,
      height = 550,
      font_size = 200,
      tooltip = "Forecast the attack range of the Legion."
  })
  
  -- Ensnare button
  self.createButton({
      click_function = "toggleEnsnareCheck",
      function_owner = self,
      label = "Ensnared: OFF",
      position = {-2.75, 0.65, -7.0},
      rotation = {0, 0, 0},
      color       = {r=0.1, g=0.1, b=0.1, a=1},
      hover_color = {r=0.1, g=0.2, b=0.3, a=1},
      font_color  = {r=0.6, g=0.8, b=1, a=1},
      width = 1400,
      height = 360,
      font_size = 200,
      tooltip = "Disables the Clad's movement. Does NOT disable the Clad's rotations."
  })
  
  -- Register the "Pattern Reveal" hotkeys (you can assign the key in Options → Game Keys)
  --addHotkey("Display Pattern 1", revealPattern1)
  --addHotkey("Display Pattern 2", revealPattern2)
  --addHotkey("Display Pattern 3", revealPattern3)
  
  -- Set the board snap points. This overrides the original ones, meaning no changes unless updated in-script.
  setSnapPoints()
end


-- BUTTON FUNCTIONS 
--
-- State 1 button function: If already in state 1, do nothing.
function changeState1()
    if currentState == 1 then
        return
    end
    self.setState(1)
    currentState = 1
end
-- State 2 button function: If already in state 2, do nothing.
function changeState2()
    if currentState == 2 then
        return
    end
    self.setState(2)
    currentState = 2
end
-- State 3 button function: If already in state 3, do nothing.
function changeState3()
    if currentState == 3 then
        return
    end
    self.setState(3)
    currentState = 3
end

function toggleLegionCheck(obj, player)
  legionToggle = not legionToggle
  
  if legionToggle then
      self.editButton({
            index = 3,
            label = "Legion:\nON",
            font_color = {r=0.6, g=0.8, b=1.0, a=1}
            })
      boardUpdate()
  else
      self.editButton({
            index = 3,
            label = "Legion:\nOFF",
            font_color = {r=1.00, g=0.60, b=0.60, a=1}
            })
      boardUpdate()
  end
end

function toggleEnsnareCheck(obj, player)
  ensnareToggle = not ensnareToggle
  
  if ensnareToggle then
      self.editButton({
            index = 4,
            label = "Ensnared: ON",
            font_color = {r=1.00, g=0.60, b=0.60, a=1},
            color      = {r=0.30, g=0.20, b=0.20, a=1}
            })
      boardUpdate()
  else
      self.editButton({
            index = 4,
            label = "Ensnared: OFF",
            font_color = {r=0.6, g=0.8, b=1.0, a=1},
            color      = {r=0.1, g=0.1, b=0.1, a=1}
            })
      boardUpdate()
  end
end



-- SETUP FUNCTIONS
function setSnapPoints()
    local generatedSnapPoints = {}
    
    for _, snapPoint in pairs(turnBoardSnapPoints) do
        table.insert(generatedSnapPoints, {
            position = {
                x = snapPoint.x,
                y = (snapPoint.y or 0) + 0.5,
                z = snapPoint.z,
                },
            rotation = {
                x = 0,
                y = (snapPoint.rotation or 0),
                z = 0,
                },
            rotation_snap = snapPoint.rotation ~= nil and true or false,
            tags = snapPoint.tags or {}
            })
    end
    
    -- Set Snap Points
    self.setSnapPoints(generatedSnapPoints)
end


-- UTILITY FUNCTIONS
--
function printDebug(message)
    if Global.call("isDebug") then
        print(message)
    end
end

function translateMatrix(matrix, x, y)
    local xTranslatedMatrix = {}
    local yTranslatedMatrix = {}

    for i = 1, 5 do
        xTranslatedMatrix[i] = {}
        for j = 1, 5 do
            xTranslatedMatrix[i][j] = 0
        end
    end

    for i = 1, 5 do
        yTranslatedMatrix[i] = {}
        for j = 1, 5 do
            yTranslatedMatrix[i][j] = 0
        end
    end

    for i = 1, 5 do
        for j = 1, 5 do
            local newX = (j + x + 5) % 5
            if newX == 0 then newX = 5 end
            xTranslatedMatrix[i][newX] = matrix[i][j]
        end
    end

    for i = 1, 5 do
        for j = 1, 5 do
            local newY = (i + y + 5) % 5
            if newY == 0 then newY = 5 end
            yTranslatedMatrix[newY][j] = xTranslatedMatrix[i][j]
        end
    end

    return yTranslatedMatrix
end

function rotateMatrix(matrix, direction)
    if direction == 1 then
        return matrix
    end

    local rotatedMatrix = {}
    for i = 1, 5 do
        rotatedMatrix[i] = {}
        for j = 1, 5 do
            rotatedMatrix[i][j] = 0
        end
    end

    if direction == 2 then
        for i = 1, 5 do
            for j = 1, 5 do
                rotatedMatrix[j][6-i] = matrix[i][j]
            end
        end
    elseif direction == 3 then
        for i = 1, 5 do
            for j = 1, 5 do
                rotatedMatrix[6-i][6-j] = matrix[i][j]
            end
        end
    elseif direction == 4 then
        for i = 1, 5 do
            for j = 1, 5 do
                rotatedMatrix[6-j][i] = matrix[i][j]
            end
        end
    end

    return rotatedMatrix
end

function calcVectorDistance(vector1, vector2)
    return math.sqrt((vector1.x - vector2.x)^2 + (vector1.y - vector2.y)^2 + (vector1.z - vector2.z)^2)
end


-- ARENA FORECAST FUNCTIONS
--
function boardUpdate()
  -- When turning the script ON, it first finds the card above self and displays the attack range.
  printDebug("##################\n\nBOARD UPDATE INITIATED.\n\nClearing old tokens.")
  clearAttackRangeTokens() -- Clear out current tokens.
  
  local card
  local fakePayload
  
  local spawnedTokensMatrix = {
        {{0}, {0}, {0}, {0}, {0}},
        {{0}, {0}, {0}, {0}, {0}},
        {{0}, {0}, {0}, {0}, {0}},
        {{0}, {0}, {0}, {0}, {0}},
        {{0}, {0}, {0}, {0}, {0}}
    };
    
  local bossPosition = {}
  local result = getBossPositionInGrid(findBossOnFieldBoard())
  if result == nil then return end
  bossPosition.y = result.y
  bossPosition.x = result.x
  bossPosition.rot = getBossFacingDirection()
  
  -- Card 1
  printDebug("Processing card in Turn Slot 1...")
  result = processCard(spawnedTokensMatrix, bossPosition, TurnSlotGUID_1, 1)
  if result then
    spawnedTokensMatrix = result.spawnedTokens
    bossPositionInGrid = result.bossPosition
  else
    printDebug("No card detected in Turn Slot 1.")
  end
  
  -- Card 2
  printDebug("Processing card in Turn Slot 2..")
  result = processCard(spawnedTokensMatrix, bossPosition, TurnSlotGUID_2, 2)
  if result then
    spawnedTokensMatrix = result.spawnedTokens
    bossPositionInGrid = result.bossPosition
  else
    printDebug("No card detected in Turn Slot 2.")
  end
  
  -- Card 3
  printDebug("Processing card in Turn Slot 3..")
  processCard(spawnedTokensMatrix, bossPosition, TurnSlotGUID_3, 3)
  if result then
    spawnedTokensMatrix = result.spawnedTokens
    bossPositionInGrid = result.bossPosition
  else
    printDebug("No card detected in Turn Slot 3.")
  end
  
  -- Legion Heads
  printDebug("Processing all Hydra Heads (if any).")
  if legionToggle then -- Legion button must be enabled.
    renderAllLegionAttackRanges(spawnedTokensMatrix, bossPosition)
    if result then
      spawnedTokensMatrix = result.spawnedTokens
      bossPositionInGrid = result.bossPosition
    end
  end
end

-- A function to find all bosses of a given type (boss type: 1,2,3,4)
function findAllBossesOnFieldBoard(bossType)
    local bossesOnFieldBoard = {}
    local bossTypeTag =  bossType == 1 and "BACL_Monster" or
                         bossType == 2 and "BACL_RelicFigurineRed" or
                         bossType == 3 and "BACL_RelicFigurineGreen" or
                         bossType == 4 and "BACL_RelicFigurineAll"

    local board = Global.getVar("arenaBoard")
    if board == nil then
        printDebug("No field board holder found")
        return {}
    end

    for _, bossObject in ipairs(getObjectsWithTag(bossTypeTag)) do
        local distance = calcVectorDistance(bossObject.getPosition(), board.getPosition())
        if distance < BOSS_FIELD_MAX_DISTANCE then
            printDebug("Valid Enemy Detected " .. bossObject.getGUID())
            table.insert(bossesOnFieldBoard, bossObject)
        end
    end

    return bossesOnFieldBoard
end

function renderAllLegionAttackRanges(spawnedTokensMatrix, bossPosition)
    -- 기본 safe mask (모두 0)
    local defaultSafeMask = {
        {0,0,0,0,0},
        {0,0,0,0,0},
        {0,0,0,0,0},
        {0,0,0,0,0},
        {0,0,0,0,0},
    }
    -- 더�� collision object: 원래 2번 오브젝트가 제공하던 RangeStr, Safe 정보 포함
    local rangeString = "00000" .. 
                        "00500" ..
                        "05050" ..
                        "00500" ..
                        "00000"
    
    -- 보스 타입 1~4에 대해 처리
    local bossList = findAllBossesOnFieldBoard(1) -- Hydra Heads
    local legionPosition = {}
    for _, legion in ipairs(bossList) do
    
        local result = getBossPositionInGrid(legion)
        legionPosition.y = result.y
        legionPosition.x = result.x
        legionPosition.rot = 1
        
        printDebug(result.y)
        
        result = renderDangerZone(spawnedTokensMatrix, rangeString, defaultSafeMask, legionPosition)
        if result then spawnedTokensMatrix = result end
    end
    
    return {
      spawnedTokens = spawnedTokensMatrix,
      bossPosition = bossPosition
      }
end

function processCard(spawnedTokensMatrix, bossPosition, turnSlotGUID, turnSlot)
  if not getObjectFromGUID(turnSlotGUID).call("getButtonState") then return end
  
  local card = findCardOnTop(turnSlot)
  
  if card then
    local description = card.getDescription()
    local safeString = description:match("Safe:%d+x")
    local safeMask = {
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    }
    
    if safeString then
      local safe = safeString:match("%d")
      safeMask = getSafeZoneMask(card, tonumber(safe))
    end
    
    -- Find GM Notes data and convert into usable form.
    local objGMNotes = card.getGMNotes()
    printDebug("Card GM Notes: " .. tostring(objGMNotes))
    local rangeString = "0000000000000000000000000"
    local specialEffect = nil
    
    if objGMNotes != '' then
        local data = JSON.decode(objGMNotes)
        rangeString = data.Range
        specialEffect = data.Special
    else
        return
    end 
    
    -- [HYDRA]: Move the clad to the position and orientation it had at the start of the game.
    if specialEffect == "HomecomingInstinct" then
        
        if ensnareToggle == false then -- If ensnared, no teleporation occurs.
            bossPosition.x = 3
            bossPosition.y = 3
        end
        
        bossPosition.rot = 1 -- The forced rotation isn't affected by the ensnare
        
        result = renderDangerZone(spawnedTokensMatrix, rangeString, safeMask, bossPosition)
        if result then spawnedTokensMatrix = result end
    
    -- [SHELL EXTRA]: Ignore Clad's current position and attack from a fixed area.
    elseif specialEffect == "AttackGlobal" then
    
        -- Spawn telegraphed tokens using a preset position.
        result = renderDangerZone(spawnedTokensMatrix, rangeString, safeMask, {x=3, y=3, rot=1})
        if result then spawnedTokensMatrix = result end
        
        result = moveBoss(bossPosition, card)
        if result then bossPosition = result.bossPosition end
    
    -- DEFAULT BEHAVIOUR
    else
        -- Spawn telegraphed tokens onto the board and update spawnedTokensMatrix.
        result = renderDangerZone(spawnedTokensMatrix, rangeString, safeMask, bossPosition)
        if result then spawnedTokensMatrix = result end
        
        -- Check where the Boss now moves to and update bossPosition.
        result = moveBoss(bossPosition, card)
        if result then bossPosition = result.bossPosition end
    end
    
  end
  
  return {
      spawnedTokens = spawnedTokensMatrix,
      bossPosition = bossPosition
      }
  
end
 
function moveBoss(bossPositionInGrid, cardObject)
  -- Find GM Notes data and convert into usable form.
    local objGMNotes = cardObject.getGMNotes()
    local moveArray = nil
    local bossPosition = bossPositionInGrid

    if objGMNotes ~= '' and objGMNotes ~= nil then
        data = JSON.decode(objGMNotes)
        moveArray = data.Move
    end 
    
    if moveArray == nil then
      return bossPosition
    end
    
    printDebug("Card has Clad movement:\n  Rightward: " .. moveArray[1]
               .. "\n  Forward: "                       .. moveArray[2]
               .. "\n  Rotation: "                      .. moveArray[3])
  
    rightwardMove = moveArray[1]
    forwardMove   = moveArray[2]
    local repositionX = 0
    local repositionY = 0
    
    if bossPosition.rot == 1 then     -- North
      repositionX =  rightwardMove          -- Right  = Right
      repositionY = -forwardMove            -- Down   = Backward
    elseif bossPosition.rot == 2 then -- East
      repositionX =  forwardMove            -- Right  = Forward
      repositionY =  rightwardMove          -- Down   = Right
    elseif bossPosition.rot == 3 then -- South
      repositionX = -rightwardMove          -- Right  = Left
      repositionY =  forwardMove            -- Down   = Forward
    elseif bossPosition.rot == 4 then -- West
      repositionX = -forwardMove            -- Right  = Backward
      repositionY = -rightwardMove          -- Down   = Left
    end
    
    -- Left/Right position
    if ensnareToggle == false then
        bossPosition.x = bossPosition.x + repositionX
        bossPosition.x = ((bossPosition.x + 4) % 5) + 1 -- If a movement goes beyond 1~5 it will wrap around.
    end
    
    -- Top/Bottom position
    if ensnareToggle == false then
        bossPosition.y = bossPosition.y + repositionY
        bossPosition.y = ((bossPosition.y + 4) % 5) + 1
    end
    
    -- Facing direction
    bossPosition.rot = bossPosition.rot + moveArray[3]
    bossPosition.rot = ((bossPosition.rot + 3) % 4) + 1 -- If a direction goes beyond 1~4 it will wrap around.
    
    printDebug("New Clad position:\n  X: " .. bossPosition.x
               .. "\n  Y: "                .. bossPosition.y
               .. "\n  Rotation: "         .. bossPosition.rot)
  
    return bossPosition
    
end

-- A function that finds and returns the card above self (the card with the highest y value)
function findCardOnTop(turnSlot)

    local selfPos
    if turnSlot == 1 then
      selfPos = getObjectFromGUID(TurnSlotGUID_1).getPosition()
    elseif turnSlot == 2 then
      selfPos = getObjectFromGUID(TurnSlotGUID_2).getPosition()
    elseif turnSlot == 3 then
      selfPos = getObjectFromGUID(TurnSlotGUID_3).getPosition()
    end
    
    local allObjects = getAllObjects()
    local cardOnTop = nil
    local maxY = selfPos.y + 0.1
    for _, obj in ipairs(allObjects) do
        if obj.type == "Card" then
            local pos = obj.getPosition()
            local rot = obj.getRotation()
            local horizontalDistance = math.sqrt((pos.x - selfPos.x)^2 + (pos.z - selfPos.z)^2)
            if horizontalDistance < 1
            and pos.y < maxY
            and pos.y > selfPos.y 
            and (rot.z < 10 or rot.z > 350) then
                printDebug("Rotation: " .. tostring(rot.z))
                maxY = pos.y
                cardOnTop = obj
            end
        end
    end
    return cardOnTop
end

function clearAttackRangeTokens()
    for _, obj in ipairs(getObjectsWithTag("ArenaForecastMarker")) do
        obj.destruct()
    end
end

function findBossOnFieldBoard()
    local bossOnFieldBoard = nil
    local bossTypeTag = "BACL_BossFigurine"

    local board = Global.getVar("arenaBoard")
    if board == nil then
        printDebug("No field board holder found")
        return nil
    end

    for _, bossObject in ipairs(getObjectsWithTag(bossTypeTag)) do
        local distance = calcVectorDistance(bossObject.getPosition(), board.getPosition())
        if distance < BOSS_FIELD_MAX_DISTANCE then
            bossOnFieldBoard = bossObject
            break
        end
    end

    return bossOnFieldBoard
end

function getBossFacingDirection()
    local bossOnFieldBoard = findBossOnFieldBoard()
    if bossOnFieldBoard == nil then
        printDebug("No boss on field board")
        return 1
    end

    local initRotationString = bossOnFieldBoard.getDescription():match("INIT_ROTATION=%d+;")
    if initRotationString == nil then
        return 1
    end

    local bossInitRotation = tonumber(initRotationString:match("%d+") or 0)
    local bossRotation = tonumber(bossOnFieldBoard.getRotation().y)
    local facingRotation = math.floor(((bossRotation - bossInitRotation + 360) % 360) / 90 + 0.5) % 4 + 1

    return facingRotation
end

function getBossPositionInGrid(enemyObject)
    local bossOnFieldBoard = enemyObject
    if bossOnFieldBoard == nil then
        printDebug("No boss on field board")
        return
    end

    printDebug("Boss on field board: " .. tostring(bossOnFieldBoard.getName()))
    local board = Global.getVar("arenaBoard")
    local bossXDistance = bossOnFieldBoard.getPosition().x - board.getPosition().x
    local bossZDistance = bossOnFieldBoard.getPosition().z - board.getPosition().z

    printDebug("Boss X distance: " .. bossXDistance)
    printDebug("Boss Z distance: " .. bossZDistance)

    local bossPositionInGrid = {
        x = math.floor(bossXDistance / FIELD_GRID_DISTANCE + 0.5) + 3,
        y = -math.floor(bossZDistance / FIELD_GRID_DISTANCE + 0.5) + 3
    }
    
    printDebug("Grid Position: " .. bossPositionInGrid.x .. ", " .. bossPositionInGrid.y)

    return bossPositionInGrid
end

function renderDangerZone(spawnedTokensMatrix, attackRange, safeMask, bossPosition)

    rangeString = attackRange
    
    if rangeString == nil then
        printDebug("No range string found in object description")
        return
    end
    
    local rangeMatrix = rangeStringToRangeMatrix(rangeString)

    local board = Global.getVar("arenaBoard")
    if board == nil then
        printDebug("No field board holder found")
        return
    end

    if bossPosition == nil then
      printDebug("No boss on field board")
    end

    local bossGridDiffFromCenterX = bossPosition.x - 3
    local bossGridDiffFromCenterY = bossPosition.y - 3

    printDebug("Boss grid diff from center X: " .. bossGridDiffFromCenterX)
    printDebug("Boss grid diff from center Y: " .. bossGridDiffFromCenterY)

    local rotatedRangeMatrix = rotateMatrix(rangeMatrix, bossPosition.rot)
    local translatedRangeMatrix = translateMatrix(rotatedRangeMatrix, bossGridDiffFromCenterX, bossGridDiffFromCenterY)

    for i = 1, 5 do
      for j = 1, 5 do
        
        if safeMask[i][j] == 1 then
          printDebug("Safe mask set")
        else  
      
          local checkValue = translatedRangeMatrix[i][j] 
          local repeating = false
          
          for index, value in ipairs(spawnedTokensMatrix[i][j]) do
            if checkValue == value and checkValue != 0 then
              repeating = true
              printDebug("Repeated value " .. value .. " spotted, not spawning a new token at: " .. tostring(i) .. ", " .. tostring(j) )
            end
          end
          
          if not repeating then
            table.insert(spawnedTokensMatrix[i][j], checkValue)
          
            if (checkValue == 1 or checkValue == 6) then -- Attack zone
                renderAttackRangeTokenByGrid(j, i, 1)
            elseif (checkValue == 2 or checkValue == 6) and
                ensnareToggle == false then              -- Clad movement; does not happen when ensnared
                renderAttackRangeTokenByGrid(j, i, 2)
            elseif checkValue == 3 then                  -- Spawn Hydra Head
                renderAttackRangeTokenByGrid(j, i, 3)
            elseif checkValue == 4 then                  -- Spawn Hydra Tail
                renderAttackRangeTokenByGrid(j, i, 4)
            elseif checkValue == 5 then                  -- Legion attack zone
                renderAttackRangeTokenByGrid(j, i, 5)
            end
          end
          
        end
        
      end
    end
    
    return spawnedTokensMatrix
end

function renderAttackRangeTokenByGrid(gridX, gridY, tokenType)
    local board = Global.getVar("arenaBoard")
    local boardCenterPosition = board.getPosition()
    if tokenType == 1 then
        printDebug("Attack token at grid position: " .. gridX .. "," .. gridY)
    elseif tokenType == 2 then
        printDebug("Movement token at grid position: " .. gridX .. "," .. gridY)
    elseif tokenType == 3 then
        printDebug("Hydra head token at grid position: " .. gridX .. "," .. gridY)
    elseif tokenType == 4 then
        printDebug("Hydra tail token at grid position: " .. gridX .. "," .. gridY)
    elseif tokenType == 4 then
        printDebug("Legion attack token at grid position: " .. gridX .. "," .. gridY)
    end
    local tokenPosition = {
        x = boardCenterPosition.x + (gridX-3) * FIELD_GRID_DISTANCE,
        y = boardCenterPosition.y + 0.67,
        z = boardCenterPosition.z + (2.99 - gridY) * FIELD_GRID_DISTANCE
    }
    renderAttackRangeToken(tokenType, tokenPosition)
end

function renderAttackRangeToken(tokenType, position)
    local token = nil
    local tokenTypeString = tokenType == 1 and "Attack"
                         or tokenType == 2 and "Move"
                         or tokenType == 3 and "Legion_Head"
                         or tokenType == 4 and "Legion_Tail"
                         or tokenType == 5 and "Legion_Attack"
                         or nil

    if tokenTypeString == nil then
        printDebug("No origin token found")
        return
    end

    local spawnedObject = spawnObjectData({
        data = forecastObjects[tokenTypeString],
        position = position,
        rotation = {x=0, y=180, z=0},
        })
     
    
    -- Set the forecast object to be uninteractable to ensure players cannot move or interrupt them.
    spawnedObject.interactable = false
    spawnedObject.setLock(true)
end

function getSafeZoneMask(collisionObject, safe)
    local objDescription = collisionObject.getDescription()
    printDebug(safe)
    local safeRangeString = objDescription:match("SafeStr:.-x")
    if safeRangeString == nil then
        printDebug("No safe range string found in object description")
        return
    end
    safeRangeString = safeRangeString:sub(9, -2)
    local safeMatrix = rangeStringToRangeMatrix(safeRangeString)

    local board = Global.getVar("arenaBoard")
    if board == nil then
        printDebug("No field board holder found")
        return
    end

    local bossPositionInGrid = getBossPositionInGrid(safe)
    if bossPositionInGrid == nil then
        printDebug("No boss on field board")
        return
    end

    local bossGridDiffFromCenterX = bossPositionInGrid.x - 3
    local bossGridDiffFromCenterY = bossPositionInGrid.y - 3

    printDebug("Boss grid diff from center X: " .. bossGridDiffFromCenterX)
    printDebug("Boss grid diff from center Y: " .. bossGridDiffFromCenterY)

    local rotatedRangeMatrix = rotateMatrix(safeMatrix, getBossFacingDirection(safe))
    local translatedRangeMatrix = translateMatrix(rotatedRangeMatrix, bossGridDiffFromCenterX, bossGridDiffFromCenterY)

    return translatedRangeMatrix
end

function findNewBossPosition(bossPosition)

end

function rangeStringToRangeMatrix(rangeString)
    local rangeMatrix = {}
    for i = 1, 5 do
        rangeMatrix[i] = {}
        for j = 1, 5 do
            rangeMatrix[i][j] = 0
        end
    end

    for i = 1, #rangeString do
        local char = rangeString:sub(i, i)
        local row = math.ceil(i / 5)
        local col = (i - 1) % 5 + 1
        rangeMatrix[row][col] = tonumber(char)
    end

    return rangeMatrix
end