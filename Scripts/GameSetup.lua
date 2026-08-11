function gitLink(fileDirectory)
    return Global.call("gitLink", fileDirectory)
end

local btnScale  = 1200
local btnMargin = 5   -- Percentage

local btnSpacing           = (1 + (btnMargin/100)) / 490
local luaToXmlRatioPos     = 100
local luaToXmlRatioBtnSize = 0.204

local btnTransparency = 0

-- The relative offset for each button position.
-- These are not defined within the characterData table for easier modification and re-use.
-- We only use X and Z because Y is fixed for all buttons!
local xmlSwitches = {
    mode_default = {
        type = "mode",
        state = true,
        imageEnabled  = gitLink("/UI/Gamemode_Versus_Enabled.png"),
        imageDisabled = gitLink("/UI/Gamemode_Versus_Disabled.png"),
        tooltip       = "Free-For-All Mode",
        },
    mode_coop = {
        type = "mode",
        state = false,
        imageEnabled  = gitLink("/UI/Gamemode_Coop_Enabled.png"),
        imageDisabled = gitLink("/UI/Gamemode_Coop_Disabled.png"),
        tooltip       = "Cooperation Mode",
        },
    setup_auto = {
        type = "setup",
        state = true,
        imageEnabled  = gitLink("/UI/Gamemode_Auto_Enabled.png"),
        imageDisabled = gitLink("/UI/Gamemode_Auto_Disabled.png"),
        tooltip       = "Automated Setup",
        },
    setup_manual = {
        type = "setup",
        state = false,
        imageEnabled  = gitLink("/UI/Gamemode_Manual_Enabled.png"),
        imageDisabled = gitLink("/UI/Gamemode_Manual_Disabled.png"),
        tooltip       = "Manual Setup",
        }
}
local messageColors = Global.getTable("messageColors")
local positionLayout  = {
    ["mode_label"]     = {x = -2.5, y = 0, z = 4},
    ["mode_default"]   = {x = -0.5, y = 0, z = 4},
    ["mode_coop"]      = {x =  1.5, y = 0, z = 4},
    ["setup_label"]    = {x = -2.5, y = 0, z = 2},
    ["setup_auto"]     = {x = -0.5, y = 0, z = 2},
    ["setup_manual"]   = {x =  1.5, y = 0, z = 2},
    ["gameSetup"]      = {x =  0, y = 0.7, z = 0},
}

-- UTILITY FUNCTIONS
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function printDebug(message)
    if Global.call("isDebug") then
        print(message)
    end
end

function snapPointHasTag(snapPoint, checkTerm)
    if snapPoint == nil then return false end
    if snapPoint.tags == nil then return false end
    
    local checkFound = false
    for _, tag in ipairs(snapPoint.tags) do
        if tag == checkTerm then checkFound = true end
    end
    return checkFound
end

function getBoardSnapPointPosition(boardObj, snapPointName)
    local boardSnapPoint = nil
    local boardRotation = boardObj.getRotation()
    printDebug("Board rotation: " .. boardRotation.x .. ", " .. boardRotation.y .. ", " .. boardRotation.z .. ", ")

    for _, snapPoint in ipairs(boardObj.getSnapPoints()) do
        if snapPointHasTag(snapPoint, snapPointName) then
            boardSnapPoint = snapPoint
        end
    end
    if boardSnapPoint ~= nil then
        return boardObj.positionToWorld(Vector(boardSnapPoint.position))
    end
end

function getPlayerFigure(player)
    local witchFigure       = nil
    for _, obj in ipairs(getObjectsWithTag("WitchFigure")) do
        if obj.hasTag("PlayerOwned_" .. player) then
            witchFigure = obj
        end
    end
    
    if witchFigure == nil then
        return nil
    end
    
    return witchFigure
end

function getPlayerCharacter(player)
    local playerBoard = Global.call("getPlayerBoard", player)
    if playerBoard == nil then return nil end
    
    local boardGMNotes = JSON.decode(playerBoard.getGMNotes())
    local charName = boardGMNotes and boardGMNotes.charID or nil
    
    return charName
end


-- EVENT TRIGGERS
function onLoad()  
    -- Create the visual layout of buttons.
    generateButtons()
end



