-- UTILITY FUNCTIONS
function deepcopy(orig)
    return Global.call("deepcopy", orig)
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

function gitLink(fileDirectory)
    return Global.call("gitLink", fileDirectory)
end



-- VARIABLES
local btnScale  = 1300
local btnMargin = 5   -- Percentage

local btnSpacing           = (1 + (btnMargin/100)) / 490
local luaToXmlRatioPos     = 100
local luaToXmlRatioBtnSize = 0.204

local btnTransparency = 0

--[=[ The stored data of call Clad types, including metadata. 

    [*KEY]        = The Clad's identifying name for the purposes of scripting and tooltips. 
    icon          = The image shown as the button.     
    
    deck = Data for the Clad decks.
        faceURL       = URL of card fronts.
        backURL       = URL of card backs
        imgGridWidth  = Horizontal width of image for how many cards wide it is.
        imgGridHeight = Vertical height of image for how many cards tall it is.
        cardList      = List of all cards in the deck.
            voltage1 = Voltage 1 cards
            voltage2 = Voltage 2 cards
            voltage3 = Voltage 3 cards
                gridPos  = Where in the deck image the card is positioned.
                name     = Name of card.
                range    = Code value for the attack ranges and attack types.
                movement = Final resulting position of the Clad of form {vertical, horizontal, rotation}.   
]=]
local cladData = {
    ["Wyrm Clad"] = {
    sourceGame = "Base Game",
    modelIndex = 1,
    icon = gitLink("Clad/Wyrm/Wyrm_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Wyrm/Wyrm_cladCards.webp"),
        backURL       = gitLink("Clad/Wyrm/Wyrm_cardBack.png"),
        imgGridWidth  = 4,
        imgGridHeight = 4,
        cardList      = {
            voltage1 = {
                { gridPos = 0,  name = "Veer Left",     range="0000000200000000000000000", movement={0, 1, 3}},
                { gridPos = 1,  name = "Veer Right",    range="0000000200000000000000000", movement={0, 1, 1}},
                { gridPos = 2,  name = "Whirlwind",     range="0000001010010100000000000", movement={0, 0, 2}},
                { gridPos = 3,  name = "Rending Claws", range="0000001110000000000000000", movement={0, 0, 0}},
                { gridPos = 4,  name = "Tail Whip",     range="0000000000000000111000000", movement={0, 0, 0}},
                { gridPos = 5,  name = "Searing Blast", range="0111000100000000000000000", movement={0, 0, 0}},
                },
            voltage2 = {
                { gridPos = 6,  name = "Rush",          range="0020000200000000000000000", movement={0, 2, 0}},
                { gridPos = 7,  name = "Shake Off",     range="0000001210010100101000000", movement={0, 1, 0}},
                { gridPos = 8,  name = "Searing Blaze", range="1111111611000000000000000", movement={0, 1, 0}},
                },
            voltage3 = {
                { gridPos = 9,  name = "Seismic Shock",        range="1111110001100011000111111", movement={0, 0, 0}},
                { gridPos = 10, name = "Savage Sweep (Right)", range="0001100011000110001100011", movement={0, 0, 3}},
                { gridPos = 11, name = "Savage Sweep (Left)",  range="1100011000110001100011000", movement={0, 0, 1}},
                }
            },
        },
    },
    ["Shell Clad"] = {
    sourceGame = "CROSS FATE",
    modelIndex = 2,
    icon = gitLink("Clad/Shell/Shell_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Shell/Shell_cladCards.webp"),
        backURL       = gitLink("Clad/Shell/Shell_cardBack.jpg"),
        imgGridWidth  = 7,
        imgGridHeight = 2,
        cardList      = {
            voltage1 = {
                { gridPos = 0,  name = "Invasion",     range="0000000200000000000000000", movement={0, 1, 0}},
                { gridPos = 1,  name = "Thrash Left",  range="0000001100010000000000000", movement={0, 0, 1}},
                { gridPos = 2,  name = "Thrash Right", range="0000000110000100000000000", movement={0, 0, 3}},
                { gridPos = 3,  name = "Retreat",      range="0000000100000000020000000", movement={0,-1, 0}},
                { gridPos = 4,  name = "Erosion",      range="0111001110000000000000000", movement={0, 0, 0}},
                { gridPos = 5,  name = "Side Spikes",  range="0000000000110110000000000", movement={0, 0, 2}},
                },
            voltage2 = {
                { gridPos = 7,  name = "Lacerate Backward", range="0000000200000001111111111", movement={0, 1, 0}},
                { gridPos = 8,  name = "Reckless Abandon",  range="0010001110010100111000100", movement={0, 0, 0}},
                { gridPos = 9,  name = "Line Spikes",       range="0101001010010100101001010", movement={0, 0, 0}},
                },
            voltage3 = {
                { gridPos = 10, name = "Lacerate Right", range="0001100011020110001100011", movement={-1, 0, 0}},
                { gridPos = 11, name = "Lacerate Left",  range="1100011000110201100011000", movement={1, 0, 0}},
                { gridPos = 12, name = "Banish",         range="1101111011000001101111011", movement={0, 0, 0}},
                }
            },
        },
    },
    ["Hydra Clad"] = {
    sourceGame = "HacKClaD.DeltA",
    modelIndex = 1,
    icon = gitLink("Clad/Hydra/Hydra_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Hydra/Hydra_cladCards.webp"),
        backURL       = gitLink("Clad/Hydra/Hydra_cardBack.png"),
        imgGridWidth  = 7,
        imgGridHeight = 2,
        cardList      = {
            voltage1 = {
                { gridPos = 0,  name = "Spiral Ambush (Right)", range="0000000030000000000000000", movement={0, 0, 3}},
                { gridPos = 1,  name = "Spiral Ambush (Left)",  range="0000003000000000000000000", movement={0, 0, 1}},
                { gridPos = 2,  name = "Skewer",                range="0000000000040400000000000", movement={0, 0, 0}},
                { gridPos = 3,  name = "Savage Fangs",          range="0000001110000000000000000", movement={0, 0, 3}},
                { gridPos = 4,  name = "Scorching Breath",      range="0111000100000000000000000", movement={0, 0, 0}},
                { gridPos = 5,  name = "Backslam",              range="0000000000000000111000100", movement={0, 0, 0}},
                },
            voltage2 = {
                { gridPos = 7,  name = "Terrain Crush",       range="0020000200000000040000000", movement={0, 2, 0}},
                { gridPos = 8,  name = "Incinerating Flames", range="1111111311000000000000000", movement={0, 0, 1}},
                { gridPos = 9,  name = "Sweeping Strike",     range="0000001210010100101000000", movement={0, 1, 0}},
                },
            voltage3 = {
                { gridPos = 10, name = "Crashing Footfalls (Left)",  range="1100013200110001100011000", movement={0, 1, 0}},
                { gridPos = 11, name = "Crashing Footfalls (Right)", range="0001100231000110001100011", movement={0, 1, 0}},
                { gridPos = 12, name = "Homecoming Instinct",        range="0004040000002000000404000", movement={0, 0, 0}, special="HomecomingInstinct"},
                }
            },
        },
    },
    ["Wyrm Clad (Expert)"] = {
    sourceGame = "Base Game",
    modelIndex = 1,
    icon = gitLink("Clad/Wyrm/Wyrm_Expert_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Wyrm/Wyrm_cladCards.webp"),
        backURL       = gitLink("Clad/Wyrm/Wyrm_cardBack.png"),
        imgGridWidth  = 4,
        imgGridHeight = 4,
        cardList      = {
            voltage1 = {
                { gridPos = 13, name = "Sweep Left",    range="0110001200000000000000000", movement={0, 1, 3}},
                { gridPos = 12, name = "Sweep Right",   range="0011000210000000000000000", movement={0, 1, 1}},
                { gridPos = 2,  name = "Whirlwind",     range="0000001010010100000000000", movement={0, 0, 2}},
                { gridPos = 3,  name = "Rending Claws", range="0000001110000000000000000", movement={0, 0, 0}},
                { gridPos = 4,  name = "Tail Whip",     range="0000000000000000111000000", movement={0, 0, 0}},
                { gridPos = 5,  name = "Searing Blast", range="0111000100000000000000000", movement={0, 0, 0}},
                },
            voltage2 = {
                { gridPos = 14, name = "Tail Rush",     range="0020000200000000010000100", movement={0, 2, 0}},
                { gridPos = 7,  name = "Shake Off",     range="0000001210010100101000000", movement={0, 1, 0}},
                { gridPos = 8,  name = "Searing Blaze", range="1111111611000000000000000", movement={0, 1, 0}},
                },
            voltage3 = {
                { gridPos = 9,  name = "Seismic Shock",        range="1111110001100011000111111", movement={0, 0, 0}},
                { gridPos = 10, name = "Savage Sweep (Right)", range="0001100011000110001100011", movement={0, 0, 3}},
                { gridPos = 11, name = "Savage Sweep (Left)",  range="1100011000110001100011000", movement={0, 0, 1}},
                }
            },
        },
    },
    ["Wyrm Clad (Extra)"] = {
    sourceGame = "Extra Clad Decks",
    modelIndex = 1,
    icon = gitLink("Clad/Wyrm_Extra/Wyrm_Extra_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Wyrm_Extra/Wyrm_Extra_cladCards.webp"),
        backURL       = gitLink("Clad/Wyrm_Extra/Wyrm_Extra_cardBack.png"),
        imgGridWidth  = 7,
        imgGridHeight = 2,
        cardList      = {
            voltage1 = {
                { gridPos = 0,  name = "Knockdown (Right)", range="0000000020000200000000000", movement={1, 1, 0}},
                { gridPos = 1,  name = "Tail Whip+",        range="0000000000000000111000100", movement={0, 0, 0}},
                { gridPos = 2,  name = "Absorb",            range="0000001210010100101000000", movement={0, 1, 0}},
                { gridPos = 3,  name = "Knockdown (Left)",  range="0000002000020000000000000", movement={-1, 1, 0}},
                { gridPos = 4,  name = "Whirlwind+",        range="0000001110000000111000000", movement={0, 0, 2}},
                { gridPos = 5,  name = "Searing Blast",     range="0111000100000000000000000", movement={0, 0, 0}},
                },
            voltage2 = {
                { gridPos = 7,  name = "Wing Attack (Right)", range="0000100001000110000100001", movement={0, 0, 3}},
                { gridPos = 8,  name = "Wing Attack (Left)",  range="1000010000110001000010000", movement={0, 0, 1}},
                { gridPos = 9,  name = "Wide Breath",         range="1111111211000000000000000", movement={0, 1, 0}},
                },
            voltage3 = {
                { gridPos = 10,  name = "Rampage",    range="0020000200000001111111111", movement={0, 2, 0}},
                { gridPos = 11, name = "Howling",    range="0000001110011100111000000", movement={0, 0, 1}},
                { gridPos = 12, name = "Earthquake", range="1111110001100011000111111", movement={0, 0, 0}},
                }
            },
        },
    },
    ["Shell Clad (Extra)"] = {
    sourceGame = "Extra Clad Decks",
    modelIndex = 2,
    icon = gitLink("Clad/Shell_Extra/Shell_Extra_icon.png"),
    deck = {
        faceURL       = gitLink("Clad/Shell_Extra/Shell_Extra_cladCards.webp"),
        backURL       = gitLink("Clad/Shell_Extra/Shell_Extra_cardBack.png"),
        imgGridWidth  = 7,
        imgGridHeight = 2,
        cardList      = {
            voltage1 = {
                { gridPos = 0,  name = "Left Thrash", range="0000001100010000000000000", movement={0, 0, 1}},
                { gridPos = 1,  name = "Invasion",    range="0000000200000000111000000", movement={0, 1, 0}},
                { gridPos = 2,  name = "Spear Shot",  range="0010000100000000010000100"},
                { gridPos = 3,  name = "Righ Thrash", range="0000000110000100000000000", movement={0, 0, 3}},
                { gridPos = 4,  name = "Side Spikes", range="0000000000110110000000000", movement={0, 0, 2}},
                { gridPos = 5,  name = "Erosion",     range="0111001110000000000000000"},
                },
            voltage2 = {
                { gridPos = 7,  name = "Recover",    range="0000001010010100101000000", movement={0, 0, 3}},
                { gridPos = 8,  name = "Left Whip",  range="0100001000120000100001000", movement={-1, 0, 0}},
                { gridPos = 9,  name = "Right Whip", range="0001000010000210001000010", movement={1, 0, 0}},
                },
            voltage3 = {
                { gridPos = 10,  name = "Stampede O", range="1010101010101010101010101", special="AttackGlobal"},
                { gridPos = 11, name = "Stampede X",  range="0101010101010101010101010", special="AttackGlobal"},
                { gridPos = 12, name = "Anchor",      range="0000001010000000101000000"},
                }
            },
        },
    },
}

