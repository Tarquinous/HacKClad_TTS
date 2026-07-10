activeGitCommit = "57cbe7b2e99f987c61874adba09d40b80313317e"
setUninteractables = true



-- UTILITY FUNCTIONS
-- Used throughout the various scripts as a general-purpose function.
function getPlayerBoard(player)
    local playerBoard       = nil
    for _, obj in ipairs(getObjectsWithTag("PlayerComponent_CharacterBoard")) do
        if obj.hasTag("PlayerOwned_" .. player) then
            playerBoard = obj
        end
    end
    
    if playerBoard == nil then
        lovSays(player, "You don't have a board available." )
        return nil
    end
    
    return playerBoard
end

function gitLink(fileDirectory)
    return "https://raw.githubusercontent.com/Artemis-of-Dust/HacKClad_TTS/" .. activeGitCommit .. "/" .. fileDirectory
end

function hexToRGB(value)
    local result = {
        (tonumber(value:sub(2,3),16) or 0)/255,
        (tonumber(value:sub(4,5),16) or 0)/255,
        (tonumber(value:sub(6,7),16) or 0)/255
        }

    return result
end

function printDebug(message)
  if isDebug() then
    print(message)
  end
end
-- Lov Says creates a player-specific broadcast in the character of Lov to inform them why something didn't work.
function lovSays(player , message)
    broadcastToColor([[Lov Says: "]] .. message .. [["]], player, messageColors.Lov)
end

function lovSaysGlobal(args)
    broadcastToColor([[Lov Says: "]] .. args.message .. [["]], args.player, messageColors.Lov)
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


-- GLOBAL VARIABLES
FIELD_GRID_DISTANCE = 3.182  -- Adjust to fit new maps if necessary
BOSS_FIELD_MAX_DISTANCE = 10  -- Adjust to fit new maps if necessary
playerPositions = {
    Red    = {x = -32.25, y = 0.3, z = -21},
    Blue   = {x = -10.20, y = 0.3, z = -21},
    Orange = {x =  11.95, y = 0.3, z = -21},
    White  = {x =  34.10, y = 0.3, z = -21}
}
messageColors = {
    Red     = {r=218/255, g=025/255, b=024/255, a=1},
    Blue    = {r=031/255, g=135/255, b=255/255, a=1},
    Orange  = {r=244/255, g=100/255, b=029/255, a=1},
    White   = {r=255/255, g=255/255, b=255/255, a=1},
    
    Black   = {r=064/255, g=064/255, b=064/255, a=1},
    
    Grey    = {r=128/255, g=128/255, b=128/255, a=1},
    Brown   = {r=113/255, g=059/255, b=023/255, a=1},
    Brown   = {r=113/255, g=059/255, b=023/255, a=1},
    Yellow  = {r=231/255, g=229/255, b=044/255, a=1},
    Green   = {r=049/255, g=179/255, b=043/255, a=1},
    Teal    = {r=033/255, g=177/255, b=155/255, a=1},
    Purple  = {r=160/255, g=032/255, b=240/255, a=1},
    Pink    = {r=245/255, g=112/255, b=206/255, a=1},
    
    Lov     = {r=181/255, g=071/255, b=255/255, a=1},
    Error   = {r=230/255, g=020/255, b=020/255, a=1},
    Default = {r=255/255, g=255/255, b=255/255, a=1}, 
}
playerData = {
    Red     = {
        reconstructMode = false,  -- A state tracking if the player is currently reforming their deck.
        boardZoneGUID   = "020e29", -- The GUIDs of the pre-defined Scripting Zones above each player board.
        position        = {x = -32.25, y = 0.3, z = -21}, -- The base position of the player's area, centred on their board.
        lastRemovedCard = nil,
        charName        = nil,
        charType        = nil,
        startingTurn    = nil,
    },
    Blue    = {
        active = true,
        reconstructMode = false,
        boardZoneGUID   = "9e915b",
        position        = {x = -10.20, y = 0.3, z = -21},
        lastRemovedCard = nil,
        charName        = nil,
        charType        = nil,
        startingTurn    = nil,
    },
    Orange  = {
        reconstructMode = false,
        boardZoneGUID   = "7244ab",
        position        = {x = 11.95, y = 0.3, z = -21},
        lastRemovedCard = nil,
        charName        = nil,
        charType        = nil,
        startingTurn    = nil,
    },
    White   = {
        reconstructMode = false,
        boardZoneGUID   = "cf4ca2",
        position        = {x = 34.10, y = 0.3, z = -21},
        lastRemovedCard = nil,
        charName        = nil,
        charType        = nil,
        startingTurn    = nil,
    },
    Black   = {
        reconstructMode = false,
        boardZoneGUID   = nil,
        position        = nil,
        lastRemovedCard = nil,
        charName        = nil,
        charType        = nil,
        startingTurn    = nil,
    }
}
handCardsBackup = {
    Red     = nil,
    Blue    = nil,
    Orange  = nil,
    White   = nil,
    
    Black   = nil,
}
missionData = {
    faceURL = gitLink("Table/MissionCards_cardFront.png"),
    backURL  = gitLink("Table/MissionCards_cardBack.png"),
    imgGridWidth  = 9,
    imgGridHeight = 2,
    cardList      = {
        { gridPos = 00, name = "Assault",         coop=true  },
        { gridPos = 01, name = "Flash",           coop=true  },
        { gridPos = 02, name = "Destroyer",       coop=true  },
        { gridPos = 03, name = "Endurance",       coop=false },
        { gridPos = 04, name = "Hard Puncher",    coop=true  },
        { gridPos = 05, name = "Collector",       coop=true  },
        { gridPos = 06, name = "Machine Gun",     coop=true  },
        { gridPos = 07, name = "Invincible",      coop=false },
        { gridPos = 08, name = "Nuclear",         coop=true  },
        { gridPos = 09, name = "Overdrive",       coop=false },
        { gridPos = 10, name = "Parry",           coop=true  },
        { gridPos = 11, name = "Rapture",         coop=false },
        { gridPos = 12, name = "Lightning Speed", coop=true  },
        { gridPos = 13, name = "Survivor",        coop=false },
        { gridPos = 14, name = "Invulnerable",    coop=true  },
        { gridPos = 15, name = "Treasure Hunter", coop=true  },
        { gridPos = 16, name = "Vitality",        coop=false },
        { gridPos = 17, name = "Wiard",           coop=false },
        }
}
shardLightSettings = {
    [0] = { -- Purple Shards
        colour = "#FF00FF",
        intensity = 200,
        range = 1,
        },
    [1] = { -- Red Shards
        colour = "#FF0000",
        intensity = 200,
        range = 1,
        },
    [2] = { -- Corruption
        colour = "#FF00FF",
        intensity = 200,
        range = 1,
        }
    }