-- BUTTON SETUP FUNCTIONS
-- [→onLoad()]: Sets up the clickable images onto the player boards.
function generateButtons()
    --[=[ Loop through all characters and create two elements:
      TILE:
        A decorative image rendered through the UI setting of the object (set as an XML file).
        It has no click events and is purely so our buttons can have custom images (so cute!)
      BUTTON
        The interactive element catching click events. It is placed slightly below the decal (the decal will not block click detection).
    --]=]
    local menuTiles  = {}
    local menuButtons = {}
    
    -- Loop through and generate Character buttons
    for switchName, xmlSwitch in pairs(xmlSwitches) do
        table.insert(
            menuTiles,
            createXMLButton({
                boardObj     = self,
                charSelect   = switchName,
                gridPosition = positionLayout[switchName],
                iconImage    = xmlSwitch.state and xmlSwitch.imageEnabled or xmlSwitch.imageDisabled,
                tooltip      = xmlSwitch.tooltip,
                buttonWidth  = 2
                })
        )
        
        -- Secondary cache images are added to ensure players load in every image
        table.insert(
            menuTiles,
            createXMLCache({
                iconImage    = xmlSwitch.imageEnabled
            })
        )
        table.insert(
            menuTiles,
            createXMLCache({
                iconImage    = xmlSwitch.imageDisabled
            })
        )
        
    end
    
    
    -- Add TTS button above the physical button for starting setup
    createGridButton({
        boardObj = self,
        clickFunction = "beginGameSetup",
        label = "BEGIN\nSETUP",
        fontSize = 500,
        width = 1,
        height = 1,
        position   = positionLayout["gameSetup"],
        scale = {x=1, y=1, z=1},
        color = {r=0, g=0, b=0, a=0},
        font_color = {r=255, g=255, b=255, a=100},
        })
    
    -- Add labels near the setting buttons for decorative purposes
    createGridButton({
        boardObj = self,
        clickFunction = "None",
        label = "GAMEMODE",
        fontSize = 600,
        width = 0,
        height = 0,
        position   = positionLayout["mode_label"],
        scale = {x=1, y=1, z=1},
        color = {r=0, g=0, b=0, a=0},
        font_color = {r=255, g=255, b=255, a=100},
        })
    createGridButton({
        boardObj = self,
        clickFunction = "None",
        label = "SETUP",
        fontSize = 600,
        width = 0,
        height = 0,
        position   = positionLayout["setup_label"],
        scale = {x=1, y=1, z=1},
        color = {r=0, g=0, b=0, a=0},
        font_color = {r=255, g=255, b=255, a=100},
        })
        
    -- Add all created tiles to the XML.
    self.UI.setXmlTable(menuTiles)
end
-- Creates a TTS Button element and returns an XML table for an image lined up with the button.
-- We return the element so we can combine the button tables into one table to generate the final XML.
function createXMLButton(args)
    -- The args table includes the following:
    --   boardObj
    --   charSelect
    --   gridPosition
    --   iconImage
    --   tooltip
    --   initActive
    --   buttonWidth 
    args.buttonWidth = args.buttonWidth or 1
    args.gridPosition.x = args.gridPosition.x + (0.5 * (args.buttonWidth - 1))
    
    -- We receive the grid-based position and scale it according to the button sizes.
    -- We do not use the Y position as all buttons are kept on the same height.
    local placementPosition = {
        x = args.gridPosition.x * btnScale,
        y = (args.gridPosition.y * 0.1) + 0,
        z = args.gridPosition.z * btnScale,
    }

    --[=[ Generate the XML image.
          A LOT of garbage math because the Lua buttons and XML images do not use the same scales.
          In-game the buttons may appear slightly smaller, this is because TTS has a small, invisible,
          FIXED SIZE padding around the buttons. This scales the image to the clickable size of the button
          as opposed to the visible size. --]=]
    local XMLTile = {
        tag = "Image",
        attributes = {
            id            = args.charSelect,
            image         = args.iconImage or "",
            active        = true,
            height        = btnScale*luaToXmlRatioBtnSize,
            width         = btnScale*luaToXmlRatioBtnSize * args.buttonWidth,
            position      =
                placementPosition.x * luaToXmlRatioPos * btnSpacing * -1 .. " " ..
                placementPosition.z * luaToXmlRatioPos * btnSpacing * -1 .. " " .. 
                (placementPosition.y * luaToXmlRatioPos * -1) + -1, -- Negative because XML images are stupid; and a tiny bit above to maybe fix the stupid rendering.
            rotation      = "0 0 180", -- The entire thing is upside down because the XML buttons just RENDER THAT WAY I GUESS.
            raycastTarget = false,
            visibility    = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey"
      }}
        
    createGridButton({
        boardObj      = args.boardObj,
        clickFunction = 'onClick_' .. args.charSelect .. args.boardObj.getGUID(),
        color         = {0.2, 1, 1, btnTransparency},
        position      = {
            x = args.gridPosition.x,
            y = placementPosition.y,
            z = args.gridPosition.z,
            },
        tooltip       = args.tooltip,
        active        = args.initActive or true,
        width         = args.buttonWidth,
        })
    
    _G["onClick_" .. args.charSelect .. args.boardObj.getGUID()] = function(obj, player, alt_click)
        updateSetting(args.charSelect)
        end
    
    return XMLTile