-- The relative offset for each button position.
-- These are not defined within the characterData table for easier modification and re-use.
-- We only use X and Z because Y is fixed for all buttons!
local positionLayout  = {
    ["Wyrm Clad"]          = {x = -1.0, y = 0, z =  2.4},
    ["Wyrm Clad (Expert)"] = {x =  0.0, y = 0, z =  2.4},
    ["Wyrm Clad (Extra)"]  = {x =  1.0, y = 0, z =  2.4},
    
    ["Shell Clad"]         = {x = -0.5, y = 0, z =  1.2},
    ["Shell Clad (Extra)"] = {x =  0.5, y = 0, z =  1.2},
    
    ["Hydra Clad"]         = {x =  0.0, y = 0, z =  0.0},
    
    ["Random_Clad"]        = {x = -0.5, y = 0, z = -1.5},
    ["Clear_Clad"]         = {x =  0.5, y = 0, z = -1.5},
}
local templateObjects = Global.getTable("templateObjects")



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
    for charName, character in pairs(cladData) do
        printDebug('looping through charTable: ' .. tostring(charName))

        local tooltipText = charName
        if character.sourceGame then
            tooltipText = tooltipText .. "\n(" .. character.sourceGame .. ")"
        end
        table.insert(
            menuTiles,
            createXMLButton({
                boardObj     = self,
                charSelect   = charName,
                gridPosition = positionLayout[charName],
                iconImage    = character.icon,
                tooltip      = tooltipText,
                })
        )
    end

    -- Random selection buttons
    table.insert(
        menuTiles,
        createXMLButton({
            boardObj     = self,
            charSelect   = "Random",
            gridPosition = positionLayout["Random_Clad"],
            iconImage    = gitLink("UI/RandomClad.png"),
            tooltip      = "Random Clad",
            })
        )
    -- Clear selection button
    table.insert(
        menuTiles,
        createXMLButton({
            boardObj     = self,
            charSelect   = "Clear",
            gridPosition = positionLayout["Clear_Clad"],
            iconImage    = gitLink("Characters/Cancel/Cancel_charSelect.png"),
            tooltip      = "Clear clad deck"
            })
        )
    
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

    -- We receive the grid-based position and scale it according to the button sizes.
    -- We do not use the Y position as all buttons are kept on the same height.
    local placementPosition = {
        x = args.gridPosition.x * btnScale,
        y = (args.gridPosition.y * 0.1) + 1,
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
            width         = btnScale*luaToXmlRatioBtnSize,
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
        active        = args.initActive or true
        })
    
    _G["onClick_" .. args.charSelect .. args.boardObj.getGUID()] = function(obj, player, alt_click)
        cladSelect(args.charSelect)
        end
    
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
        position       = {
            x =  (args.position.x or 0) * btnScale * btnSpacing, -- NOT Negative because buttons are exceeding stupid
            y =  (args.position.y or 1),
            z =  (args.position.z or 0) * btnScale * btnSpacing * -1,
        },
        tooltip        = args.tooltip or "",
        scale          = args.active == false and {x=0, y=0, z=0} or {x=1, y=1, z=1},
    })