entryPointPositions = {
    A = {x = 2, y = 1},
    B = {x = 5, y = 2},
    C = {x = 4, y = 5},
    D = {x = 1, y = 4},
}
templateObjects = {
    MagicShard_1 = {
        GUID = nil,
        Name = "Custom_Model",
        Transform = {
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 0.8,
            scaleY = 0.8,
            scaleZ = 0.8,
          },
        Nickname     = "Magic Shard",
        Description  = "",
        GMNotes = "{\"Type\":0,\"VP\":1}",
        Tags         = {},
        AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse = {
            r = 0.6235,
            g = 0.1176,
            b = 0.9373,
            a = 0.9412
        },
        Tags = { "MagicShard" },
        LayoutGroupSortIndex = 0,
        Value        = 0,
        Locked       = false,
        Grid         = false,
        Snap         = false,
        IgnoreFoW    = false,
        MeasureMovement = false,
        DragSelectable = true,
        Autoraise    = true,
        Sticky       = false,
        Tooltip      = false,
        GridProjection = false,
        HideWhenFaceDown = false,
        Hands        = false,
        SidewaysCard = false,
        CustomMesh = {
            MeshURL       = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            DiffuseURL    = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/amethyst.jpg",
            NormalURL     = "",
            ColliderURL   = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            Convex        = true,
            MaterialIndex = 4,
            TypeIndex     = 0,
            CastShadows   = true,
            CustomShader = {
                SpecularColor = {
                    r = 1.0,
                    g = 1.0,
                    b = 1.0
                    },
                SpecularIntensity = 0.6,
                SpecularSharpness = 6.0,
                FresnelStrength = 0.3
            },
          },
        LuaScript    = "",
        LuaScriptState = "",
        XmlUI        = "",
        PhysicsMaterial = {
            StaticFriction  = 0.6,
            DynamicFriction = 0.3,
            Bounciness      = 0.2,
            FrictionCombine = 0,
            BounceCombine   = 0
          },
        Rigidbody = {
            Mass        = 1.0,
            Drag        = 0.1,
            AngularDrag = 0.1,
            UseGravity  = true
          }
        },
    MagicShard_5 = {
        GUID = nil,
        Name = "Custom_Model",
        Transform = {
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 1.1,
            scaleY = 1.1,
            scaleZ = 1.1,
          },
        Nickname     = "Magic Shard ×5",
        Description  = "",
        GMNotes = "{\"Type\":1,\"VP\":5}",
        Tags         = {},
        AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse = {
            r = 0.8560,
            g = 0.0999,
            b = 0.0939,
            a = 0.9412
        },
        Tags = { "MagicShard" },
        LayoutGroupSortIndex = 0,
        Value        = 0,
        Locked       = false,
        Grid         = false,
        Snap         = false,
        IgnoreFoW    = false,
        MeasureMovement = false,
        DragSelectable = true,
        Autoraise    = true,
        Sticky       = false,
        Tooltip      = false,
        GridProjection = false,
        HideWhenFaceDown = false,
        Hands        = false,
        SidewaysCard = false,
        CustomMesh = {
            MeshURL       = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            DiffuseURL    = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/ruby.jpg",
            NormalURL     = "",
            ColliderURL   = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            Convex        = true,
            MaterialIndex = 4,
            TypeIndex     = 0,
            CastShadows   = true,
            CustomShader = {
                SpecularColor = {
                    r = 1.0,
                    g = 1.0,
                    b = 1.0
                    },
                SpecularIntensity = 0.6,
                SpecularSharpness = 6.0,
                FresnelStrength = 0.3
            },
          },
        LuaScript    = "",
        LuaScriptState = "",
        XmlUI        = "",
        PhysicsMaterial = {
            StaticFriction  = 0.6,
            DynamicFriction = 0.3,
            Bounciness      = 0.2,
            FrictionCombine = 0,
            BounceCombine   = 0
          },
        Rigidbody = {
            Mass        = 1.25,
            Drag        = 0.1,
            AngularDrag = 0.1,
            UseGravity  = true
          }
        },
    Corruption = {
        GUID = nil,
        Name = "Custom_Model",
        Transform = {
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 0.9,
            scaleY = 0.9,
            scaleZ = 0.9,
          },
        Nickname     = "Corruption",
        Description  = "",
        GMNotes = "{\"Type\":2,\"VP\":0}",
        Tags         = {},
        AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        ColorDiffuse = {
            r = 1.0,
            g = 0.0,
            b = 1.0,
            a = 1.0
        },
        Tags = { "MagicShard" },
        LayoutGroupSortIndex = 0,
        Value        = 0,
        Locked       = false,
        Grid         = false,
        Snap         = false,
        IgnoreFoW    = false,
        MeasureMovement = false,
        DragSelectable = true,
        Autoraise    = true,
        Sticky       = false,
        Tooltip      = false,
        GridProjection = false,
        HideWhenFaceDown = false,
        Hands        = false,
        SidewaysCard = false,
        CustomMesh = {
            MeshURL       = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            DiffuseURL    = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/obsidian.jpg",
            NormalURL     = "",
            ColliderURL   = "https://raw.githubusercontent.com/RobMayer/TTSLibrary/master/currency/gems/raw.obj",
            Convex        = true,
            MaterialIndex = 4,
            TypeIndex     = 0,
            CastShadows   = true,
            CustomShader = {
                SpecularColor = {
                    r = 0.4667,
                    g = 0.3608,
                    b = 0.6431
                    },
                SpecularIntensity = 0.3,
                SpecularSharpness = 7.5,
                FresnelStrength = 0.3
            },
          },
        LuaScript    = "",
        LuaScriptState = "",
        XmlUI        = "",
        PhysicsMaterial = {
            StaticFriction  = 0.6,
            DynamicFriction = 0.3,
            Bounciness      = 0.2,
            FrictionCombine = 0,
            BounceCombine   = 0
          },
        Rigidbody = {
            Mass        = 1.25,
            Drag        = 0.1,
            AngularDrag = 0.1,
            UseGravity  = true
          }
        },
    Deck = {
    GUID = nil,
    Name = "Deck",
    Transform = {
        posX = 0,
        posY = 0,
        posZ = 0,
        rotX = 0,
        rotY = 0,
        rotZ = 0,
        scaleX = 1.5,
        scaleY = 1.5,
        scaleZ = 1.5,
      },
    Nickname     = "",
    Description  = "",
    GMNotes      = "",
    Tags         = {},
    AltLookAngle = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse = {
        r = 0.0,
        g = 0.0,
        b = 0.0
    },
    LayoutGroupSortIndex = 0,
    Value        = 0,
    Locked       = false,
    Grid         = true,
    Snap         = true,
    IgnoreFoW    = false,
    MeasureMovement = false,
    DragSelectable = true,
    Autoraise    = true,
    Sticky       = true,
    Tooltip      = true,
    GridProjection = false,
    HideWhenFaceDown = true,
    Hands        = false,
    SidewaysCard = false,
    DeckIDs      = {},
    CustomDeck   = {},
    LuaScript    = "",
    LuaScriptState = "",
    XmlUI        = "",
    ContainedObjects = {},
    },
    Board = {
    GUID           = nil,
    Name           = "Custom_Tile",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 6.473,
        scaleY = 1.0,
        scaleZ = 4.577,
      },
    Nickname       = "",
    Description    = "",
    GMNotes        = "",
    Tags           = {},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 1.0,
        g = 1.0,
        b = 1.0
    },
    LayoutGroupSortIndex = 0,
    Value          = 0,
    Locked         = false,
    Grid           = true,
    Snap           = true,
    IgnoreFoW      = false,
    MeasureMovement  = false,
    DragSelectable = true,
    Autoraise      = true,
    Sticky         = true,
    Tooltip        = true,
    GridProjection = false,
    HideWhenFaceDown  = false,
    Hands          = false,
    CustomImage    = {
        ImageURL          = "",
        ImageSecondaryURL = "",
        ImageScalar       = 1.0,
        WidthScale        = 0.0,
        CustomTile        = {
            Type      = 3,
            Thickness = 0.1,
            Stackable = false,
            Stretch   = false
        }
    },
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = "",
    AttachedSnapPoints = {}
    },
    Figure = {
    GUID           = nil,
    Name           = "Figurine_Custom",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 0.8,
        scaleY = 0.8,
        scaleZ = 0.8,
      },
    Nickname       = "",
    Description    = "",
    GMNotes        = "",
    Tags           = {"WitchFigure", "BoardSpace_Square"},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 0.0,
        g = 0.0,
        b = 0.0
    },
    LayoutGroupSortIndex = 0,
    Value          = 0,
    Locked         = false,
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
    CustomImage    = {
        ImageURL          = "",
        ImageSecondaryURL = "",
        ImageScalar       = 1.5,
        WidthScale        = 0.0
    },
    CustomFigurine = {
        UseMinimalCollider = false,
        MirroredBack       = true
    },
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = "",
    AttachedSnapPoints = {}
    },
    Token = {
    GUID           = nil,
    Name           = "Custom_Model",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 0.275,
        scaleY = 0.275,
        scaleZ = 0.275,
      },
    Nickname       = "0",
    Description    = "",
    GMNotes        = "",
    Tags           = {},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 0.0,
        g = 0.0,
        b = 0.0
    },
    LayoutGroupSortIndex = 0,
    Value          = 0,
    Locked         = false,
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
    CustomMesh     = {
        MeshURL       = gitLink("Components/marker_rounded_cube.obj"),
        DiffuseURL    = "",
        NormalURL     = "",
        ColliderURL   = "",
        Convex        = true,
        MaterialIndex = 0,
        TypeIndex     = 0,
        CastShadows   = true
        },
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = ""
    },
    RefCard = {
    GUID           = nil,
    Name           = "Custom_Tile",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 1.70,
        scaleY = 1.0,
        scaleZ = 1.70,
      },
    Nickname       = "",
    Description    = "",
    GMNotes        = "",
    Tags           = {},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 0.2,
        g = 0.2,
        b = 0.2
    },
    LayoutGroupSortIndex = 0,
    Value          = 0,
    Locked         = false,
    Grid           = true,
    Snap           = true,
    IgnoreFoW      = false,
    MeasureMovement  = false,
    DragSelectable = true,
    Autoraise      = true,
    Sticky         = true,
    Tooltip        = true,
    GridProjection = false,
    HideWhenFaceDown  = false,
    Hands          = false,
    CustomImage    = {
        ImageURL          = "",
        ImageSecondaryURL = "",
        ImageScalar       = 1.0,
        WidthScale        = 0.0,
        CustomTile        = {
            Type      = 3,
            Thickness = 0.1,
            Stackable = false,
            Stretch   = true
        }
    },
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = "",
    AttachedSnapPoints = {}
    },
    CustomTile = {
    GUID           = nil,
    Name           = "Custom_Tile",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 1.0,
        scaleY = 1.0,
        scaleZ = 1.0,
      },
    Nickname       = "",
    Description    = "",
    GMNotes        = "",
    Tags           = {},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 1,
        g = 1,
        b = 1
    },
    LayoutGroupSortIndex = 0,
    Value          = 0,
    Locked         = false,
    Grid           = true,
    Snap           = true,
    IgnoreFoW      = false,
    MeasureMovement  = false,
    DragSelectable = true,
    Autoraise      = true,
    Sticky         = true,
    Tooltip        = true,
    GridProjection = false,
    HideWhenFaceDown  = false,
    Hands          = false,
    CustomImage    = {
        ImageURL          = "",
        ImageSecondaryURL = "",
        ImageScalar       = 1.0,
        WidthScale        = 0.0,
        CustomTile        = {
            Type      = 3,
            Thickness = 0.2,
            Stackable = false,
            Stretch   = true
        }
    },
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = "",
    AttachedSnapPoints = {}
    },
    Tray = {
    GUID           = nil,
    Name           = "BlockSquare",
    Transform      = {
        posX   = 0,
        posY   = 0,
        posZ   = 0,
        rotX   = 0,
        rotY   = 0,
        rotZ   = 0,
        scaleX = 1,
        scaleY = 0.01,
        scaleZ = 1,
      },
    Nickname       = "",
    Description    = "",
    GMNotes        = "",
    Tags           = {},
    AltLookAngle   = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse   = {
        r = 1.0,
        g = 1.0,
        b = 1.0,
        a = 0.01
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
    Tooltip        = false,
    GridProjection = false,
    HideWhenFaceDown  = false,
    Hands          = false,
    LuaScript      = "",
    LuaScriptState = "",
    XmlUI          = "",
    ChildObjects   = {
        {
          GUID         = nil,
          Name         = "BlockSquare",
          Transform    = {
            posX = 0.5,
            posY = 50,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 0.01,
            scaleY = 100,
            scaleZ = 1
          },
          Nickname     = "",
          Description  = "",
          GMNotes      = "",
          AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
          },
          ColorDiffuse = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.01
          },
          LayoutGroupSortIndex = 0,
          Value      = 0,
          Locked     = true,
          Grid       = true,
          Snap       = true,
          IgnoreFoW  = false,
          MeasureMovement  = false,
          DragSelectable   = true,
          Autoraise        = true,
          Sticky           = true,
          Tooltip          = false,
          GridProjection   = false,
          HideWhenFaceDown = false,
          Hands          = false,
          LuaScript      = "",
          LuaScriptState = "",
          XmlUI          = "",
          },
        {
          GUID         = nil,
          Name         = "BlockSquare",
          Transform    = {
            posX = 0,
            posY = 50,
            posZ = 0.5,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 1,
            scaleY = 100,
            scaleZ = 0.01
          },
          Nickname     = "",
          Description  = "",
          GMNotes      = "",
          AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
          },
          ColorDiffuse = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.01
          },
          LayoutGroupSortIndex = 0,
          Value      = 0,
          Locked     = true,
          Grid       = true,
          Snap       = true,
          IgnoreFoW  = false,
          MeasureMovement  = false,
          DragSelectable   = true,
          Autoraise        = true,
          Sticky           = true,
          Tooltip          = false,
          GridProjection   = false,
          HideWhenFaceDown = false,
          Hands          = false,
          LuaScript      = "",
          LuaScriptState = "",
          XmlUI          = "",
          },
        {
          GUID         = nil,
          Name         = "BlockSquare",
          Transform    = {
            posX = -0.5,
            posY = 50,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 0.01,
            scaleY = 100,
            scaleZ = 1
          },
          Nickname     = "",
          Description  = "",
          GMNotes      = "",
          AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
          },
          ColorDiffuse = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.01
          },
          LayoutGroupSortIndex = 0,
          Value      = 0,
          Locked     = true,
          Grid       = true,
          Snap       = true,
          IgnoreFoW  = false,
          MeasureMovement  = false,
          DragSelectable   = true,
          Autoraise        = true,
          Sticky           = true,
          Tooltip          = false,
          GridProjection   = false,
          HideWhenFaceDown = false,
          Hands          = false,
          LuaScript      = "",
          LuaScriptState = "",
          XmlUI          = "",
          },
        {
          GUID         = nil,
          Name         = "BlockSquare",
          Transform    = {
            posX = 0,
            posY = 50,
            posZ = -0.5,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 1,
            scaleY = 100,
            scaleZ = 0.01
          },
          Nickname     = "",
          Description  = "",
          GMNotes      = "",
          AltLookAngle = {
            x = 0.0,
            y = 0.0,
            z = 0.0
          },
          ColorDiffuse = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.01
          },
          LayoutGroupSortIndex = 0,
          Value      = 0,
          Locked     = true,
          Grid       = true,
          Snap       = true,
          IgnoreFoW  = false,
          MeasureMovement  = false,
          DragSelectable   = true,
          Autoraise        = true,
          Sticky           = true,
          Tooltip          = false,
          GridProjection   = false,
          HideWhenFaceDown = false,
          Hands          = false,
          LuaScript      = "",
          LuaScriptState = "",
          XmlUI          = "",
          },
    }
    },
    MissionMarker = {
    GUID = nil,
    Name = "CardCustom",
    Transform = {
        posX = 0,
        posY = 0,
        posZ = 0,
        rotX = 0,
        rotY = 0,
        rotZ = 0,
        scaleX = 1.5,
        scaleY = 1.5,
        scaleZ = 1.5,
      },
    Nickname     = "",
    Description  = "",
    GMNotes      = "",
    Tags         = {},
    AltLookAngle = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    ColorDiffuse = {
        r = 0.0,
        g = 0.0,
        b = 0.0,
        a = 0.0
    },
    LayoutGroupSortIndex = 0,
    Value        = 0,
    Locked       = true,
    Grid         = true,
    Snap         = true,
    IgnoreFoW    = true,
    MeasureMovement = false,
    DragSelectable = false,
    Autoraise    = true,
    Sticky       = true,
    Tooltip      = false,
    GridProjection = false,
    HideWhenFaceDown = false,
    Hands        = false,
    SidewaysCard = false,
    CardID       = 100,
    CustomDeck   = {
        ["1"] = {
            FaceURL      = gitLink("/Table/PlayerBoard_Mission_Slot.png"),
            BackURL      = gitLink("/Table/PlayerBoard_Mission_Slot.png"),
            NumWidth     = 1,
            NumHeight    = 1,
            BackIsHidden = true,
            UniqueBack   = false,
            Type         = 0
            }
        },
    LuaScript    = "",
    LuaScriptState = "",
    XmlUI        = "",
    ContainedObjects = {},
    },
}