end

function createXMLCache(args)
    -- The args table includes the following:
    --   charSelect
    --   iconImage

    --[=[ Generate the XML image.
          A LOT of garbage math because the Lua buttons and XML images do not use the same scales.
          In-game the buttons may appear slightly smaller, this is because TTS has a small, invisible,
          FIXED SIZE padding around the buttons. This scales the image to the clickable size of the button
          as opposed to the visible size. --]=]
    local XMLTile = {
        tag = "Image",
        attributes = {
            id            = args.iconImage .. "-cache",
            image         = args.iconImage or "",
            active        = true,
            height        = 0,
            width         = 0,
            position      = {x=0, y=0, z=0},
            rotation      = "0 0 0",
            raycastTarget = false,
            visibility    = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey"
      }}
    
    return XMLTile
end


function createGridButton(args)
    args.boardObj.createButton({
        label          = args.label,
        font_size      = args.fontSize or 50,
        click_function = args.clickFunction,
        function_owner = self,
        width          = btnScale * (args.width or 1),
        height         = btnScale * (args.height or 1),
        color          = args.color or {1, 1, 1, 1},
        font_color     = args.font_color or {r=0, g=0, b=0, a=1},
        position       = {
            x =  (args.position.x or 0) * btnScale * btnSpacing, -- NOT Negative because buttons are exceeding stupid
            y =  (args.position.y or 1),
            z =  (args.position.z or 0) * btnScale * btnSpacing * -1,
        },
        tooltip        = args.tooltip or "",
        scale          = args.active == false and {x=0, y=0, z=0} or args.scale or {x=1, y=1, z=1},
    })
end



-- SETTING CONTROLLER FUNCTIONS
function updateSetting(selectedSetting)
    for name, switch in pairs(xmlSwitches) do
        if switch.type == xmlSwitches[selectedSetting].type then
            switch.state = false
        end
    end
    
    xmlSwitches[selectedSetting].state = true
    
    updateSwitchImages()
end

function updateSwitchImages()
    xmlTable = self.UI.getXmlTable()
    for _, tag in ipairs(xmlTable) do
        local switchData = xmlSwitches[tag.attributes.id]
        if switchData then
            if switchData.state then
                tag.attributes.image = switchData.imageEnabled
            else
                tag.attributes.image = switchData.imageDisabled
            end
        end
    end
    
    self.UI.setXmlTable(xmlTable)
end



-- SETUP FUNCTIONS
function beginGameSetup()
    local buttonObj = nil
    local gameSettings = {
        mode = 1,
        setup = 1}
    
    for _, obj in pairs(getObjectsWithTag("Tool_SetupButton")) do
        buttonObj = obj
        break
    end
    buttonObj.AssetBundle.playTriggerEffect(0)
    
    if xmlSwitches["mode_default"].state == false then
        gameSettings.mode  = 2
    end
    if xmlSwitches["setup_auto"].state == false then
        gameSettings.setup  = 2
    end
    
    Wait.time(
        function()
            Global.call("gameSetup", gameSettings)
        end,
        0.5)
end