end



-- CLAD DECK COMPONENT SPAWNING FUNCTIONS
function cladSelect(character_ID)
    -- Check for override inputs
    if character_ID == "Random" then
        character_ID = selectRandomClad()
        spawnComponentsClad(character_ID)
        changeCladModel(character_ID)
    elseif character_ID == "Clear" then
        removeAllCladOwnedObjects()
    else
        spawnComponentsClad(character_ID)
        changeCladModel(character_ID)
    end
end

function spawnComponentsClad(clad_ID)
    
    local turnBoard = Global.getVar("turnBoard")
    
    local deckPositions = {
        voltage1 = getBoardSnapPointPosition(turnBoard, "~Voltage1"),
        voltage2 = getBoardSnapPointPosition(turnBoard, "~Voltage2"),
        voltage3 = getBoardSnapPointPosition(turnBoard, "~Voltage3"),
        }
        
    removeAllCladOwnedObjects()

    local cladDeckVoltage1 = spawnCladDeck({
        objData   = generateCladDeck(cladData[clad_ID].deck, "voltage1"),
        snapPoint = "~Voltage1",
        flipped   = true,
        })
        
    local cladDeckVoltage2 = spawnCladDeck({
        objData   = generateCladDeck(cladData[clad_ID].deck, "voltage2"),
        snapPoint = "~Voltage2",
        offset    = {y = -1},
        flipped   = gameModeToggle == "Coop" and true or false,
        })
    
    local cladDeckVoltage3 = spawnCladDeck({
        objData   = generateCladDeck(cladData[clad_ID].deck, "voltage3"),
        snapPoint = "~Voltage3",
        offset    = {y = -1},
        flipped   = gameModeToggle == "Coop" and true or false,
        })
      