turnBoard  = nil
arenaBoard = nil
arenaBoardZone = nil
local boardUpdateTimer = nil
local magicShardPlacementIter = 1

local TOLERANCE = 0.1  -- 좌표 비교 시 허용 오차

function onLoad()
    turnBoard      = getObjectFromGUID("dcccc5")
    arenaBoard     = getObjectFromGUID("86fcbb")
    arenaBoardZone = getObjectFromGUID("496000")

    if setUninteractables then
        for _, obj in pairs(getObjects()) do
            if obj.hasTag("UNINTERACTABLE") then
                obj.interactable = false
            end
        end
    end
    
    -- Generate the buttons for modifying player stats (Injury, CP, MP, Magic Shards).
    generateStatGaugeButtons()
    
    -- Generate the buttons for the Deck Reform gizmos.
    createDeckReformButtons()
    
    -- Setup the Magic Shard counters beside each player's board.
    createMagicShardCounters()
    
    -- Register Clad Figure to collision updates to update Arena board when the Clad figure is moved.
    registerCladFigure()
    
    -- Spawns spare cache of cards to ensure they are preloaded for the arena forecast.
    setCardCache()
end

-- EVENT TRIGGERS
function onObjectPickUp(player, obj)
    if obj.hasTag("MarkerToken") then
        obj.setName("")         -- Removes the tooltip name when picked up, (updating itself when put back down).
        obj.held_spin_index = 3 -- Auto-rotate marker cubes 45 degrees.
    end
end

function onObjectCollisionEnter(registered_object, collision_info)
    
    -- Stat gauge marker token.
    if registered_object.hasTag("MarkerToken") then
        updateMarkertoken(registered_object, collision_info)
        
    -- Clad Card forecast scanners.
    elseif registered_object.hasTag("BACL_RangeCalculator") then
        registered_object.call("BACL_CollideEnter", { info = collision_info })
    
    -- Clad moved on Arena Board.
    elseif registered_object.hasTag("BACL_BossFigurine") then 
        if collision_info.collision_object.getGUID() == arenaBoard.getGUID() then
            boardUpdate()
        end
    
    -- Legiom Head moved on Arena Board.
    elseif registered_object.hasTag("BACL_Monster") then 
        if collision_info.collision_object.getGUID() == arenaBoard.getGUID() then
            boardUpdate()
        end
    end
end

function onObjectCollisionExit(registered_object, collision_info)
    -- Clad Card forecast scanners.
    if registered_object.hasTag("BACL_RangeCalculator") then
        registered_object.call("BACL_CollideExit", { info = collision_info })
    end
end


function onObjectSpawn(obj)
  -- Resize cards and decks to match the scale of the default card size within the module!
  if obj.type == 'Deck' then
    obj.setScale({
      x = 1.50,
      y = 1.00,
      z = 1.50
    })
  end
  
  -- Ensure all created Hydra Heads have collision detection to update the Arena board.
  if obj.hasTag("BACL_Monster") then
    obj.registerCollisions()
  end
  
  -- If the Clad changed state, re-register it.
  if obj.hasTag("BACL_BossFigurine") then
    registerCladFigure()
  end
  
end

function onObjectEnterZone(zone, object)
    --[=[ While Zones are not assigned any values, the Global script will assign it a variable named
    -- disabledZoneUpdates to ensure the zone will only update once at the end of a frame.
    -- This massively cuts down on lag when updated multiple times in the same frame.
    -- Notably, this variable is set per-zone, so zones do not conflict with the updates of other zones. ]=]
    if zone.getVar("disabledZoneUpdates") == nil then
        -- Magic Shards moving into Player Board zones.
        -- Used for Magic Shard Counter gizmos.
        if object.hasTag("MagicShard") then
            for _, player in pairs(playerData) do
                if player.boardZoneGUID == zone.getGUID() then
                    zone.setVar("disabledZoneUpdates", true)
                    Wait.frames(function()
                        zone.setVar("disabledZoneUpdates", nil)
                        updateMagicShardCounter(zone)
                        end, 1)
                    return
                end
            end
        end
    end
end

function onObjectLeaveZone(zone, object)
    --[=[ While Zones are not assigned any values, the Global script will assign it a variable named
    -- disabledZoneUpdates to ensure the zone will only update once at the end of a frame.
    -- This massively cuts down on lag when updated multiple times in the same frame.
    -- Notably, this variable is set per-zone, so zones do not conflict with the updates of other zones. ]=]
    if zone.getVar("disabledZoneUpdates") == nil then
    
        -- Magic Shards moving into Player Board zones.
        -- Used for Magic Shard Counter gizmos.
        if object.hasTag("MagicShard") then
            for _, player in pairs(playerData) do
                if player.boardZoneGUID == zone.getGUID() then
                    zone.setVar("disabledZoneUpdates", true)
                    Wait.frames(function()
                        zone.setVar("disabledZoneUpdates", nil)
                        updateMagicShardCounter(zone)
                        end, 1)
                    return
                end
            end
        
        -- Legion Heads moving out of the Arena Board zone.
        -- Used for updating the Arena Board forecast.
        elseif object.hasTag("BACL_Monster") then 
            if zone == arenaBoardZone then
                zone.setVar("disabledZoneUpdates", true)
                Wait.frames(function()
                    zone.setVar("disabledZoneUpdates", nil)
                    boardUpdate()
                    end, 1)
                return
            end
        
        -- Clad figure moving out of the Arena Board zone.
        -- Used for updating the Arena Board forecast.
        elseif object.hasTag("BACL_BossFigurine") then 
            if zone == arenaBoardZone then
                zone.setVar("disabledZoneUpdates", true)
                Wait.frames(function()
                    zone.setVar("disabledZoneUpdates", nil)
                    boardUpdate()
                    end, 1)
                return
            end
        
        end
    end
end


-- CHARACTER SELECT FUNCTIONS
-- Functions to be executed when the 'Select character' button is clicked
-- + Removes objects around the spawn location of the specified player color,
-- + Takes objects out of the pocket at 0.1 second intervals and spawns them, and replaces the pocket after all objects are spawned.
function charSelect_Button(obj)
  obj.createButton({
      label = "Select",
      tooltip = "Select your character",
      click_function = "setDeck",
      function_owner = obj,
      position = {0, 0, 2.3},
      rotation = {0, 0, 0},
      width = 1150,
      height = 350,
      font_size = 200
  })
end

function characterSelect(args)
  -- unpack arguments
  player = args.player
  character = args.character:lower()

  -- If Spectator or Game Master, spawn nothing!
  if player == 'Black' or player == 'Grey' then return end
  
  printDebug(player)
  printDebug(character)
  
  -- MODIFIED FUNCTION:
  -- Destroys a spawned CloneBag to avoid memory leakage.
  local function removeBagAndSpawnNewBag(cloneBag_GUID)
    local cloneBag = getObjectFromGUID(cloneBag_GUID)
    if cloneBag then
        destroyObject(cloneBag)

    else

    end
  end

  character = character:lower()
  
  -- Do not destroy objects with these GUIDs
  local excludedGUIDs = { 
    ["0fdf35"] = true,
    ["fb7098"] = true,
    ["7bbac1"] = true,
    ["0ab715"] = true,
    ["fd1e45"] = true,
    ["dd0576"] = true,
    ["8ec310"] = true,
    ["7776b8"] = true,
    ["abd8c8"] = true,
    ["7f8b65"] = true,
    ["a5a5d2"] = true,
    ["2a45f9"] = true,
    ["05e3ae"] = true,
    ["948ad5"] = true,
    ["659038"] = true,
    ["d9f1bd"] = true,
    ["a367e8"] = true,
    ["117a80"] = true,
    ["c678b3"] = true,
    ["6f8c23"] = true,
    ["7a4f0c"] = true,
    ["21e079"] = true,
    ["bee2d0"] = true,
    ["b00f54"] = true,
    ["cf4ca2"] = true,
    ["7244ab"] = true,
    ["9e915b"] = true,
    ["020e29"] = true,

    ["67bf01"] = true,
    ["98db60"] = true,
    ["0a9010"] = true,
    ["879787"] = true,
    ["b40bea"] = true,

    ["81bf59"] = true,
    ["68ce7b"] = true,
    ["3b7383"] = true,
    ["d4a034"] = true,
    ["83be95"] = true,

    ["e1c25e"] = true,
    ["edf090"] = true,
    ["1d1842"] = true,
    ["82f812"] = true,
    ["aa1a59"] = true,

    ["514f9a"] = true,
    ["a58dce"] = true,
    ["7d4500"] = true,
    ["a68498"] = true,
    ["07cd08"] = true,

    ["b81d83"] = true,
    ["2e5bb1"] = true,
    ["7bd861"] = true,

    ["7aa50e"] = true,
    ["0ca5eb"] = true,
}
  -- Character components are stored in their hidden bags
  local bagGUIDs = {
    rosette       = '2a0302',
    flare         = 'ace410',
    mia           = '780452',
    luna          = '1aa75d',
    amelia        = '8af1a3',
    
    croy          = '79cd83',
    lov           = '5182a6',
    
    rosette_delta = '122fbe',
    flare_delta   = 'be18ed',
    mia_delta     = '04eb65',
    luna_delta    = '344b75',
    amelia_delta  = 'd8c8ab'
  }
  local spawnPos = playerPositions[player] -- Find player board.
  local spawnedObjects = {} -- Table to store the GUIDs of the created objects
  
  local objectOffsets = {
    {x =  0,     y = 0, z =  0.0 }, -- Player board
    {x = -1.55,  y = 1, z =  0.9 }, -- Injuries marker
    {x = -1.55,  y = 1, z = -0.15}, -- MP marker
    {x = -1.55,  y = 1, z = -1.15}, -- CP marker
    {x =  3.7,   y = 1, z = -2.0 }, -- Standard deck
    {x =  4.1,   y = 1, z =  2.6 }, -- Enhanced deck
    {x = -0.35,  y = 1, z =  2.9 }  -- Witch figure
    }
  
  if character == "rosette_delta"
  or character == "mia_delta"
  or character == "flare_delta"
  or character == "amelia_delta"
  or character == "luna_delta" then
    objectOffsets = {
    {x =  0,     y = 0, z = -0.0},
    {x = -1.58,  y = 1, z =  3.8},
    {x = -1.55,  y = 1, z =  2.65},
    {x = -1.55,  y = 1, z =  1.55},
    {x =  3.7,   y = 1, z = -1.85},
    {x =  8.23,  y = 1, z =  2.73},
    {x =  3.75,  y = 1, z =  2.6}
    }
  end
  
  -- Add additional offsets for character-specific components.
  local characterSpecificOffsets = nil
  if character == "lov" then
    characterSpecificOffsets = {
      {x = -0.13, y = 1, z = -2.9},   -- Unlock Tile
    }
  elseif character == "croy" then
    characterSpecificOffsets = {
      {x = -1.14,  y = 1, z = -3.12}, -- Gate Limit Token
      {x =  0.51,  y = 1, z = -3.12}, -- Gate Limit Token
      {x = -7.4,   y = 1, z = -6.3 }, -- Gate Token
      {x = -8.5,   y = 1, z = -6.3 }, -- Gate Token
      {x = -7.4,   y = 1, z = -5.2 }, -- Gate Token
      {x = -8.5,   y = 1, z = -5.2 }, -- Gate Token
      {x =  2.3,   y = 1, z = -6.7 }, -- Reference Card
    }
  elseif character == "mia_delta" then
    characterSpecificOffsets = {
      {x = -3,     y = 1, z =  5.8}, -- Conibear Trap Token
      {x = -5.2,   y = 1, z =  5.8}, -- Conibear Trap Token
      {x =  2.5,   y = 1, z = -6.7}, -- Conibear Trap Reference
    }
  elseif character == "amelia_delta" then
    characterSpecificOffsets = {
      {x = -1,     y = 1, z =  5.6},  -- Tsuchikumo Token
      {x = -2.5,   y = 1, z =  5.6},  -- Tsuchikumo Token
      {x = -4,     y = 1, z =  5.6},  -- Tsuchikumo Token
      {x = -5.5,   y = 1, z =  7.0},  -- Tsuchikumo Token
      {x = -1,     y = 1, z =  7.0},  -- Tsuchikumo Token
      {x = -2.5,   y = 1, z =  7.0},  -- Tsuchikumo Token
      {x = -4,     y = 1, z =  7.0},  -- Tsuchikumo Token
      {x = -5.5,   y = 1, z =  5.6},  -- Tsuchikumo Token
      {x =  2.5,   y = 1, z = -6.7}   -- Tsuchikumo Reference Card
    }
  end
  if characterSpecificOffsets ~= nil then
    for _, offset in ipairs(characterSpecificOffsets) do
      table.insert (objectOffsets, offset)
    end
  end
  
  -- Remove objects around spawnPos (within 13 units radius).
  local allObjects = getAllObjects()
  for _, obj in ipairs(allObjects) do
      local pos = obj.getPosition()
      local distance = math.sqrt((pos.x - spawnPos.x)^2 + (pos.y - spawnPos.y)^2 + (pos.z - spawnPos.z)^2)
      local guid = obj.getGUID()
      if distance < 13 and guid ~= bagGUID and not excludedGUIDs[guid] then
          destroyObject(obj)
      end
  end

  -- Create duplicate bag to move items into the player's area.
  local bag = getObjectFromGUID(bagGUIDs[character])
  local clonedBag = bag.clone()
  local clonedBag_GUID = clonedBag.getGUID()
  if clonedBag then
    local totalObjects = #objectOffsets

    local function spawnNext(index)
        if index > totalObjects then
            removeBagAndSpawnNewBag(clonedBag_GUID)
            return
        end

        local offset = objectOffsets[index]
        local newPos = {
            x = spawnPos.x + offset.x,
            y = spawnPos.y + offset.y,
            z = spawnPos.z + offset.z
        }

        local desiredRotation
        if index >= 2 and index <= 4 then
            desiredRotation = {0, 135, 0}
        elseif index == 5 then
            desiredRotation = {180, 0, 0}
        elseif index == 6 then
            desiredRotation = {180, 270, 0}  -- Set to flipped state
        else
            desiredRotation = {0, 180, 0}
        end
        
        if character == "mia_delta" and index >= 8 and index <= 9 then 
          desiredRotation = {180, 180, 0}  -- Conibear traps start face-down.
        end

        clonedBag.takeObject({
                            position = newPos,
                            rotation = desiredRotation,
                            smooth = false,  -- Move instantly for teleportation effect
                            callback_function = function(obj)
                                if index == 1 then
                                    obj.lock()
                                end
                                table.insert(spawnedObjects, obj.getGUID())
                                -- Spawn the next object immediately without delay
                                spawnNext(index + 1)
                            end
                        })
    end

    spawnNext(1)
  end
end



-- STAT GAUGE FUNCTIONS
-- Functions to handle the Injury, MP, and CP gauges of a player's board.
-- The statGauge tiles call Global to define their buttons universally. ///
-- [→onLoad()]: Generates the clickable buttons to modify stats, set using tags.
function generateStatGaugeButtons()
    -- Look through all objects for objects with both a "StatGaugeButton_" and "PlayerAssigned_" tag.
    -- The tags define both which player it is used to modify stats for, and what stat is being modified.
    for _, obj in ipairs(getObjects()) do
        local statType     = nil
        local targetPlayer = nil
        
        for _, tag in ipairs(obj.getTags()) do
            if string.find(tag, "StatGaugeButton_") then
                statType =  string.sub(tag, 17) end
            if string.find(tag, "PlayerAssigned_") then
                targetPlayer =  string.sub(tag, 16) end
        end
        
        if statType and targetPlayer then
            createStatGaugeButton(obj, targetPlayer, statType) 
        end
        
    end
end

function createStatGaugeButton(obj, targetPlayer, statType)
    local tooltipString = "Error."
    if statType == "Shards" then
        tooltipString = "Left Click: Magic Shards +1 • Right Click: Magic Shards -1"
    elseif statType == "Injury" then
        tooltipString = "Left Click: Injuries +1 • Right Click: Injuries -1"
    elseif statType == "MP" then
        tooltipString = "Left Click: MP +1 • Right Click: MP -1"
    elseif statType == "CP" then
        tooltipString = "Left Click: CP +1 • Right Click: CP -1"
    end

    obj.createButton({
        label = "",
        click_function = "onClick_statGauge_" .. obj.getGUID(),
        function_owner = self,
        position = {0, 0.1, 0},
        rotation = {0, 0, 0},
        width = 990,
        height = 990,
        font_size = 250,
        color = {1, 1, 1, 0},
        tooltip = tooltipString
    })
    
    -- Wrapper function to allow buttons to pass arguments
    local btnFunction = function(obj, player, alt_click)
        if statType == "Shards" then
            modifyMagicShards(player, targetPlayer, alt_click)
        else
            modifyStatGauge(player, targetPlayer, statType, alt_click)
        end
    end
    
    _G["onClick_statGauge_" .. obj.getGUID()] = btnFunction
end

function modifyStatGauge(selectionPlayer, player, statType, alt_click)
    local selfTargetting = (selectionPlayer == player)
    local markerToken = nil
    local playerBoard = nil
    for _, obj in ipairs(getObjects()) do
        if obj.hasTag("Marker_" .. statType) and obj.hasTag("PlayerOwned_" .. player) then
            markerToken = obj
        end
        
        if obj.hasTag("PlayerComponent_CharacterBoard") and obj.hasTag("PlayerOwned_" .. player) then
            playerBoard = obj
        end
    end
    
    if playerBoard == nil then
        if selfTargetting
        then lovSays(selectionPlayer, "You don't have a board available.")
        else lovSays(selectionPlayer, "The " .. player .. " player does not have a board available.") end
        return
    elseif markerToken == nil then
        lovSays(selectionPlayer, "The stat marker appears to be gone!")
        return
    end
    
    local gaugeValue = nearestSnapPointValue(markerToken, playerBoard, statType)
    if gaugeValue == nil then
        lovSays(selectionPlayer, "Please return the stat marker to the stat gauge first.")
        return
    end
    
    if alt_click == false then
        targetGaugeValue = gaugeValue + 1
    else
        targetGaugeValue = gaugeValue - 1
    end
    
    local newSnapPoint = nil
    
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "Marker_"..statType) and
        snapPointHasTag(snapPoint, "~"..targetGaugeValue) then
            newSnapPoint = snapPoint
        end
    end
    
    local markerPosition = markerToken.getPosition()
    if newSnapPoint ~= nil then
        targetPosition = playerBoard.positionToWorld(Vector(newSnapPoint.position))
        markerToken.setPositionSmooth({
            x = targetPosition.x,
            y = markerPosition.y, -- Don't change the vertical position when moving token.
            z = targetPosition.z   
        }, false, true)
        
        markerToken.setName(targetGaugeValue)
        
        statMessage = alt_click and "-1 " .. statType or "+1 " .. statType
        if selfTargetting
        then broadcastToAll(statMessage, messageColors[selectionPlayer])
        else broadcastToAll(selectionPlayer .. " player has modified the " .. player .. " board: " .. statMessage, messageColors[selectionPlayer]) end
        
    else
        if alt_click == false then
            broadcastToColor("The " .. statType .. " gauge cannot go higher", selectionPlayer, messageColors.Error)
        else
            broadcastToColor("The " .. statType .. " gauge cannot go lower", selectionPlayer, messageColors.Error)
        end
    end
end

function getClosestSnapPoint(snapPointTable, localPosition, maximumDistance)
  -- table snapPointTable: must be structured as Object.getSnapPoints()
  -- Vector localPosition: position to find the closest snap point to. Must be local to the object owning the snap points
  -- [optional] number maximumDistance: The maximum distance to allow a snap point to be returned
  local closestSnapPointDistance = maximumDistance or math.huge
  local closestSnapPoint = nil
  for _,snapPoint in ipairs(snapPointTable) do
    local snapPointPositionVector = Vector(snapPoint.position) -- positions are not Vector class by default, this makes it so
    local distanceToSnapPoint = Vector.distance(snapPointPositionVector, localPosition)
    if distanceToSnapPoint < closestSnapPointDistance then
      closestSnapPoint = snapPoint
      closestSnapPointDistance = distanceToSnapPoint
    end
  end
  return closestSnapPoint
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

function nearestSnapPointValue(markerToken, playerBoard, statType)
    local markerPosition = markerToken.getPosition()
    local markerRelativePosition = playerBoard.positionToLocal(markerPosition)
    local nearestSnapPoint = getClosestSnapPoint(playerBoard.getSnapPoints(), markerRelativePosition, 0.10)
    local gaugeValue = 0
    local targetGaugeValue = 0
    
    if snapPointHasTag(nearestSnapPoint, "Marker_" .. statType) then
        for i = 0,15,1 do
            if snapPointHasTag(nearestSnapPoint, "~" .. i) then
                gaugeValue = i
                return gaugeValue
            end
        end
    else
        return nil
    end
end
 
-- [→onObjectCollisionEnter()]: Allows the marker tokens to self-update their labelled value automatically.
function updateMarkertoken(markerToken, collision_info)
    local statType = nil
    local playerOwner = nil
    
    -- Find the appropriate stat and player.
    printDebug("\nCollision with Marker Token detected!")
    for _, tag in ipairs(markerToken.getTags()) do
        if string.find(tag, "Marker_") then
            statType = string.sub(tag, 8)
        elseif string.find(tag, "PlayerOwned_") then
            playerOwner = string.sub(tag, 13)
        end
    end
    
    printDebug("statType: " .. statType .. "\nplayerOwner: " .. playerOwner)
    
    -- Check if collided with a valid player board
    local playerBoard = collision_info.collision_object
    printDebug("Collision with object " .. collision_info.collision_object.getGUID())
    if playerBoard.hasTag("PlayerComponent_CharacterBoard") and
    playerBoard.hasTag("PlayerOwned_" .. playerOwner) then
        local gaugeValue = nearestSnapPointValue(markerToken, playerBoard, statType)
        if gaugeValue ~= nil then
            markerToken.setName(tostring(gaugeValue))
            return true
        else
            printDebug("Valid board, invalid snap point proximity")
            markerToken.setName("") -- We can assume it is no longer in the correct position for a value.
            return false
        end
    else
        printDebug("Object is not a valid board, ignoring.") -- We ignore other collisions to avoid removing existing data.
        return false
    end
end



-- MAGIC SHARD BUTTON Functions
-- Functions to handle the Magic Shard (VP) buttons near each player's board.
-- the Magic Shard Button tiles are defined in createStatGaugeButton() as they
-- share similar properties, but will use the modifyMagicShards() function.
function modifyMagicShards(player, targetPlayer, alt_click)
    -- Find the player's character board.
    local playerBoard       = nil
    for _, obj in ipairs(getObjectsWithTag("PlayerComponent_CharacterBoard")) do
        if obj.hasTag("PlayerOwned_" .. targetPlayer) then
            playerBoard = obj
        end
    end
    if playerBoard == nil then lovSays(player, "You don't have a board available." ) return end
    
    if alt_click == false then
        local result = addMagicShard(playerBoard, targetPlayer, player)
        if result then broadcastToAll("Magic Shards +1", messageColors[player]) end
    else
        local result = removeMagicShard(playerBoard, targetPlayer, player)
        if result then broadcastToAll("Magic Shards +1", messageColors[player]) end
    end
    