end
-- Randomly selects a vaid Witch name with any of the defined characters listed in characterData.
function selectRandomClad()
    -- Get a list of all available characters.
    local allClad = {}
    for charName, _ in pairs(cladData) do
        table.insert(allClad, charName)
    end
    
    -- Randomly pick an entry from the list.
    -- math.random() here selects an integer from 1 to the length of the list.
    -- This happens to be all possible indexes of the list.
    return allClad[math.random(#allClad)]
end
-- Find all objects owned by a player and deletes them. (Only affects objects with the correct tag!)
function removeAllCladOwnedObjects()
    for _, object in ipairs(getObjectsWithTag("PlayerOwned_Clad")) do
        object.Destruct()
    end
end

function changeCladModel(cladID)
    local modelIndex = cladData[cladID].modelIndex

    -- Get the clad model object
    local cladObj = nil
    for _, obj in pairs(getObjectsWithTag("BACL_BossFigurine")) do
        cladObj = obj
    end
    if modelIndex ~= cladObj.getStateId() then
        cladObj.setState(modelIndex)
    end
end



-- OBJECT CREATION FUNCTIONS
-- Each function handles different object types to create.
-- Due to the rather bespoke nature of each type they've been split across multiple functions.
function spawnCladDeck(arg)
        -- Define values
        local objData           = arg.objData
        local turnBoard         = arg.turnBoard or Global.getVar("turnBoard")
        local snapPointName     = arg.snapPoint
        local boardSnapPoint    = nil
        local snapPointPosition = nil
        local snapPointRotation = nil
        local offset            = {x        = arg.offset and arg.offset.x   or 0,
                                   y        = arg.offset and arg.offset.y   or 0,
                                   z        = arg.offset and arg.offset.z   or 0,
                                   rotation = arg.offset and arg.offset.rot or 0}
        local flipped           = arg.flipped or false
        local registered        = arg.registered or false
        local interactable      = arg.registered or true
        if objData == nil or turnBoard  == nil then error("Invalid spawnCladDeck command.") return end
        
        printDebug("Given board: " .. turnBoard .getGUID())
        local boardRotation = turnBoard .getRotation()
        printDebug("Board rotation: " .. boardRotation.x .. ", " .. boardRotation.y .. ", " .. boardRotation.z .. ", ")

        for _, snapPoint in ipairs(turnBoard.getSnapPoints()) do
            if snapPointHasTag(snapPoint, snapPointName) then
                boardSnapPoint = snapPoint
                snapPointPosition = Vector(snapPoint.position)
                snapPointRotation = Vector(snapPoint.rotation)
            end
        end
        if boardSnapPoint == nil then return false end

        local spawnPosition = turnBoard.positionToWorld({
            x = snapPointPosition.x + offset.x,
            y = offset.y + 0.5,
            z = snapPointPosition.z + offset.z
        })
        
        local spawnRotation = {
            x = boardRotation.x + 0,
            y = boardRotation.y + snapPointRotation.y + offset.rotation,
            z = boardRotation.z + (flipped and 180 or 0)
        }
        
        local spawnedObject = spawnObjectData({
            data = objData,
            position = spawnPosition,
            rotation = spawnRotation,
            callback_function = function(spawnedObj)
                -- Set registered (Optional).
                if registered then
                    spawnedObj.registerCollisions()
                end
                -- Set uninteractable (Optional).
                if interactable == false then
                    spawnedObj.interactable = false
                end
            end
        })
        
        return spawnedObject
end

function generateObject(arg)
    --[=[ The data structure MUST abide by the following:
    objData = {
        frontURL   = Front facing image for CustomImage data.
        backURL    = Back facing image for CustomImage data.
        colour     = Colour of object.
        tags       = table of additional tags to add to object.
        scale      = resizing of object. All axes are optional.
        name       = name of the object. Shows up in hover-overs.
        }
    ]=]
    local objType = arg.objType
    local objData = arg.objData or {}
    local player  = arg.player
    if objType == nil then error("No valid objType given for generateObject.") return end
    
    local outputObject = deepcopy(templateObjects[objType])
    
    -- CustomImage properties, if able.
    if outputObject.CustomImage then
        outputObject.CustomImage.ImageURL          = objData.frontURL or ""
        outputObject.CustomImage.ImageSecondaryURL = objData.backURL  or ""
        
        -- CustomTile properties, if able
        if outputObject.CustomImage.CustomTile then
            outputObject.CustomImage.CustomTile.Type      = objData.tileType or outputObject.CustomImage.CustomTile.Type    
            outputObject.CustomImage.CustomTile.Thickness = objData.tileThickness or outputObject.CustomImage.CustomTile.Thickness
            
        end
    end

    -- Colouring for tokens or edges of tiles
    if objData.colour then
        outputObject.ColorDiffuse = {
            r = (objData.colour.r or 0) / 255,
            g = (objData.colour.g or 0) / 255,
            b = (objData.colour.b or 0) / 255,
            a = (objData.colour.a or 255) / 255
            }
    end
    
    -- Resizing object
    if objData.scale then
        outputObject.Transform.scaleX = objData.scale.x or outputObject.Transform.scaleX
        outputObject.Transform.scaleY = objData.scale.y or outputObject.Transform.scaleY
        outputObject.Transform.scaleZ = objData.scale.z or outputObject.Transform.scaleZ
    end

    -- Additional tags
    if objData.tags then
        for _, tag in ipairs(objData.tags) do
            table.insert(outputObject.Tags, tag)
        end
    end
    
    -- Name
    if objData.name then
        outputObject.Nickname = objData.name
    end
    
    -- Assign object to be owned by the player, and thus removable when character is deselected.
    if player ~= nil then
        table.insert(outputObject.Tags, "PlayerOwned_" .. player)
    end
    
    -- Output the final object.
    return outputObject
end

function generateCladDeck(deckData, deckType)
    local outputObject = generateObject({
            objType = "Deck",
            player  = "Clad"
            })
            
    outputObject.CustomDeck = {
        ["1"] = {
              FaceURL      = deckData.faceURL ,
              BackURL      = deckData.backURL,
              NumWidth     = deckData.imgGridWidth,
              NumHeight    = deckData.imgGridHeight,
              BackIsHidden = true,
              UniqueBack   = false,
              Type = 0
        }
    }
    
    -- Iterate over all cards from the given deck type (standard / enhanced)
    for i, card in ipairs(deckData.cardList[deckType]) do
        -- TTS REQUIRES the number be formatted as a 2 digit ID concatenated to the CustomDeck ID number.
        -- i.e. The first card must be X00, followed by X01.
        local GeneratedID = "1" .. string.format("%02d" , card.gridPos)
        
        table.insert(outputObject.ContainedObjects, {
            Name = "Card",
            Nickname = card.name,
            CardID   = GeneratedID,
            Transform = {}, -- This fixes the bug making decks unsearchable.
            GMNotes  =  JSON.encode({
                Voltage = string.sub(deckType, 8),
                Range   = card.range,
                Move    = card.movement or {0, 0, 0},
                Special = card.special,
                }),
            Tags     = {"BACL_BossActionCard", "PlayerOwned_Clad"},
            CustomDeck = {
                ["1"] = {
                    FaceURL      = deckData.faceURL ,
                    BackURL      = deckData.backURL,
                    NumWidth     = deckData.imgGridWidth,
                    NumHeight    = deckData.imgGridHeight,
                    BackIsHidden = true,
                    UniqueBack   = false,
                    Type = 0
            }} 
        })
        
        table.insert(outputObject.DeckIDs, GeneratedID)
    end
    
    return outputObject
end