end

function addMagicShard(playerBoard, player, selectionPlayer)
    local magicShardCount = countMagicShard(player)
    local spawnPosition = findShardTrayPosition(playerBoard)

    if magicShardCount[0] >= 14 then
        printDebug("9 Magic Shards already in tray, merging...")
        
        local combinedPosition = {x=0, y=0, z=0}
        for i = 0,4,1 do
            local shardObj = selectMagicShard(player, 0) -- Select x1 Magic Shards
            local shardObjPosition = shardObj.getPosition()
            combinedPosition = {
                x = combinedPosition.x + shardObjPosition.x,
                y = combinedPosition.y + shardObjPosition.y,
                z = combinedPosition.z + shardObjPosition.z,
            }
            shardObj.destruct()
        end
        
        printDebug("Spawning 5 Shard at " .. combinedPosition.x .. ", " .. combinedPosition.y .. ", " .. combinedPosition.z)

        spawnObjectData({
            data = templateObjects.MagicShard_5,
            position = {
                x = combinedPosition.x / 5,
                y = (combinedPosition.y / 5) + 0.5,
                z = combinedPosition.z / 5,
            },
            rotation = {
                x=math.random(360),
                y=math.random(360),
                z=math.random(360)
                }
            })
        
    end

    spawnObjectData({
        data = templateObjects.MagicShard_1,
        position = {
            x = spawnPosition.x - 0.9 + (1.8 * math.random()),
            y = spawnPosition.y + 4.0 + (1.0 * math.random()),
            z = spawnPosition.z - 0.9 + (1.8 * math.random())
        },
        rotation = {
            x=math.random(360),
            y=math.random(360),
            z=math.random(360)
            }
        })
        
    if player == selectionPlayer -- Self-targetting
        then broadcastToAll("+1 Magic Shard", messageColors[selectionPlayer])
        else broadcastToAll(selectionPlayer .. " player has modified the " .. player .. " board: +1 Magic Shard", messageColors[selectionPlayer]) end
end

function removeMagicShard(playerBoard, player, selectionPlayer)
    local magicShardObj = nil                         -- Select a Magic Shard from the player's board.
    local magicShardCount = countMagicShard(player)
    
    -- check Witch is actually on the board and find their grid location
    local playerWitchFigure = findPlayerWitch(player)
    local witchGridPosition = nil
    if playerWitchFigure == nil then
        lovSays(selectionPlayer, "The " .. player .. " player does not appear to have a Witch to drop Magic Shards.")
        return
    else 
        local witchLocalPosition  = arenaBoard.positionToLocal(playerWitchFigure.getPosition())
        
        printDebug("Witch Grid Position: " .. witchLocalPosition.x .. ", " .. witchLocalPosition.z)
        
        if math.abs(witchLocalPosition.x) <= 9 and math.abs(witchLocalPosition.z) <= 9 then
            witchGridPosition = turnBoard.call("getBossPositionInGrid", playerWitchFigure)
        else
            lovSays(player, "Please ensure your Witch is on the board before you remove Magic Shards.")
            return
        end
    end
    
    -- If there are not many VP×1 Shards, then check if there is any VP×5 Shards to split before continuing.
    if magicShardCount[0] <= 5 and
       magicShardCount[1] >= 1 then
       
        local bigMagicShardObj = selectMagicShard(player, 1) -- Select x5 Magic Shards
        
        if bigMagicShardObj == nil then printDebug("Cannot find a valid Magic Shard.") return end
            
        local spawnOffsets = {
                {x = 0,   y = 1,   z = 0.2},
                {x = 0,   y = 1,   z =-0.2},
                {x = 0.2, y = 1,   z = 0},
                {x =-0.2, y = 1,   z = 0},
                {x = 0,   y = 1.2, z = 0}
            }
        
        for _, offset in ipairs(spawnOffsets) do
            spawnObjectData({
                data = templateObjects.MagicShard_1,
                position = bigMagicShardObj.getPosition() + offset,
                rotation = {
                    x=math.random(360),
                    y=math.random(360),
                    z=math.random(360)
                    }
                })
        end
        
        bigMagicShardObj.destruct()
        magicShardCount = countMagicShard(player)
    end
    
    -- If there is at least one valid shard, select one randomly. 
    magicShardObj = selectMagicShard(player, 0) -- Select x1 Magic Shards
    if magicShardObj == nil
    then broadcastToColor("There are no Magic Shards to remove.", player, messageColors.Error) return end
    
    printDebug("Witch Grid Position: " .. witchGridPosition.x .. ", " .. witchGridPosition.y)
    
    -- Find the grid tile to spawn onto.
    local FIELD_GRID_DISTANCE = turnBoard.getVar("FIELD_GRID_DISTANCE")
    local boardPosition = arenaBoard.getPosition()
    local spawnArea = {
        x = boardPosition.x + (witchGridPosition.x - 3) * FIELD_GRID_DISTANCE,
        y = boardPosition.y,
        z = boardPosition.z + (2.99 - witchGridPosition.y) * FIELD_GRID_DISTANCE
    }
    
    local magicShardPlacementTable = {
        {x = 0.35, z = -0.35},
        {x =-0.35, z = -0.35},
        {x = 0.35, z =  0.35},
        {x =-0.35, z =  0.35},
    }
    
    magicShardObj.setPositionSmooth({
        x = spawnArea.x + magicShardPlacementTable[magicShardPlacementIter]["x"] * FIELD_GRID_DISTANCE,
        y = spawnArea.y + 2,
        z = spawnArea.z + magicShardPlacementTable[magicShardPlacementIter]["z"] * FIELD_GRID_DISTANCE
    }, false, false)
    
    magicShardPlacementIter = magicShardPlacementIter + 1
    
    if magicShardPlacementIter == 5 then magicShardPlacementIter = 1 end
    
    if player == selectionPlayer
        then broadcastToAll("Dropped 1 Magic Shard", messageColors[selectionPlayer])
        else broadcastToAll(selectionPlayer .. " player has modified the " .. player .. " board: Dropped 1 Magic Shard", messageColors[selectionPlayer]) end
end
-- Selects and returns a random Magic Shard object from the specified player's board with the given VP value (x1 or x5)
function selectMagicShard(player, targetValue)
    local playerZone = getObjectFromGUID(playerData[player].boardZoneGUID)
    if playerZone == nil then
        printDebug("selectMagicShard: Cannot find PlayerBoard") 
        return nil end
        
    for _, obj in ipairs(getObjects()) do -- Check all objects

        if isZoneBound(playerZone, obj) and -- within the zone region; checking by bounds because it has to be able to detect shards that have been spawned during this frame, which may not have been detected by the zone yet.
           (not obj.held_by_color)      and -- Ignore any Magic Shard currently being held.
           obj.hasTag("MagicShard")     and -- Must be a Magic Shard
           obj.getGMNotes()             and
           not obj.isDestroyed()       then -- Must have GM Notes to be valid
            
            stats = JSON.decode(obj.getGMNotes())
            if stats.Type == targetValue then
                return obj
            end
        end
    end
    
    return nil
end
-- Returns the total number of Magic Shards of one type on a player's board.
function countMagicShard(player)
    local playerZone = getObjectFromGUID(playerData[player].boardZoneGUID)
    local finalCount = {
        [0] = 0, -- Magic Shard
        [1] = 0, -- Magic Shard x5
        [2] = 0  -- Corruption
        }
        
    if playerZone == nil then
        printDebug("countMagicShard: Cannot find PlayerBoard") 
        return nil end
    
    for _, obj in ipairs(getObjects()) do -- Check all objects in their zone
        if isZoneBound(playerZone, obj) and
        (not obj.held_by_color)         and -- Ignore any Magic Shard currently being held.
        obj.hasTag("MagicShard")        and -- Must be a Magic Shard
        obj.getGMNotes()                and
        not obj.isDestroyed()          then -- Must have GM Notes to be valid
            stats = JSON.decode(obj.getGMNotes())
            printDebug(finalCount[stats.VP])
            -- Increment the specific key value of the shard detected.
            -- If it's not been detected before the value is nil so set to 0.
            if finalCount[stats.Type] ~= nil then
                finalCount[stats.Type] = finalCount[stats.Type] + 1
            end
        end
    end
    
    printDebug("Final count of Magic Shards... VP×1: " .. (finalCount[0] or 0) .. ", VP×5: " .. (finalCount[1] or 0) .. ", Corruption: " .. (finalCount[2] or 0)) 
    
    return finalCount
    -- EXAMPLE OUTPUT:
    -- {[1] = 7, [5] = 2}
end

function findPlayerWitch(player)
    for _, obj in ipairs(getObjects()) do
        if obj.hasTag("PlayerOwned_" .. player) and
           obj.hasTag("WitchFigure") then
            return obj
        end
    end
    
    return nil
end

function findShardTrayPosition(playerBoard)
    local trayLocalPosition = nil
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "VPTray") then
            -- the native position value for snappoints are not a valid vector format, so convert it.
            trayLocalPosition = Vector(snapPoint.position)
        end
    end
    
    if trayLocalPosition == nil then
        printDebug("findShardTrayPosition: No valid snappoint was found.")
        return nil 
    end

    -- Compute the world position, as snappoints are always in local positon.
    return playerBoard.positionToWorld(trayLocalPosition)
end

function isZoneBound(zone, obj)
    local zonePosition   = zone.getPosition()
    local zoneScale      = zone.getScale()
    local objectPosition = obj.getPosition()
    
    if math.abs(objectPosition.x - zonePosition.x) <= zoneScale.x  and
       math.abs(objectPosition.y - zonePosition.y) <= zoneScale.y  and
       math.abs(objectPosition.z - zonePosition.z) <= zoneScale.z then
        return true
    else
        return false
    end
end



-- MAGIC SHARD COUNTER GIZMO Functions
-- [→onLoad()]: Setup and create the magic shard counters.
function createMagicShardCounters()
    for _, obj in pairs(getObjectsWithTag("Tool_ShardCounter")) do
        local assignedPlayer = nil
        for _, tag in ipairs(obj.getTags()) do
            if string.find(tag, "PlayerAssigned_") then
                assignedPlayer =  string.sub(tag, 16)
            end
        end
        
        if assignedPlayer then
            obj.createButton({
                click_function = "none",
                function_owner = self,
                label          = "0",
                position       = {0.0, 0.1, -0.05},
                rotation       = {0, 0, 0},
                width          = 0,
                height         = 0,
                font_size      = 400,
                font_color     = {1, 1, 1},
            })
            
            -- Since this function is normally used to update based on zone updates, we need to give it the specific zone
            -- rather than the object itself.
            updateMagicShardCounter(getObjectFromGUID(playerData[assignedPlayer].boardZoneGUID))
        end
    end
end
-- [→onObjectEnterZone()]: Updates the respective counter for a zone
function updateMagicShardCounter(zone)
    local total = 0
    local zoneGUID = zone.getGUID()
    local counterObj = nil
    
    -- Find the relevant player of the given zone, then find which counter needs updating.
    for player, playerState in pairs(playerData) do
        if zoneGUID == playerState.boardZoneGUID then
            printDebug("Activated zone belongs to " .. player)
            -- Find the assigned magic shard counter (ironically it's not actually in the zone itself)
            for _, obj in pairs(getObjectsWithAllTags({"Tool_ShardCounter", tostring("PlayerAssigned_" .. player)})) do
                counterObj = obj
                break
            end
        end
    end
    if counterObj == nil then printDebug("Could not find Magic Shard Counter object.") return end
    
    -- The zone itself has the MagicShard tag, this means we do not need to filter
    -- for the MagicShard objects.
    for _,object in ipairs(zone.getObjects()) do
        if object.getGMNotes() ~= "" then
            stats = JSON.decode(object.getGMNotes())
            if stats.VP ~= nil then
                total = total + stats.VP
            end
        end
    end
    
    counterObj.editButton({index=0,label=total})
end



-- DECK REFORM GIZMO Functions
-- [→onLoad()]: Generates the clickable buttons on the gizmo.
function createDeckReformButtons()
    for _, obj in ipairs(getObjects()) do
        local targetPlayer = nil
        if obj.hasTag("ReformDeckButton") then
            for _, tag in ipairs(obj.getTags()) do
                if string.find(tag, "PlayerAssigned_") then
                    targetPlayer =  string.sub(tag, 16)
                end
            end
            
            if targetPlayer then
                obj.createButton({
                    label = "",
                    click_function = "onClick_startDeckReform_" .. targetPlayer,
                    function_owner = self,
                    position = {0, 0.3, 0},
                    rotation = {0, 0, 0},
                    width = 900,
                    height = 900,
                    font_size = 1,
                    color = {1, 1, 1, 0},
                    tooltip = "Reform the deck"
                })
                -- Wrapper function to allow buttons to pass arguments
                local disabledButton = false
                local btnFunction = function(obj, player, alt_click)
                    if disabledButton == false then
                        disabledButton = true
                        Wait.time(
                            function()
                                disabledButton = false
                                return
                            end,
                            0.5, -- 100 milliseconds
                            1    -- run the function 1 time
                            )
                        startDeckReform(obj, player, targetPlayer, alt_click)
                    end
                    
                end
                
                _G["onClick_startDeckReform_" .. targetPlayer] = btnFunction
                
            end
        end
    end
    
end

function startDeckReform(buttonObj, player, targetPlayer, alt_click)
    -- Do nothing if player is busy reforming already.
    if playerData[player].reconstructMode then return false end

    -- Prevent other players from clicking the Deck Reform button unless it's on their own board.
    if player ~= targetPlayer then
        lovSays(player, "You cannot reform or modify another player's deck.")
        return false
    end
    
    local playerPosition = playerPositions[player]
    if not playerPosition then return end
    
    -- Find the player's character board.
    printDebug("Finding player board.")
    local playerBoard = nil
    for _, obj in ipairs(getObjectsWithTag("PlayerComponent_CharacterBoard")) do
        if obj.hasTag("PlayerOwned_" .. player) then
            printDebug("Player board " .. obj.getGUID())
            playerBoard = obj
        end
    end
    -- If Player has no board set up, cancel the reform.
    if playerBoard == nil then
        lovSays(player, "Please select and set up a character first before reforming your deck.")
        return false
    end
    
    printDebug("Locating snap points.")
    local discardSnapPoint = nil
    local enDeckSnapPoint = nil
    local stDeckSnapPoint = nil
    local reformSnapPoint = nil
    local playerBoardRotation = playerBoard.getRotation()
    
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "Discard") then
            discardSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "EnhancedDeck") then
            enDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "StandardDeck") then
            stDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "~Reform") then
            reformSnapPoint = snapPoint
        end
    end
    
    -- Start Reform and look through Enhanced Deck
    printDebug("Not already in Reconstruct Mode")
    playerData[player].reconstructMode = true
    
    -- Move player's hand into an aside reform pile to seperate it from the
    -- player hands.
    local originalHand = cardsToDeck(player,
        getCardsInHand(player, 1),
        reformSnapPoint,
        {x=0, y=90, z=180},
        {x=0, y=-0.45, z=0} -- Lowered down to match table height.
        )
    if originalHand ~= nil then
        originalHand.setLock(true) -- Make it unable to be touched to avoid tampering.
    end

    deckToHand(player, 1, discardSnapPoint) -- Move discard pile into the player's primary hand
    deckToHand(player, 2, enDeckSnapPoint)  -- Move the enhanced deck into the player's secondary hand

    chooseInHandOrCancel(
        "reconstructMode_discard", -- selectID
        1, -- Required to select a card.
        1, -- Cannot select 2 cards at once.
        "Select [b]1 card[/b] to remove from your [b][F05050]discard pile[-][/b].",
        {player})
    return
end
-- [→onPlayerHandChoice()]: Responds to first card being selected.
function continueDeckReform(player, selectedCards)
    cardObj = selectedCards[1]

    swapHands(player)

    -- Override the movement of the card to combine it with the Enhanced Deck.
    cardObj.deal(1, player, 1)
    
    -- Now request an Enhanced Card to add.
    Wait.time(
      function()
        chooseInHandOrCancel(
        "reconstructMode_enhanced", -- selectID
        1, -- Required to select a card.
        1, -- Cannot select 2 cards at once.
        "Select [b]1[/b] card to add from your [b][50F0F0]Enhanced Deck[/b].",
        {player})
        return
      end,
      0.001, -- 500 milliseconds
      1    -- run the function 1 time
    )
end
        
function endDeckReform(player, selectedCards)
    local cardObj     = selectedCards[1]
    local removedCard = playerData[player].lastRemovedCard.getName()
    local addedCard   = cardObj.getName()
    
    local playerPosition = playerData[player].position
    if not playerPosition then return end
    
    -- Find the player's character board.
    printDebug("Finding player board.")
    local playerBoard = getPlayerBoard(player)
    
    printDebug("Locating snap points.")
    local discardSnapPoint = nil
    local enDeckSnapPoint = nil
    local stDeckSnapPoint = nil
    local reformSnapPoint = nil
    local playerBoardRotation = playerBoard.getRotation()
    
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "Discard") then
            discardSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "EnhancedDeck") then
            enDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "StandardDeck") then
            stDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "~Reform") then
            reformSnapPoint = snapPoint
        end
    end

    playerData[player].reconstructMode = false
    
    -- Combine secondary hand cards into a deck.
    local reformedDeck = cardsToDeck(player,
        getCardsInHand(player, 2),
        stDeckSnapPoint,    -- Place onto the draw pile.
        {x=0, y=0, z=180},  -- Flipped.
        {x=0, y=-0.22, z=0} -- Board height.
        )
    -- Combine newly selected card into the deck.
    if reformedDeck ~= nil then
        reformedDeck = reformedDeck.putObject(cardObj)
    else
        reformedDeck = cardObj
    end
    -- Look for any special cards we need to REMOVE from the deck!
    for i, card in ipairs(reformedDeck.getObjects()) do
        if card.name == "Optimizer" then
            local specialCard = reformedDeck.takeObject({index = card.index})
            specialCard.setPositionSmooth(playerBoard.positionToWorld(Vector(discardSnapPoint.position)))
            specialCard.setRotation(playerBoardRotation)
        end
    end
    -- Shuffle it.
    if reformedDeck ~= nil then 
        reformedDeck.shuffle() -- Randomise card order
    end
    
    
    -- Combine primary hand cards into a new enhanced deck.
    local enhancedCardList = getCardsInHand(player, 1)
    -- We need to double-check it hasn't still got the selected enhanced card (due to a bug it sometimes glitches because it does!)
    for i, card in ipairs(enhancedCardList) do
        if card.getGUID() == cardObj.getGUID() then
            table.remove(enhancedCardList, i)
        end
    end
    local reformedDeck = cardsToDeck(player,
        enhancedCardList,
        enDeckSnapPoint,    -- Place onto enhanced deck pile.
        {x=0, y=90, z=180}, -- Flipped, and rotated horizontal.
        {x=0, y=-0.22, z=0} -- Board height.
        )
    
    -- Return any set-aside cards back into the player's hand.
    -- The secondary hand should remain empty at this stage.
    deckToHand(player, 1, reformSnapPoint)
    
    broadcastToColor(removedCard .. " → " .. addedCard, player, {r=255/255, g=255/255, b=255/255, a=1})
    lovSays(player, "Restructuring complete. Please remember to increase the CP Gauge.")
    return
    
end

function cancelDeckReform(player, swapped_hands)
    
    local playerPosition = playerData[player].position
    if not playerPosition then return end
    
    -- Find the player's character board.
    printDebug("Finding player board.")
    local playerBoard = getPlayerBoard(player)
    
    printDebug("Locating snap points.")
    local discardSnapPoint = nil
    local enDeckSnapPoint = nil
    local stDeckSnapPoint = nil
    local reformSnapPoint = nil
    local playerBoardRotation = playerBoard.getRotation()
    
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "Discard") then
            discardSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "EnhancedDeck") then
            enDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "StandardDeck") then
            stDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "~Reform") then
            reformSnapPoint = snapPoint
        end
    end

    playerData[player].reconstructMode = false
    
    -- Combine hand back to discard.
    local reformedDeck = cardsToDeck(
        player,
        getCardsInHand(player, swapped_hands and 2 or 1),
        discardSnapPoint,   -- Place onto the discard pile.
        {x=0, y=0, z=0},
        {x=0, y=0, z=0}
        )
        
    if swapped_hands then
        if reformedDeck ~= nil then
            reformedDeck.putObject(playerData[player].lastRemovedCard)
        else
            local newPosition = playerBoard.positionToWorld(Vector(discardSnapPoint.position))
            playerData[player].lastRemovedCard.setPosition(newPosition)
        end
    end
    
    -- Combine other hand back into an Enhanced Deck.
    local secondaryCards = getCardsInHand(player, swapped_hands and 1 or 2)
    for i, card in ipairs(secondaryCards) do
        -- If the card was the card we added to the Enhanced Deck in the last step,
        -- exclude it from this list and put it back to the discard pile it came from.
        if swapped_hands == true and
           playerData[player].lastRemovedCard ~= nil and
           card.getGUID() == playerData[player].lastRemovedCard.getGUID() then
            table.remove(secondaryCards, i)
        end
    end
    
    local reformedDeck = cardsToDeck(
        player,
        secondaryCards,
        enDeckSnapPoint,    -- Place onto enhanced deck pile.
        {x=0, y=90, z=180}, -- Flipped, and rotated horizontal.
        {x=0, y=-0.22, z=0} -- Board height.
        )
    
    -- Return any set-aside cards back into the player's hand.
    -- The secondary hand should remain empty at this stage.
    deckToHand(player, 1, reformSnapPoint)
    
    lovSays(player, "Cancelling reconstruction.")
    return
end
-- Unlike reform this only ADDs a card, used for pre-game setup.
function startDeckEnhance(playersToEnhance)
    for _, player in ipairs(playersToEnhance) do
        if playerData[player].reconstructMode then
            printToAll("One or more players is busy reforming their deck.", messageColors.Error)
            return false
        end
    end
    
    for _, player in ipairs(playersToEnhance) do
        local playerPosition = playerPositions[player]
        
        -- Find the player's character board.
        printDebug("Finding " .. player .. " player board.")
        local playerBoard = nil
        for _, obj in ipairs(getObjectsWithTag("PlayerComponent_CharacterBoard")) do
            if obj.hasTag("PlayerOwned_" .. player) then
                printDebug("Player board " .. obj.getGUID())
                playerBoard = obj
            end
        end
        -- If Player has no board set up, cancel the reform.
        if playerBoard == nil then
            lovSays(player, "Please select and set up a character first before reforming your deck.")
            return false
        end
        
        printDebug("Locating snap points.")
        local discardSnapPoint = nil
        local enDeckSnapPoint = nil
        local stDeckSnapPoint = nil
        local reformSnapPoint = nil
        local playerBoardRotation = playerBoard.getRotation()
        
        for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
            if snapPointHasTag(snapPoint, "Discard") then
                discardSnapPoint = snapPoint
            elseif snapPointHasTag(snapPoint, "EnhancedDeck") then
                enDeckSnapPoint = snapPoint
            elseif snapPointHasTag(snapPoint, "StandardDeck") then
                stDeckSnapPoint = snapPoint
            elseif snapPointHasTag(snapPoint, "~Reform") then
                reformSnapPoint = snapPoint
            end
        end
        
        -- Start Reform and look through Enhanced Deck
        printDebug("Not already in Reconstruct Mode")
        playerData[player].reconstructMode = true

        deckToHand(player, 1, enDeckSnapPoint)  -- Move deck into the player's primary hand
        deckToHand(player, 1, discardSnapPoint) -- Move discard pile into the player's primary hand
        deckToHand(player, 2, stDeckSnapPoint)  -- Move the enhanced deck into the player's secondary hand

        chooseInHand(
            "reconstructMode_nine", -- selectID
            1, -- Required to select a card.
            1, -- Cannot select 2 cards at once.
            "Select [b]1 card[/b] to from your [b][F05050]Enhanced deck[-][/b] to add to your starting deck.",
            {player})
    end
end

function endDeckEnhance(player, selectedCards)
    local cardObj     = selectedCards[1]
    local addedCard   = cardObj.getName()
    
    local playerPosition = playerData[player].position
    if not playerPosition then return end
    
    -- Find the player's character board.
    printDebug("Finding player board.")
    local playerBoard = getPlayerBoard(player)
    
    printDebug("Locating snap points.")
    local discardSnapPoint = nil
    local enDeckSnapPoint = nil
    local stDeckSnapPoint = nil
    local reformSnapPoint = nil
    local playerBoardRotation = playerBoard.getRotation()
    
    for _, snapPoint in ipairs(playerBoard.getSnapPoints()) do
        if snapPointHasTag(snapPoint, "Discard") then
            discardSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "EnhancedDeck") then
            enDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "StandardDeck") then
            stDeckSnapPoint = snapPoint
        elseif snapPointHasTag(snapPoint, "~Reform") then
            reformSnapPoint = snapPoint
        end
    end

    playerData[player].reconstructMode = false
    
    -- Combine secondary hand cards into a deck.
    local reformedDeck = cardsToDeck(player,
        getCardsInHand(player, 2),
        stDeckSnapPoint,    -- Place onto the draw pile.
        {x=0, y=0, z=180},  -- Flipped.
        {x=0, y=-0.22, z=0} -- Board height.
        )
    -- Combine newly selected card into the deck.
    if reformedDeck ~= nil then
        reformedDeck = reformedDeck.putObject(cardObj)
    else
        reformedDeck = cardObj
    end
    -- Shuffle it.
    if reformedDeck ~= nil then 
        reformedDeck.shuffle() -- Randomise card order
    end
    
    
    -- Combine primary hand cards into a new enhanced deck.
    local enhancedDeck = cardsToDeck(player,
        getCardsInHand(player, 1),
        enDeckSnapPoint,    -- Place onto enhanced deck pile.
        {x=0, y=90, z=180}, -- Flipped, and rotated horizontal.
        {x=0, y=-0.22, z=0} -- Board height.
        )
    
    -- Return any set-aside cards back into the player's hand (if there was any for some reason).
    -- The secondary hand should remain empty at this stage.
    deckToHand(player, 1, reformSnapPoint)
    
    broadcastToColor("Selected initial Enhanced Card: " .. addedCard, player, {r=255/255, g=255/255, b=255/255, a=1})
    return {reformedDeck, enhancedDeck}
    
end

function onPlayerHandChoice(player, modeID, selectedObjects, was_confirmed)
    if modeID == "reconstructMode_discard" then
        if was_confirmed then
            playerData[player].lastRemovedCard = selectedObjects[1]
            continueDeckReform(player, selectedObjects)
        else
            cancelDeckReform(player, false)
        end
        
    elseif modeID == "reconstructMode_enhanced" then
        if was_confirmed then
            endDeckReform(player, selectedObjects)
        else
            cancelDeckReform(player, true)
        end
        
    elseif modeID == "reconstructMode_nine" then
        local newDecks = endDeckEnhance(player, selectedObjects)
        Wait.time(
            function()
                moveTopCardToTurnSlot(player, newDecks[1])
            end,
            0.6)
    end
end

function secureHandCards(player)
    handCardsBackup[player] = {}
    local handObjs = Player[player].getHandObjects()
    
    local handDropPos = {
        x = playerPositions[player]["x"] + 4.8,
        y = playerPositions[player]["y"],
        z = playerPositions[player]["z"] + 6.8
    }
    for _, card in ipairs(handObjs) do
        card.setPosition(handDropPos)
        card.setRotation({x=0, y=180, z=180})
        table.insert(handCardsBackup[player], card)
    end

    
end

function isNearSnapPoint(playerBoard, snapPoint, obj)
    local snapPointPosition = playerBoard.positionToWorld(Vector(snapPoint.position))
    local objectPosition    = obj.getPosition()
    
    tolerance = {
        min = {x =-1.0, y=-1, z=-2.2},
        max = {x = 3.5, y= 1, z=2.2}
    }
    
    local relativePosition = {
        x = objectPosition.x - snapPointPosition.x,
        y = objectPosition.y - snapPointPosition.y,
        z = objectPosition.z - snapPointPosition.z,
    }
    
    if relativePosition.x <= tolerance.max.x and relativePosition.x >= tolerance.min.x  and
       relativePosition.y <= tolerance.max.y and relativePosition.y >= tolerance.min.y  and
       relativePosition.z <= tolerance.max.z and relativePosition.z >= tolerance.min.z then
        return true
    else
        return false
    end
    
end

function cardsToDeck(player, cardObjects, snapPoint, rotation, position)
    -- Move all of a given list of card objects, and place onto
    -- the defined [snapPoint] with a given [rotation].
    local playerBoard  = getPlayerBoard(player)
    local deckPosition = playerBoard.positionToWorld(Vector(snapPoint.position))
    local rotationOffset = rotation or {x=0, y=0, z=0}
    local positionOffset = position or {x=0, y=0, z=0}
    
    deckPosition = {
            x=deckPosition.x + positionOffset.x,
            y=deckPosition.y + positionOffset.y,
            z=deckPosition.z + positionOffset.z,
            }
    
    local playerBoardRotation = playerBoard.getRotation()
    local deckRotation = {
            x=playerBoardRotation.x + rotationOffset.x,
            y=playerBoardRotation.y + rotationOffset.y,
            z=playerBoardRotation.z + rotationOffset.z
            }
    
    local reformedDeck = nil
    
    -- If there is already a deck of cards in the specified location, combine together
    -- and set as the new deck.
    for _, obj in ipairs(getObjectsWithTag("PlayerOwned_" .. player)) do
        if isNearSnapPoint(playerBoard, snapPoint, obj) and
            (obj.type == "Deck" or obj.type == "Card") then
            if reformedDeck == nil then
                reformedDeck = obj
            else
                reformedDeck = reformedDeck.putObject(obj)
            end
        end
    end     
    
    -- Iterate over given cards to add to the deck.
    for _, card in ipairs(cardObjects) do
        if card.type == "Card" or card.type == "Deck" then
            if reformedDeck == nil then
                reformedDeck = card
                -- The position is set immediately otherwise treating it as a deck later glitches when from the main hand.
                reformedDeck.setPosition(deckPosition)
                reformedDeck.setRotation(deckRotation)
            else
                reformedDeck = reformedDeck.putObject(card)
            end
        end
    end
    
    if reformedDeck ~= nil then
        reformedDeck.setPosition(deckPosition)
        reformedDeck.setRotation(deckRotation)
        end
    
    return reformedDeck
end

function deckToHand(player, handIndex, snapPoint)
    local playerBoard = getPlayerBoard(player)
    
    -- Move all cards from the specified [snapPoint], and place into
    -- the defined player's hand [handIndex].
    for _, obj in ipairs(getObjectsWithTag("PlayerOwned_" .. player)) do
        if isNearSnapPoint(playerBoard, snapPoint, obj) and
        (obj.type == "Deck" or obj.type == "Card") then
            deckSize = (obj.type == "Deck") and tonumber(obj.getQuantity()) or 1
            obj.deal(deckSize, player, handIndex)
        end
    end
end

function getCardsInHand(player, handIndex)
    local handCards = {}
    for _, card in ipairs(Player[player].getHandObjects(handIndex)) do
        if card.type == "Card" or card.type == "Deck" then
            table.insert(handCards, card)
        end
    end
    return handCards
end

function swapHands(player)
    for _, card in ipairs(Player[player].getHandObjects(1)) do
        if card.tag == "Card" or card.tag == "Deck" then
            local deckSize = (card.type == "Deck") and tonumber(card.getQuantity()) or 1
            card.deal(deckSize, player, 2)
        end
    end

    for _, card in ipairs(Player[player].getHandObjects(2)) do
        if card.tag == "Card" or card.tag == "Deck" then
            local deckSize = (card.type == "Deck") and tonumber(card.getQuantity()) or 1
            card.deal(deckSize, player, 1)
        end
    end
end



--   ARENA BOARD Functions
-- [→onLoad()]: Spawns a spare copy of each forecast card inside an inaccessible area.
-- This is because the images will reload repeatedly unless there is a card already present to cache
-- the image.
function setCardCache()
    for _, obj in ipairs(getObjectsWithTag("Cache")) do
        obj.destruct()
    end

    forecastObjects = turnBoard.getTable("forecastObjects")
    
    for _, objData in pairs(forecastObjects) do
        local spawnedObject = spawnObjectData({
            data = objData,
            position = {x=0, y=-3, z=0},
            rotation = {x=0, y=0, z=0},
            })
        spawnedObject.setLock(true)
        spawnedObject.interactable = false
        spawnedObject.setTags({"Cache"})
    end
end
-- [→onLoad()][→onObjectSpawn()]: Registers the Clad, even when changing state.
function registerCladFigure()
    for _, obj in ipairs(getObjects()) do
        if obj.hasTag("BACL_BossFigurine") then
            obj.registerCollisions()
        end
    end
end

function boardUpdate()
  -- Delays the update check slightly, ensuring it has time for cards to be moved.
  -- Additionally, multiple update requests at once will be ignored for efficiency
  if boardUpdateTimer == nil then
    boardUpdateTimer = Wait.time(
      function()
        boardUpdateTimer = nil
        turnBoard.call("boardUpdate")
        return
      end,
      0.1, -- 100 milliseconds
      1    -- run the function 1 time
    )
  else
    printDebug("Update already in progress. Ignoring card.")
  end
end

function findArenaPositionByGrid(gridPosition)
    local board = Global.getVar("arenaBoard")
    local boardCenterPosition = board.getPosition()

    local worldPosition = {
        x = boardCenterPosition.x + (gridPosition.x-3) * FIELD_GRID_DISTANCE,
        y = boardCenterPosition.y + 0.67,
        z = boardCenterPosition.z + (2.99 - gridPosition.y) * FIELD_GRID_DISTANCE
    }
    
    return worldPosition
end



-- GAME SETUP Functions
function gameSetup(args)
    destroyScriptedObjects()
    
    if args.setup == 1 then
        Wait.time(
            function()
                autoGameSetup(args.mode)
            end,
            0.5) 
    end
end

function destroyScriptedObjects()
    for _, obj in pairs(getObjects()) do
        if obj.hasTag("Tool_SetupButton") then
            obj.destruct()
        elseif obj.hasTag("Tool_SetupObjects") then
            obj.destruct()
        elseif obj.hasTag("Tool_PlayerBoard") then
            for i, btn in pairs(obj.getButtons()) do
                obj.removeButton(i - 1)
            end
            obj.UI.setXmlTable({{}})
        end
    end
end

function autoGameSetup(gameMode)
    randomisePlayerOrder()
    
    baseTime = 2.5
    Wait.time(
        function()
            cladDeckSetupCoop(gameMode)
        end,
        baseTime)
    if gameMode == 1 then
        baseTime = baseTime + 1.0
    else
        baseTime = baseTime + 4.5
    end
    
    Wait.time(
        function()
            dealMissions(gameMode)
        end,
        baseTime)
end

function cladDeckSetupCoop(gameMode)
    local cladDecks = {}
    for voltageNumber = 1,3,1 do
        local cardList = {}
        for _, obj in pairs(getObjects()) do
            if obj.type == "Card" then
                local data = JSON.decode(obj.getGMNotes()) or {}
                if data.Voltage == tostring(voltageNumber) then
                    table.insert(cardList, obj)
                end
            elseif obj.type == "Deck" then
                for _, card in pairs(obj.getObjects()) do
                    local data = JSON.decode(card.gm_notes) or {}
                    if data.Voltage == tostring(voltageNumber) then
                        local cardObj = obj.remainder
                        if cardObj == nil then
                            cardObj = obj.takeObject{guid=card.guid}
                        end
                        table.insert(cardList, cardObj)
                    end
                end
            end
        end
        
        local deckObj = nil
        local destinationPosition = getBoardSnapPointPosition(turnBoard, "~Voltage" .. voltageNumber)
        if voltageNumber == 1 then
            destinationPosition.y = destinationPosition.y + 0.2
        end
        for _, obj in pairs(cardList) do
            if deckObj == nil then
                deckObj = obj
                deckObj.setPosition(destinationPosition)
                deckObj.setRotation({
                    x = turnBoard.getRotation().x,
                    y = turnBoard.getRotation().y,
                    z = gameMode == 2 and 180
                        or voltageNumber == 1 and 180
                        or 0,
                    })
            else
                obj.setPosition(destinationPosition)
                deckObj = deckObj.putObject(obj)
                obj.destruct()
            end
        end
        table.insert(cladDecks, voltageNumber, deckObj)
    end
    
    local baseTime = 1.0
    if gameMode == 1 then
         -- Shuffle the Voltage 1 deck
        Wait.time(function()
            cladDecks[1].shuffle()
            end,
            baseTime, 1)
        
    elseif gameMode == 2 then
        -- Move the Voltage 2 deck into the Voltage 1 deck.
        Wait.time(function()
            cladDecks[1].putObject(cladDecks[2])
            end,
            baseTime, 1)
        baseTime = baseTime + 0.5
        
        -- Shuffle the Voltage 1 deck
        Wait.time(function()
            cladDecks[1].shuffle()
            end,
            baseTime, 1)
        baseTime = baseTime + 0.5
        
        -- Move 3 cards into the Voltage 3 deck
        Wait.time(function()
            Wait.time(function()
                cladDecks[3] = cladDecks[3].putObject(cladDecks[1].takeObject())
                end,
                0.1, 3)   
            end,
            baseTime, 1)
        baseTime = baseTime + 0.9
        
        -- Shuffle the Voltage 3 deck.
        Wait.time(function()
            cladDecks[3].shuffle()
            end,
            baseTime, 1) 
        baseTime = baseTime + 0.5

        -- Move 3 cards back into the Voltage 2 deck.
        Wait.time(function()
            Wait.time(function()
                local newCard = cladDecks[3].takeObject()
                local volt2Position = getBoardSnapPointPosition(turnBoard, "~Voltage2")
                newCard.setPositionSmooth({
                    x = volt2Position.x,
                    y = volt2Position.y + 0.20,
                    z = volt2Position.z
                })
                end,
                0.1, 3) -- Repeat 2 times total.
            end,
            baseTime, 1)
    end
end

function randomisePlayerOrder()
    local entryAssignment = {"A", "B", "C", "D"} -- Assigned entry point based on player order
    local playerData = Global.getTable("playerData")
    local function BBcolor(stringColor)
        local color = stringColorToRGB(stringColor)
        return '[' .. string.format("%02x%02x%02x", color[1]*255, color[2]*255, color[3]*255) .. ']'
    end

    local seated  = getSeatedPlayers()
    local shuffled = {}
    while #seated > 0 do
        local rand = math.random(1, #seated)
        local playerColour = seated[rand]
        
        -- If the player has a designated playing zone. Other seated players are irrelevant.
        if playerData[playerColour] and playerData[playerColour].boardZoneGUID ~= nil then
            table.insert(shuffled, seated[rand])
            
            if getPlayerFigure(playerColour) == nil then
                printToAll("One or more players has no valid character selected.", messageColors.Error)
                return nil
            end
        end
        
        table.remove(seated, rand)
    end

    local msg = ""
    for k, color in ipairs(shuffled) do
        msg = msg .. k .. ". " .. BBcolor(color) .. Player[color].steam_name .. "[-]"
        if k ~= #shuffled then
            msg = msg .. ", "
        end
    end

    broadcastToAll(msg, {1, 1, 1})
    
    for i, player in ipairs(shuffled) do
        playerData[player].startingTurn = i,
        Wait.time(function()
            local witchFigure = getPlayerFigure(player)
            local placementPosition = Global.call("findArenaPositionByGrid", entryPointPositions[entryAssignment[i]])
            witchFigure.setPositionSmooth(placementPosition)
            witchFigure.setRotation({x=0, y=0, z=0})
            end,
            0.4*i, 1)
    end
    
    Global.setTable("playerData", playerData)
end

function dealMissions(gameMode)
    local poolGrid = {
        {x=-2, z=0},
        {x=-1, z=0},
        {x=0, z=0},
        {x=1, z=0},
        {x=2, z=0},
        {x=-2, z=-1},
        {x=-1, z=-1},
        {x=0, z=-1},
        {x=1, z=-1},
        {x=2, z=-1},
    }

    printDebug("Removing all Mission Cards from table.")
    for _, object in ipairs(getObjectsWithTag("playerComponent_MissionCard")) do
        object.Destruct()
    end

    printDebug("Spawning mission card deck.")
    
    -- Find mode type for how to deal mission cards
    -- Based on if any Delta characters are in play.
    local rulesType = "Base"
    local numPlayers = 0
    for color, data in pairs(Global.getTable("playerData")) do
        if Player[color].seated == true then
            numPlayers = numPlayers + 1
            if data.charName == nil then
                printToAll("One or more players has no valid character selected.", messageColors.Error)
                return false
            elseif data.charType == "Delta" then
                rulesType = "Delta"
            end
        end
    end
    if numPlayers == 1 then rulesType = "Solo" end
    
    printToAll("Dealing Mission Cards.", messageColors.Default)
    local missionDeck = spawnObjectData({
        data = generateMissionDeck(missionData),
        position = {x=-20, y=0.25, z=25},
        rotation = {x=0, y=180, z=0}
    })
    missionDeck.addTag("PlayerComponent_MissionDeck") -- For some reason this can't be set in the generateObject data???
    missionDeck.locked = true
    missionDeck.shuffle()

    -- Button attached to Mission Deck to continue the setup procedure once players are done assigning Mission Cards.
    missionDeck.createButton({
        label          = "Continue\nsetup",
        click_function = "autoGameSetupSecond",
        function_owner = Global,
        font_size      = 500,
        width          = 1000,
        height         = 1000,
        color          = {r=0.2, g=0.2, b=0.8, a=80},
        font_color     = {r=255, g=255, b=255, a=255},
        position       = {
            x =  0,
            y =  0,
            z =  4,
        },
        tooltip        = "Proceed with Auto Setup once you have completed selecting Mission Cards.",
        })
    
    -- Delay dealing for visual confirmation.
    Wait.time(
        function()
            -- Under Delta and Coop rules, deal to each mission char.
            if rulesType == "Delta" or rulesType == "Solo" or gameMode == "coop" then
                for playerColor, playerData in pairs(Global.getTable("playerData")) do
                    if Player[playerColor].seated == true then
                        if playerData.charType == "Base" then
                        
                            local dealCount = ((rulesType == "Solo")    and 2) or
                                              ((gameMode  == "versus") and 5) or
                                              ((gameMode  == "coop")   and 2) or
                                              2
                            for i=1,dealCount do 
                                local dealtCard = missionDeck.takeObject()
                                dealtCard.addTag("PlayerOwned_" .. playerColor)
                                dealtCard.deal(1, playerColor, 1)
                            end
                        end
                    end
                end
                
            else -- Under Base Game rules, community pool.
            
                -- Loop through dealing out each community card individually.
                for i=1,10 do
                    local basePosition = missionDeck.getPosition()
                    basePosition = {
                        x = basePosition.x + 20 + (poolGrid[i].x * 3.5),
                        y = 0.5,
                        z = basePosition.z +  0 + (poolGrid[i].z * 5),
                    }
                    -- Delay each card deal based on sequence order. Makes it look cool :)
                    Wait.time(
                        function()
                            local dealtCard = missionDeck.takeObject()
                            dealtCard.setPositionSmooth(basePosition)
                        end,
                        0.1*i,
                        1)
                end
                
            end
                
            return
        end,
        0.5, -- 500 milliseconds
        1    -- run the function 1 time
        )
                            
    
    
    --missionDeck.Destruct()
end

function autoGameSetupSecond()
    Wait.time(
        function()
            -- Find and destroy the Mission Deck
            for _, obj in pairs(getObjectsWithTag("PlayerComponent_MissionDeck")) do
                obj.destruct()
            end
        
            -- Prompt players to enhance their 9th card.
            ninthEnhancedCard()
        end,
        0.5)
end

function ninthEnhancedCard()
    local seated  = getSeatedPlayers()
    local enhancePlayers = {}
    for _, player in ipairs(seated) do
        -- If the player has a designated playing zone. Other seated players are irrelevant.
        if playerData[player] and playerData[player].boardZoneGUID ~= nil then
            table.insert(enhancePlayers, player)
            if playerData[player].charName == nil then
                printToAll("One or more players has no valid character selected.", messageColors.Error)
                return false
            end
        end
    end
    
    Global.call("startDeckEnhance", enhancePlayers)
end

function moveTopCardToTurnSlot(playerColor, deckObj)
    local cardObj = deckObj.takeObject({})
    local turnNumberTag = "~" .. playerData[playerColor].startingTurn
    local destinationSlot = getBoardSnapPointPosition(turnBoard, turnNumberTag)
    destinationSlot.y = destinationSlot.y + 0.3
    cardObj.setRotation({
        x = turnBoard.getRotation().x,
        z = 180,
        y = turnBoard.getRotation().y,})
    cardObj.setPositionSmooth(destinationSlot, false, false)
end

-- OBJECT CREATION FUNCTIONS
-- Each function handles different object types to create.
-- Due to the rather bespoke nature of each type they've been split across multiple functions.
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
-- Decks take on an entirely different form to all other objects, and so have to be generated through a secondary function.
function generateMissionDeck(deckData)
    local outputObject = generateObject({
            objType = "Deck",
            })
    
    outputObject.CustomDeck = {
        ["1"] = {
              FaceURL      = deckData.faceURL ,
              BackURL      = deckData.backURL,
              NumWidth     = deckData.imgGridWidth,
              NumHeight    = deckData.imgGridHeight,
              BackIsHidden = true,
              UniqueBack   = true,
              Type = 0
        }
    }

    -- Iterate over all cards from the given deck type (standard / enhanced)
    for i, card in ipairs(deckData.cardList) do
        -- TTS REQUIRES the number be formatted as a 2 digit ID concatenated to the CustomDeck ID number.
        -- i.e. The first card must be X00, followed by X01.
        local GeneratedID = "1" .. string.format("%02d" , card.gridPos)
        
        table.insert(outputObject.ContainedObjects, {
            Name = "Card",
            Nickname = card.name,
            CardID   = GeneratedID,
            Tags     = {"PlayerComponent_MissionCard"},
            CustomDeck = {
                ["1"] = {
                    FaceURL      = deckData.faceURL ,
                    BackURL      = deckData.backURL,
                    NumWidth     = deckData.imgGridWidth,
                    NumHeight    = deckData.imgGridHeight,
                    BackIsHidden = true,
                    UniqueBack   = true,
                    Type = 0
            }} 
        })
        
        table.insert(outputObject.DeckIDs, GeneratedID)
    end
    
    return outputObject
end



-- META Functions
-- An assortment of functions used for broad meta-level and debugging control over the script behaviour.
function isDebug()
  return false
end

function scriptEnabled()
  return true
end