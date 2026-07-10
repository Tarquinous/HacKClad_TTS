function gitLink(fileDirectory)
    return Global.call("gitLink", fileDirectory)
end

local btnScale  = 160
local btnMargin = 5   -- Percentage

local btnSpacing           = (1 + (btnMargin/100)) / 490
local luaToXmlRatioPos     = 100
local luaToXmlRatioBtnSize = 0.204

local btnTransparency = 0

--[=[ The stored data of all characters including metadata and what assets they will need to be spawned.

    [*KEY]        = The character's identifying name for the purposes of scripting and tooltips. 
    
    icon          = The image shown as the button.
    
    layoutType    = The overall layout category. Must be a valid type defined in boardSnapPoints.
                    Available types: "Base", "Delta".
                    
    playerBoard   = URL of player board image.
        frontURL             = Image for top of board.
        backURL              = [Optional] Image for the back of the board. Usually only seen via Alt-View.
        edgeColour           = [Optional] Colour for the board sides.
        additionalSnapPoints = A list of additional Snap Points the board requires.
                               Formatting must match boardSnapPoints.
                               
    decks = Data for the character decks.
        faceURL       = URL of card fronts.
        backURL       = URL of card backs
        imgGridWidth  = Horizontal width of image for how many cards wide it is.
        imgGridHeight = Vertical height of image for how many cards tall it is.
        cardList      = List of all cards in the deck.
            standard       = Standard deck
            enhanced       = Enhanced deck
                gridPos        = Where in the deck image the card is positioned.
                name           = Name of card.
                VP             = The Victory Point value of the card.
                ref            = HacKClaD's official reference number of each card.
                
    referenceCard = [Optional] Additional info card to explain unique mechanics.
        frontURL  = Front image of the card.
        backURL   = [Optional] Back image of the card.
        edgeColor = [Optional] Colour for the card sides.
        
    customTokens  = [Optional] List of additional tokens that the character requires to be spawned.
        frontURL   = top image of the token.
        backURL    = [Optional] bottom image of the token.
        edgeColour = [Optional] Colour for the token sides.
        position   = Spawn position. This is a LOCAL POSITION relative to the board.
                     For refernece, Local Position {x=1,z=1} is equivalent to World Position {x=-6.47, z=-4.58}.
                     Usually matches an additionalSnapPoint.
            x        = Relative horizontal position. Positive values move to the right.
            z        = Relative vertical position. Position values move downward.
            rotation = Relative (y) rotation. 0 will match the board's direction.
        scale      = [Optional] Scale to resize token. Does NOT change the token's thickness.
        thickness  = [Optional] Changes the tile's thickness. Default is 0.200.
        type       = [Optional] Token shape of Square, Hex, Circle, or Rounded. Default is Rounded.
        tags       = [Optional] A list of bject tags to be added to the token. Usually used for board snap points.
        flipped    = [Optional] Set to true to start the token face-down.
--]=]
local characterData = {
    ["Rosette"]   = {
    icon         = gitLink("Characters/Rosette/Rosette_icon.png"),
    sourceGame   = "Base Game",
    layoutType   = "Base",
    figure       = { 
        frontURL   = gitLink("Characters/Rosette/Rosette_figure.png"),
        backURL    = "",
        baseColour = {r=214, g=26, b=26}
    },
    playerBoard  = {
        frontURL = gitLink("Characters/Rosette/Rosette_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=212, g=201, b=195}
    },
    deck = {
        faceURL       = gitLink("Characters/Rosette/Rosette_skillCards.webp"),
        backURL       = gitLink("Characters/Rosette/Rosette_cardBack.jpeg"),
        imgGridWidth  = 10,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0,  name = "Shot",              VP = 1, ref="BAS-W01-01"},
                { gridPos = 1,  name = "Guard",             VP = 1, ref="BAS-W01-02"},
                { gridPos = 2,  name = "Move",              VP = 1, ref="BAS-W01-03"},
                { gridPos = 3,  name = "Barrage",           VP = 1, ref="BAS-W01-04"},
                { gridPos = 4,  name = "Barrage",           VP = 1, ref="BAS-W01-05"},
                { gridPos = 5,  name = "Firecracker",       VP = 1, ref="BAS-W01-06"},
                { gridPos = 6,  name = "Tail Whip",         VP = 1, ref="BAS-W01-07"},
                { gridPos = 7,  name = "Verve",             VP = 1, ref="BAS-W01-08"}
                },
            enhanced = {
                { gridPos = 8,  name = "Crimson Barrage",   VP = 2, ref="BAS-W01-09"},
                { gridPos = 9,  name = "Sol Shimmer",       VP = 3, ref="BAS-W01-10"},
                { gridPos = 10, name = "Immolate",          VP = 2, ref="BAS-W01-11"},
                { gridPos = 11, name = "Rose Whip",         VP = 3, ref="BAS-W01-12"},
                { gridPos = 12, name = "Counter Cross",     VP = 4, ref="BAS-W01-13"},
                { gridPos = 13, name = "Auxillary Mana",    VP = 4, ref="BAS-W01-14"},
                { gridPos = 14, name = "Active Combustion", VP = 2, ref="BAS-W01-15"},
                { gridPos = 15, name = "Watch Fire",        VP = 4, ref="BAS-W01-16"},
                { gridPos = 16, name = "Head-On Brawl",     VP = 2, ref="SEC-W01-01"},
                { gridPos = 17, name = "Guts",              VP = 3, ref="SEC-W01-02"}
                }
            },
        },
    },
    ["Flare"]     = {
    icon         = gitLink("Characters/Flare/Flare_icon.webp"),
    sourceGame   = "Base Game",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Flare/Flare_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=199, g=206, b=120}
        },
    figure       = { 
        frontURL = gitLink("Characters/Flare/Flare_figure.png"),
        backURL    = "",
        baseColour = {r=210, g=225, b=45}
        },
    deck = {
        faceURL       = gitLink("Characters/Flare/Flare_skillCards.webp"),
        backURL       = gitLink("Characters/Flare/Flare_cardBack.jpeg"),
        imgGridWidth  = 10,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0,  name = "Shot",               VP = 1, ref="BAS-W02-01"},
                { gridPos = 1,  name = "Guard",              VP = 1, ref="BAS-W02-02"},
                { gridPos = 2,  name = "Move",               VP = 1, ref="BAS-W02-03"},
                { gridPos = 3,  name = "Demolish",           VP = 1, ref="BAS-W02-04"},
                { gridPos = 4,  name = "Hook Shot",          VP = 1, ref="BAS-W02-05"},
                { gridPos = 5,  name = "Ensnare",            VP = 1, ref="BAS-W02-06"},
                { gridPos = 6,  name = "Fortress",           VP = 1, ref="BAS-W02-07"},
                { gridPos = 7,  name = "Repair",             VP = 1, ref="BAS-W02-08"}
                },
            enhanced = {
                { gridPos = 10, name = "Desperate Measures", VP = 1, ref="BAS-W02-09"},
                { gridPos = 11, name = "Vortex",             VP = 3, ref="BAS-W02-10"},
                { gridPos = 12, name = "Serated Edge",       VP = 3, ref="BAS-W02-11"},
                { gridPos = 13, name = "Flux",               VP = 2, ref="BAS-W02-12"},
                { gridPos = 14, name = "Reflex",             VP = 4, ref="BAS-W02-13"},
                { gridPos = 15, name = "Reflect",            VP = 3, ref="BAS-W02-14"},
                { gridPos = 9,  name = "Auxillary Mana",     VP = 4, ref="BAS-W02-15"},
                { gridPos = 16, name = "Passive Shield",     VP = 4, ref="BAS-W02-16"},
                { gridPos = 17, name = "Oath of Salvation",  VP = 2, ref="SEC-W02-01"},
                { gridPos = 8,  name = "Recovery",           VP = 3, ref="SEC-W02-02"}
                }
            },
        },
    },  
    ["Luna"]      = {
    icon         = gitLink("Characters/Luna/Luna_icon.png"),
    sourceGame   = "Base Game",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Luna/Luna_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=151, g=122, b=200}
        },
    figure       = { 
        frontURL = gitLink("Characters/Luna/Luna_figure.png"),
        backURL    = "",
        baseColour = {r=145, g=25, b=220}
        },
    deck = {
        faceURL       = gitLink("Characters/Luna/Luna_skillCards.webp"),
        backURL       = gitLink("Characters/Luna/Luna_cardBack.jpeg"),
        imgGridWidth  = 10,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0,  name = "Shot",            VP = 1 ,ref="BAS-W03-01"},
                { gridPos = 1,  name = "Guard",           VP = 1 ,ref="BAS-W03-02"},
                { gridPos = 2,  name = "Move",            VP = 1 ,ref="BAS-W03-03"},
                { gridPos = 3,  name = "Absorb",          VP = 1 ,ref="BAS-W03-04"},
                { gridPos = 4,  name = "Storm",           VP = 1 ,ref="BAS-W03-05"},
                { gridPos = 5,  name = "Rebuff",          VP = 1 ,ref="BAS-W03-06"},
                { gridPos = 6,  name = "Huginn",          VP = 1 ,ref="BAS-W03-07"},
                { gridPos = 7,  name = "Catalyst",        VP = 1 ,ref="BAS-W03-08"}
                },
            enhanced = {
                { gridPos = 10, name = "Bombard",         VP = 4 ,ref="BAS-W03-09"},
                { gridPos = 11, name = "Shock",           VP = 3 ,ref="BAS-W03-10"},
                { gridPos = 12, name = "Tempest",         VP = 2 ,ref="BAS-W03-11"},
                { gridPos = 13, name = "Explosion",       VP = 2 ,ref="BAS-W03-12"},
                { gridPos = 14, name = "Mirror of Eight", VP = 4 ,ref="BAS-W03-13"},
                { gridPos = 15, name = "Auxillary Mana",  VP = 4 ,ref="BAS-W03-14"},
                { gridPos = 16, name = "Muninn",          VP = 3 ,ref="BAS-W03-15"},
                { gridPos = 17, name = "Mist Step",       VP = 3 ,ref="BAS-W03-16"},
                { gridPos =  8, name = "Empyral Grasp",   VP = 2 ,ref="SEC-W03-01"},
                { gridPos =  9, name = "Jewel of Varona", VP = 3 ,ref="SEC-W03-02"}
                }
            },
        },
    },  
    ["Mia"]       = {
    icon         = gitLink("Characters/Mia/Mia_icon.png"),
    sourceGame   = "Base Game",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Mia/Mia_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=144, g=156, b=130}
        },
    figure       = { 
        frontURL = gitLink("Characters/Mia/Mia_figure.png"),
        backURL    = "",
        baseColour = {r=255, g=125, b=25}
        },
    deck = {
        faceURL       = gitLink("Characters/Mia/Mia_skillCards.webp"),
        backURL       = gitLink("Characters/Mia/Mia_cardBack.jpeg"),
        imgGridWidth  = 10,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shot",               VP = 1 ,ref="BAS-W04-01"},
                { gridPos = 1, name = "Guard",              VP = 1 ,ref="BAS-W04-02"},
                { gridPos = 2, name = "Move",               VP = 1 ,ref="BAS-W04-03"},
                { gridPos = 3, name = "Surprise Slash",     VP = 1 ,ref="BAS-W04-04"},
                { gridPos = 4, name = "Hit and Run",        VP = 1 ,ref="BAS-W04-05"},
                { gridPos = 5, name = "Sisters In Arms",    VP = 1 ,ref="BAS-W04-06"},
                { gridPos = 6, name = [["Oi, Over Here!"]], VP = 1 ,ref="BAS-W04-07"},
                { gridPos = 7, name = "Accelerate",         VP = 1 ,ref="BAS-W04-08"}
                },
            enhanced = {
                { gridPos = 10,  name = "Sneak Attack",        VP = 2 ,ref="BAS-W04-09"},
                { gridPos = 11,  name = "Steal",               VP = 3 ,ref="BAS-W04-10"},
                { gridPos = 12, name = "Trailblaze",           VP = 1 ,ref="BAS-W04-11"},
                { gridPos = 13, name = [["Look Over There!"]], VP = 2 ,ref="BAS-W04-12"},
                { gridPos = 14, name = "Caltrops",             VP = 3 ,ref="BAS-W04-13"},
                { gridPos = 15, name = "Shadow Clone",         VP = 4 ,ref="BAS-W04-14"},
                { gridPos = 16, name = "Auxillary Mana",       VP = 4 ,ref="BAS-W04-15"},
                { gridPos = 17, name = "Robin Hood",           VP = 4 ,ref="BAS-W04-16"},
                { gridPos =  8, name = "Fluttering Wind",      VP = 2 ,ref="SEC-W04-01"},
                { gridPos =  9, name = "Dust Devil",           VP = 2 ,ref="SEC-W04-02"}
                }
            }
        },
    },  
    ["Amelia"]    = {
    icon         = gitLink("Characters/Amelia/Amelia_icon.png"),
    sourceGame   = "Base Game",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Amelia/Amelia_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=117, g=169, b=199}
        },
    figure       = { 
        frontURL = gitLink("Characters/Amelia/Amelia_figure.png"),
        backURL    = "",
        baseColour = {r=80, g=180, b=255}
        },
    deck = {
        faceURL       = gitLink("Characters/Amelia/Amelia_skillCards.webp"),
        backURL       = gitLink("Characters/Amelia/Amelia_cardBack.jpeg"),
        imgGridWidth  = 10,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shot",             VP = 1 ,ref="BAS-W05-01"},
                { gridPos = 1, name = "Guard",            VP = 1 ,ref="BAS-W05-02"},
                { gridPos = 2, name = "Move",             VP = 1 ,ref="BAS-W05-03"},
                { gridPos = 3, name = "Arm Strike",       VP = 1 ,ref="BAS-W05-04"},
                { gridPos = 4, name = "Generate Barrier", VP = 1 ,ref="BAS-W05-05"},
                { gridPos = 5, name = "Retrieval Drone",  VP = 1 ,ref="BAS-W05-06"},
                { gridPos = 6, name = "Defrag",           VP = 1 ,ref="BAS-W05-07"},
                { gridPos = 7, name = "Upgrade",          VP = 1 ,ref="BAS-W05-08"}
                },
            enhanced = {
                { gridPos = 10,  name = "Sniper Drone",     VP = 4 ,ref="BAS-W05-09"},
                { gridPos = 11,  name = "Crossfire",        VP = 1 ,ref="BAS-W05-10"},
                { gridPos = 12, name = "Fractography",      VP = 2 ,ref="BAS-W05-11"},
                { gridPos = 13, name = "Protection Drone",  VP = 4 ,ref="BAS-W05-12"},
                { gridPos = 14, name = "Auxilary Mana",     VP = 4 ,ref="BAS-W05-13"},
                { gridPos = 15, name = "Reboot",            VP = 3 ,ref="BAS-W05-14"},
                { gridPos = 16, name = "High Mobility Arm", VP = 4 ,ref="BAS-W05-15"},
                { gridPos = 17, name = "Attack Assist Arm", VP = 2 ,ref="BAS-W05-16"},
                { gridPos =  8, name = "Injection",         VP = 2 ,ref="SEC-W05-01"},
                { gridPos =  9, name = "Optimizer",         VP = 4 ,ref="SEC-W05-02"}
                }
            },
        }
    },        
    ["Croy"]      = {
    icon         = gitLink("Characters/Croy/Croy_icon.webp"),
    sourceGame   = "CROSS FATE",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Croy/Croy_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=169, g=168, b=165},
        additionalSnapPoints = {
            {x=0.047 + 0.129, z=0.685, rotation=0, tags={}},
            {x=0.047 - 0.129, z=0.685, rotation=0, tags={}}
            }
        },
    figure       = { 
        frontURL = gitLink("Characters/Croy/Croy_figure.png"),
        backURL    = "",
        baseColour = {r=40, g=0, b=90}
        },
    deck = {
        faceURL       = gitLink("Characters/Croy/Croy_skillCards.webp"),
        backURL       = gitLink("Characters/Croy/Croy_cardBack.jpeg"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shot",             VP = 1 ,ref="SEC-W06-01"},
                { gridPos = 1, name = "Guard",            VP = 1 ,ref="SEC-W06-02"},
                { gridPos = 2, name = "Move",             VP = 1 ,ref="SEC-W06-03"},
                { gridPos = 3, name = "Multistage Drill", VP = 1 ,ref="SEC-W06-04"},
                { gridPos = 4, name = "Gatecrush",        VP = 1 ,ref="SEC-W06-05"},
                { gridPos = 5, name = [["Zako, Zako~!"]], VP = 1 ,ref="SEC-W06-06"},
                { gridPos = 6, name = "Warping Drill",    VP = 1 ,ref="SEC-W06-07"},
                { gridPos = 7, name = "Deploy Gate",      VP = 1 ,ref="SEC-W06-08"}
                },
            enhanced = {
                { gridPos = 9,  name = "Realmbreaking Drill", VP = 2 ,ref="SEC-W06-09"},
                { gridPos = 10,  name = "Blinking Charge",     VP = 3 ,ref="SEC-W06-10"},
                { gridPos = 11, name = [["Behold My Power!"]], VP = 1 ,ref="SEC-W06-11"},
                { gridPos = 12, name = "Rapture",              VP = 3 ,ref="SEC-W06-12"},
                { gridPos = 13, name = "Auxilary Mana",        VP = 4 ,ref="SEC-W06-13"},
                { gridPos = 14, name = "Channelled Nexus",     VP = 3 ,ref="SEC-W06-14"},
                { gridPos = 15, name = "Gatecrush",            VP = 3 ,ref="SEC-W06-15"},
                { gridPos = 16, name = "Wanton Ruinatio",      VP = 4 ,ref="SEC-W06-16"}
                }
            }
        },
    referenceCard = {
        frontURL = gitLink("Characters/Croy/Croy_referenceCard.webp"),
        edgeColour = {r=30, g=30, b=30}
        },
    customTokens = {
        {   -- Warp Gate Token 1
            frontURL   = gitLink("Characters/Croy/Warp_Gate_Token.png"),
            backURL    = "",
            edgeColour = {r=35, g=35, b=35},
            position   = {x=0.94, z=-1.2, rotation=0},
            scale      = 0.6,
            type       = 2, -- Circle
            tags       = {"BoardSpace_Edge"}
            },
        {   -- Warp Gate Token 2
            frontURL   = gitLink("Characters/Croy/Warp_Gate_Token.png"),
            backURL    = "",
            edgeColour = {r=35, g=35, b=35},
            position   = {x=1.15, z=-1.2, rotation=0},
            scale      = 0.6,
            type       = 2, -- Circle
            tags       = {"BoardSpace_Edge"}
            },
        {   -- Warp Gate Token 3
            frontURL   = gitLink("Characters/Croy/Warp_Gate_Token.png"),
            backURL    = "",
            edgeColour = {r=35, g=35, b=35},
            position   = {x=0.94, z=-1.50, rotation=0},
            scale      = 0.6,
            type       = 2, -- Circle
            tags       = {"BoardSpace_Edge"}
            },
        {   -- Warp Gate Token 4
            frontURL   = gitLink("Characters/Croy/Warp_Gate_Token.png"),
            backURL    = "",
            edgeColour = {r=35, g=35, b=35},
            position   = {x=1.15, z=-1.50, rotation=0},
            scale      = 0.6,
            type       = 2, -- Circle
            tags       = {"BoardSpace_Edge"}
            },
        {   -- Gate Release Tile (Left)
            frontURL   = gitLink("Characters/Croy/Gate_Release_Token.png"),
            backURL    = "",
            edgeColour = {r=100, g=80, b=120},
            position   = {x=0.047 + 0.129, z=0.685, rotation=0},
            scale      = 0.33,
            thickness  = 0.100,
            type       = 3
            },
        {   -- Gate Release Tile (Right)
            frontURL   = gitLink("Characters/Croy/Gate_Release_Token.png"),
            backURL    = "",
            edgeColour = {r=100, g=80, b=120},
            position   = {x=0.047 - 0.129, z=0.685, rotation=0},
            scale      = 0.33,
            thickness  = 0.100,
            type       = 3
            },
        }
    },
    ["Lov"]       = {
    icon         = gitLink("Characters/Lov/Lov_icon.png"),
    sourceGame   = "CROSS FATE",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Lov/Lov_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=190, g=181, b=164},
        additionalSnapPoints = {
            {x=0.023, z=0.632, rotation=0, tags={}}
            }
        },
    figure       = { 
        frontURL = gitLink("Characters/Lov/Lov_figure.png"),
        backURL    = "",
        baseColour = {r=235, g=235, b=200}
        },
    deck = {
        faceURL       = gitLink("Characters/Lov/Lov_skillCards.webp"),
        backURL       = gitLink("Characters/Lov/Lov_cardBack.jpeg"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shot",             VP = 1 ,ref="SEC-A01-01"},
                { gridPos = 1, name = "Guard",            VP = 1 ,ref="SEC-A01-02"},
                { gridPos = 2, name = "Move",             VP = 1 ,ref="SEC-A01-03"},
                { gridPos = 3, name = "Tomahawk Missile", VP = 1 ,ref="SEC-A01-04"},
                { gridPos = 4, name = "Chainshot",        VP = 1 ,ref="SEC-A01-05"},
                { gridPos = 5, name = "Coordinated Fire", VP = 1 ,ref="SEC-A01-06"},
                { gridPos = 6, name = "Standby Protocol", VP = 1 ,ref="SEC-A01-07"},
                { gridPos = 7, name = "Cybermana Shield", VP = 1 ,ref="SEC-A01-08"}
                },
            enhanced = {
                { gridPos = 9, name = "Suppress",            VP = 3 ,ref="SEC-A01-09"},
                { gridPos = 10, name = "Combined Arms",       VP = 2 ,ref="SEC-A01-10"},
                { gridPos = 11, name = "Bulletstorm",         VP = 1 ,ref="SEC-A01-11"},
                { gridPos = 12, name = "Auxiliary Mana",      VP = 4 ,ref="SEC-A01-12"},
                { gridPos = 13, name = "Clairvoyent Lock-On", VP = 3 ,ref="SEC-A01-13"},
                { gridPos = 14, name = "Cybermana Charge",    VP = 3 ,ref="SEC-A01-14"},
                { gridPos = 15, name = "Battle Ready",        VP = 4 ,ref="SEC-A01-15"},
                { gridPos = 16, name = "Nullifier Ward",      VP = 4 ,ref="SEC-A01-16"}
                },
            },
        },
    customTokens = {
        {   -- Function Release Tile
            frontURL   = gitLink("Characters/Lov/Function_Release_Token.png"),
            backURL    = "",
            edgeColour = {r=250, g=250, b=255},
            position   = {x=0.023, z=0.632, rotation=0},
            scale      = 0.33,
            thickness  = 0.100,
            type       = 3
            },    
        }
    },
    ["Rosette-Δ"] = {
    icon         = gitLink("Characters/Rosette_Delta/Rosette_Delta_icon.png"),
    sourceGame   = "HacKClaD.DeltA",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Rosette_Delta/Rosette_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Rosette_Delta/Rosette_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=45, g=41, b=41}
        },
    figure       = { 
        frontURL   = gitLink("Characters/Rosette_Delta/Rosette_Delta_figure.png"),
        backURL    = "",
        baseColour = {r=180, g=0, b=0}
        },
    deck = {
        faceURL       = gitLink("Characters/Rosette_Delta/Rosette_Delta_skillCards.webp"),
        backURL       = gitLink("Characters/Rosette_Delta/Rosette_Delta_cardBack.png"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shoot",         VP = 1 ,ref="DEL-W01-01"},
                { gridPos = 1, name = "Block",         VP = 1 ,ref="DEL-W01-02"},
                { gridPos = 2, name = "Move",          VP = 1 ,ref="DEL-W01-03"},
                { gridPos = 3, name = "Vital Blow",    VP = 1 ,ref="DEL-W01-04"},
                { gridPos = 4, name = "Sweep",         VP = 1 ,ref="DEL-W01-05"},
                { gridPos = 5, name = "Lunge",         VP = 1 ,ref="DEL-W01-06"},
                { gridPos = 6, name = "Determination", VP = 1 ,ref="DEL-W01-07"},
                { gridPos = 7, name = "Challenge",     VP = 1 ,ref="DEL-W01-08"}
                },
            enhanced = {
                { gridPos = 9,  name = "Riposte",        VP = 3 ,ref="DEL-W01-09"},
                { gridPos = 10,  name = "Impale",         VP = 4 ,ref="DEL-W01-10"},
                { gridPos = 11, name = "Ratetsu",        VP = 2 ,ref="DEL-W01-11"},
                { gridPos = 12, name = "Reversal",       VP = 2 ,ref="DEL-W01-12"},
                { gridPos = 13, name = "Reap",           VP = 4 ,ref="DEL-W01-13"},
                { gridPos = 14, name = "Carnage",        VP = 4 ,ref="DEL-W01-14"},
                { gridPos = 15, name = "Auxiliary Mana", VP = 4 ,ref="DEL-W01-15"},
                { gridPos = 16, name = "Night Parade",   VP = 3 ,ref="DEL-W01-16"}   
                }
            },
        },
    },  
    ["Flare-Δ"]   = {
    icon         = gitLink("Characters/Flare_Delta/Flare_Delta_icon.png"),
    sourceGame   = "HacKClaD.DeltA",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Flare_Delta/Flare_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Flare_Delta/Flare_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=40, g=45, b=40}
        },
    figure       = { 
        frontURL   = gitLink("Characters/Flare_Delta/Flare_Delta_figure.png"),
        backURL    = "",
        baseColour = {r=140, g=165, b=20}
        },
    deck = {
        faceURL       = gitLink("Characters/Flare_Delta/Flare_Delta_skillCards.webp"),
        backURL       = gitLink("Characters/Flare_Delta/Flare_Delta_cardBack.png"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = { 
                { gridPos = 0, name = "Shoot",            VP = 1 ,ref="DEL-W02-01"},
                { gridPos = 1, name = "Block",            VP = 1 ,ref="DEL-W02-02"},
                { gridPos = 2, name = "Move",             VP = 1 ,ref="DEL-W02-03"},
                { gridPos = 3, name = "Bastion Battery",  VP = 1 ,ref="DEL-W02-04"},
                { gridPos = 4, name = "Cannonade",        VP = 1 ,ref="DEL-W02-05"},
                { gridPos = 5, name = "Concussion Salvo", VP = 1 ,ref="DEL-W02-06"},
                { gridPos = 6, name = "Gantry Shield",    VP = 1 ,ref="DEL-W02-07"},
                { gridPos = 7, name = "Steady Positions", VP = 1 ,ref="DEL-W02-08"}
                },
            enhanced = {
                { gridPos = 9, name = "Retaliating Barrage",         VP = 3 ,ref="DEL-W02-09"},
                { gridPos = 10, name = "Pinpoint Rocket Cannon",      VP = 3 ,ref="DEL-W02-10"},
                { gridPos = 11, name = "Lightpulsar Special Payload", VP = 2 ,ref="DEL-W02-11"},
                { gridPos = 12, name = "Lead Downpour",               VP = 2 ,ref="DEL-W02-12"},
                { gridPos = 13, name = "Logistics",                   VP = 4 ,ref="DEL-W02-13"},
                { gridPos = 14, name = "Auxillary Mana",              VP = 4 ,ref="DEL-W02-14"},
                { gridPos = 15, name = "Maelstrom Formation",         VP = 3 ,ref="DEL-W02-15"},
                { gridPos = 16, name = "Designated Fire Point",       VP = 3 ,ref="DEL-W02-16"}
                }
            }
        },
    },  
    ["Luna-Δ"]    = {
    icon         = gitLink("Characters/Luna_Delta/Luna_Delta_icon.png"),
    sourceGame   = "HacKClaD.DeltA",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Luna_Delta/Luna_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Luna_Delta/Luna_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=40, g=35, b=45}
        },
    figure       = { 
        frontURL   = gitLink("Characters/Luna_Delta/Luna_Delta_figure.png"),
        backURL    = "",
        baseColour = {r=90, g=25, b=175}
        },
    deck = {
        faceURL       = gitLink("Characters/Luna_Delta/Luna_Delta_skillCards.webp"),
        backURL       = gitLink("Characters/Luna_Delta/Luna_Delta_cardBack.png"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shoot",          VP = 1 ,ref="DEL-W03-01"},
                { gridPos = 1, name = "Block",          VP = 1 ,ref="DEL-W03-02"},
                { gridPos = 2, name = "Move",           VP = 1 ,ref="DEL-W03-03"},
                { gridPos = 3, name = "Ruin's Blade",   VP = 1 ,ref="DEL-W03-04"},
                { gridPos = 4, name = "Thunderbolt",    VP = 1 ,ref="DEL-W03-05"},
                { gridPos = 5, name = "Condemn",        VP = 1 ,ref="DEL-W03-06"},
                { gridPos = 6, name = "Tsukuyomi",      VP = 1 ,ref="DEL-W03-07"},
                { gridPos = 7, name = "Chasing Melody", VP = 1 ,ref="DEL-W03-08"}
                },
            enhanced = {
                { gridPos =  9, name = "Thunderstep",           VP = 3 ,ref="DEL-W03-09"},
                { gridPos = 10, name = "Everchanging Magatama", VP = 3 ,ref="DEL-W03-10"},
                { gridPos = 11, name = "Heaven Sword",    VP = 3 ,ref="DEL-W03-11"},
                { gridPos = 12, name = "Takemikazuchi",   VP = 2 ,ref="DEL-W03-12"},
                { gridPos = 13, name = "Mirror of Eight", VP = 4 ,ref="DEL-W03-13"},
                { gridPos = 14, name = "Auxiliary Mana",  VP = 4 ,ref="DEL-W03-14"},
                { gridPos = 15, name = "Soaring Heights", VP = 4 ,ref="DEL-W03-15"},
                { gridPos = 16, name = "Invocation",      VP = 4 ,ref="DEL-W03-16"}
                }
            },
        }, 
    },
    ["Mia-Δ"]     = {
    icon         = gitLink("Characters/Mia_Delta/Mia_Delta_icon.png"),
    sourceGame   = "HacKClaD.DeltA",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Mia_Delta/Mia_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Mia_Delta/Mia_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=45, g=41, b=35}
        },
    figure       = { 
        frontURL   = gitLink("Characters/Mia_Delta/Mia_Delta_figure.png"),
        backURL    = "",
        baseColour = {r=195, g=50, b=0}
        },
    deck = {
        faceURL       = gitLink("Characters/Mia_Delta/Mia_Delta_skillCards.webp"),
        backURL       = gitLink("Characters/Mia_Delta/Mia_Delta_cardBack.png"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shoot",         VP = 1 ,ref="DEL-W04-01"},
                { gridPos = 1, name = "Block",         VP = 1 ,ref="DEL-W04-02"},
                { gridPos = 2, name = "Move",          VP = 1 ,ref="DEL-W04-03"},
                { gridPos = 3, name = "Kunai",         VP = 1 ,ref="DEL-W04-04"},
                { gridPos = 4, name = "Kunai",         VP = 1 ,ref="DEL-W04-05"},
                { gridPos = 5, name = "Shuriken",      VP = 1 ,ref="DEL-W04-06"},
                { gridPos = 6, name = "Summon Trap",   VP = 1 ,ref="DEL-W04-07"},
                { gridPos = 7, name = "Illusory Arts", VP = 1 ,ref="DEL-W04-08"}
                },
            enhanced = {
                { gridPos = 9,  name = "Stealth",          VP = 3 ,ref="DEL-W04-09"},
                { gridPos = 10,  name = "Mawashigeri",     VP = 3 ,ref="DEL-W04-10"},
                { gridPos = 11, name = "Weapon Foraging",  VP = 2 ,ref="DEL-W04-11"},
                { gridPos = 12, name = "Heelstomp",        VP = 3 ,ref="DEL-W04-12"},
                { gridPos = 13, name = "Substitute",       VP = 4 ,ref="DEL-W04-13"},
                { gridPos = 14, name = "Convergence Seal", VP = 3 ,ref="DEL-W04-14"},
                { gridPos = 15, name = "Auxiliary Mana",   VP = 4 ,ref="DEL-W04-15"},
                { gridPos = 16, name = "Tsujigiri",        VP = 3 ,ref="DEL-W04-16"}
                }
            },
        },
    referenceCard = {
        frontURL = gitLink("Characters/Mia_Delta/Mia_Delta_referenceCard.webp"),
        edgeColour = {r=30, g=30, b=30}
        },
    customTokens = {
        {   -- Connibear Trap 1
            frontURL   = gitLink("Characters/Mia_Delta/Connibear_Trap_Token_Front.png"),
            backURL    = gitLink("Characters/Mia_Delta/Connibear_Trap_Token_Back.png"),
            edgeColour = {r=200, g=160, b=100},
            position   = {x=0.4, z=-1.25, rotation=0},
            scale      = 1.0,
            type       = 1, -- Hex shape
            flipped    = true
            },
        {   -- Connibear Trap 2
            frontURL   = gitLink("Characters/Mia_Delta/Connibear_Trap_Token_Front.png"),
            backURL    = gitLink("Characters/Mia_Delta/Connibear_Trap_Token_Back.png"),
            edgeColour = {r=200, g=160, b=100},
            position   = {x=0.75, z=-1.25, rotation=0},
            scale      = 1.0,
            type       = 1, -- Hex shape
            flipped    = true
            }
        }
    },  
    ["Amelia-Δ"]  = {
    icon         = gitLink("Characters/Amelia_Delta/Amelia_Delta_icon.png"),
    sourceGame   = "HacKClaD.DeltA",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Amelia_Delta/Amelia_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Amelia_Delta/Amelia_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=30, g=50, b=50}
        },
    figure       = { 
        frontURL   = gitLink("Characters/Amelia_Delta/Amelia_Delta_figure.png"),
        backURL    = "",
        baseColour = {r=0, g=160, b=190}
        },
    deck = {
        faceURL       = gitLink("Characters/Amelia_Delta/Amelia_Delta_skillCards.webp"),
        backURL       = gitLink("Characters/Amelia_Delta/Amelia_Delta_cardBack.png"),
        imgGridWidth  = 9,
        imgGridHeight = 2,
        cardList      = {
            standard = {
                { gridPos = 0, name = "Shoot",                     VP = 1 ,ref="DEL-W05-01"},
                { gridPos = 1, name = "Block",                     VP = 1 ,ref="DEL-W05-02"},
                { gridPos = 2, name = "Move",                      VP = 1 ,ref="DEL-W05-03"},
                { gridPos = 3, name = "Steelstring Transmutation", VP = 1 ,ref="DEL-W05-04"},
                { gridPos = 4, name = "Tsuchikumo",                VP = 1 ,ref="DEL-W05-05"},
                { gridPos = 5, name = "Activation Protocol",       VP = 1 ,ref="DEL-W05-06"},
                { gridPos = 6, name = "Investigate",               VP = 1 ,ref="DEL-W05-07"},
                { gridPos = 7, name = "Experiment",                VP = 1 ,ref="DEL-W05-08"}
                },
            enhanced = {
                { gridPos = 9,  name = "Electromagnetic Cannon",   VP = 2 ,ref="DEL-W05-09"},
                { gridPos = 10, name = "Auxiliary Mana",           VP = 4 ,ref="DEL-W05-10"},
                { gridPos = 11, name = "Defense Network",          VP = 4 ,ref="DEL-W05-11"},
                { gridPos = 12, name = "Gatling Storm",            VP = 3 ,ref="DEL-W05-12"},
                { gridPos = 13, name = "Multithreaded Operations", VP = 2 ,ref="DEL-W05-13"},
                { gridPos = 14, name = "Deep Delve",               VP = 3 ,ref="DEL-W05-14"},
                { gridPos = 15, name = "Reboot",                   VP = 3 ,ref="DEL-W05-15"},
                { gridPos = 16, name = "Transfiguration",          VP = 2 ,ref="DEL-W05-16"}
                }
            }
        },
    referenceCard = {
        frontURL = gitLink("Characters/Amelia_Delta/Amelia_Delta_referenceCard.webp"),
        edgeColour = {r=30, g=30, b=30}
        },
    customTokens = {
        {   -- Spider Drone 1
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.21, z=-1.14, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 2
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.42, z=-1.14, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 3
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.63, z=-1.14, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 4
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.84, z=-1.14, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 5
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.21, z=-1.39, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 6
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.42, z=-1.39, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 7
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.63, z=-1.39, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            },
        {   -- Spider Drone 8
            frontURL   = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Front.png"),
            backURL    = gitLink("Characters/Amelia_Delta/Tsuchikumo_Token_Back.png"),
            edgeColour = {r=57, g=175, b=203},
            position   = {x=0.84, z=-1.39, rotation=0},
            scale      = 0.6,
            type       = 1, -- Hex
            tags       = {"BoardSpace_Corner"}
            }
        }
    }
}

-- The relative offset for each button position.
-- These are not defined within the characterData table for easier modification and re-use.
-- We only use X and Z because Y is fixed for all buttons!
local positionLayout  = {
    ["Rosette"]   = {x = -3, y = 0, z =  0.5},
    ["Flare"]     = {x = -2, y = 0, z =  0.5},
    ["Luna"]      = {x = -1, y = 0, z =  0.5},
    ["Mia"]       = {x =  0, y = 0, z =  0.5},
    ["Amelia"]    = {x =  1, y = 0, z =  0.5},
    ["Croy"]      = {x =  2, y = 0, z =  0.5},
    ["Lov"]       = {x =  3, y = 0, z =  0.5},
    ["Rosette-Δ"] = {x = -3, y = 0, z = -0.5},
    ["Flare-Δ"]   = {x = -2, y = 0, z = -0.5},
    ["Luna-Δ"]    = {x = -1, y = 0, z = -0.5},
    ["Mia-Δ"]     = {x =  0, y = 0, z = -0.5},
    ["Amelia-Δ"]  = {x =  1, y = 0, z = -0.5},
    
    ["Random_Witch"] = {x =  0, y =  0,   z = -1.5},
    ["Clear_Witch"]  = {x = -5, y = -0.5, z =  4.0},
}
local tokenColours    = {
    Injury = {r=255, g=0,   b=0,   a=230},
    MP     = {r=12,  g=93,  b=200, a=230},
    CP     = {r=195, g=195, b=35,  a=230},
}
local traySizes       = {
    Base = {x = 3.9, z = 2.6},
    Delta = {x = 3.3, z = 3.3}
}
local templateObjects = {
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

--[=[ The Snap Points associated with each player's board.
       - Only the markers associated with the stat will be able to snap to it, reducing accidentally snapping
         to other gauges.
       - A work-around for keeping track of what snap point has what gauge value. This looks hideous in the tags list
         but is the only way to have a snap point carry a string value. These Data-only tags are marked with ~.
       - The "Mark" SnapPoints are not intended to be snapped to, but instead act as reference points to important
         relative positions for the purposes of other scripts, several being exact mirrors of standard snapPoints. This is a dumb workaround for lack of named snappoints.
       - For refernece, Local Position {x=1,z=1} is equivalent to World Position {x=-6.47, z=-4.58} with
         the current board scale.
--]=] 
local boardMarkerSpacing = -0.0553
local boardSnapPoints = {
    Base = {
        stdDeck        = {x=-0.572, z= 0.437, rotation=0},                          -- Standard Deck
        enhDeck        = {x=-0.618, z=-0.568, rotation=270},                        -- Enhanced Deck
        discard        = {x=-1.265, z= 0.437, rotation=0},                          -- Discard Pile
        stdDeckMark    = {x=-0.572, z= 0.437, rotation=0,   tags={"StandardDeck"}},
        enhDeckMark    = {x=-0.618, z=-0.568, rotation=270, tags={"EnhancedDeck"}}, -- Enhanced Deck
        discardMark    = {x=-1.265, z= 0.437, rotation=0,   tags={"Discard"}},
        reformPileMark = {x=-0.618, z=-1.400, rotation=0,   tags={"~Reform"}},
        shardTrayMark  = {x= 0.048, z=-0.635, rotation=0,   tags={"VPTray"}},       -- Magic Shard Tray
        missionCard_1  = {x= 0.010, z=-1.550, rotation=0},                          -- Mission Card 1 area
        missionCard_2  = {x= 0.560, z=-1.550, rotation=0},                          -- Mission Card 2 area
        refCardMark    = {x=-0.346, z= 1.450, rotation=0,   tags={"~RefCard"}},     -- Reference card
        Injury_0 = {x= 0.244 + boardMarkerSpacing * 0, z=-0.1965, rotation=225, tags={"Marker_Injury", "~0"}},
        {x= 0.244 + boardMarkerSpacing * 1, z=-0.1965, rotation=225, tags={"Marker_Injury", "~1"}},
        {x= 0.244 + boardMarkerSpacing * 2, z=-0.1965, rotation=225, tags={"Marker_Injury", "~2"}},
        {x= 0.244 + boardMarkerSpacing * 3, z=-0.1965, rotation=225, tags={"Marker_Injury", "~3"}},
        {x= 0.244 + boardMarkerSpacing * 4, z=-0.1965, rotation=225, tags={"Marker_Injury", "~4"}},
        {x= 0.244 + boardMarkerSpacing * 5, z=-0.1965, rotation=225, tags={"Marker_Injury", "~5"}},
        {x= 0.244 + boardMarkerSpacing * 6, z=-0.1965, rotation=225, tags={"Marker_Injury", "~6"}},
        {x= 0.244 + boardMarkerSpacing * 7, z=-0.1965, rotation=225, tags={"Marker_Injury", "~7"}},
        MP_0 = {x= 0.244 + boardMarkerSpacing * 0, z= 0.035, rotation=225, tags={"Marker_MP", "~0"}},
        {x= 0.244 + boardMarkerSpacing * 1, z= 0.035, rotation=225, tags={"Marker_MP", "~1"}},
        {x= 0.244 + boardMarkerSpacing * 2, z= 0.035, rotation=225, tags={"Marker_MP", "~2"}},
        {x= 0.244 + boardMarkerSpacing * 3, z= 0.035, rotation=225, tags={"Marker_MP", "~3"}},
        {x= 0.244 + boardMarkerSpacing * 4, z= 0.035, rotation=225, tags={"Marker_MP", "~4"}},
        {x= 0.244 + boardMarkerSpacing * 5, z= 0.035, rotation=225, tags={"Marker_MP", "~5"}},
        {x= 0.244 + boardMarkerSpacing * 6, z= 0.035, rotation=225, tags={"Marker_MP", "~6"}},
        {x= 0.244 + boardMarkerSpacing * 7, z= 0.035, rotation=225, tags={"Marker_MP", "~7"}},
        CP_0 = {x= 0.244 + boardMarkerSpacing * 0, z= 0.2511, rotation=225, tags={"Marker_CP", "~0"}},
        {x= 0.244 + boardMarkerSpacing * 1, z= 0.2511, rotation=225, tags={"Marker_CP", "~1"}},
        {x= 0.244 + boardMarkerSpacing * 2, z= 0.2511, rotation=225, tags={"Marker_CP", "~2"}},
        {x= 0.244 + boardMarkerSpacing * 3, z= 0.2511, rotation=225, tags={"Marker_CP", "~3"}},
        {x= 0.244 + boardMarkerSpacing * 4, z= 0.2511, rotation=225, tags={"Marker_CP", "~4"}},
        {x= 0.244 + boardMarkerSpacing * 5, z= 0.2511, rotation=225, tags={"Marker_CP", "~5"}},
        {x= 0.244 + boardMarkerSpacing * 6, z= 0.2511, rotation=225, tags={"Marker_CP", "~6"}},
        {x= 0.244 + boardMarkerSpacing * 7, z= 0.2511, rotation=225, tags={"Marker_CP", "~7"}},
    },
    Delta = {
        stdDeck        = {x=-0.5720, z= 0.437, rotation=0},                          -- Standard Deck
        enhDeck        = {x=-1.2442, z=-0.568, rotation=270},                        -- Enhanced Deck
        discard        = {x=-1.2650, z= 0.437, rotation=0},                          -- Discard Pile
        stdDeckMark    = {x=-0.5720, z= 0.437, rotation=0,   tags={"StandardDeck"}},
        enhDeckMark    = {x=-1.2442, z=-0.568, rotation=270, tags={"EnhancedDeck"}},                
        discardMark    = {x=-1.2650, z= 0.437, rotation=0,   tags={"Discard"}},
        reformPileMark = {x=-0.5720, z=-1.380, rotation=0,   tags={"~Reform"}},
        shardTrayMark  = {x=-0.5720, z=-0.570, rotation=0,   tags={"VPTray"}},       -- Magic Shard Tray
        refCardMark    = {x=-0.3460, z= 1.450, rotation=0,   tags={"~RefCard"}},     -- Reference card
        Injury_0 = {x=0.244 + boardMarkerSpacing * 0, z=-0.83, rotation=225, tags={"Marker_Injury", "~0"}},
        {x=0.244 + boardMarkerSpacing * 1, z=-0.83, rotation=225, tags={"Marker_Injury", "~1"}},
        {x=0.244 + boardMarkerSpacing * 2, z=-0.83, rotation=225, tags={"Marker_Injury", "~2"}},
        {x=0.244 + boardMarkerSpacing * 3, z=-0.83, rotation=225, tags={"Marker_Injury", "~3"}},
        {x=0.244 + boardMarkerSpacing * 4, z=-0.83, rotation=225, tags={"Marker_Injury", "~4"}},
        {x=0.244 + boardMarkerSpacing * 5, z=-0.83, rotation=225, tags={"Marker_Injury", "~5"}},
        {x=0.244 + boardMarkerSpacing * 6, z=-0.83, rotation=225, tags={"Marker_Injury", "~6"}},
        {x=0.244 + boardMarkerSpacing * 7, z=-0.83, rotation=225, tags={"Marker_Injury", "~7"}},
        MP_0 = {x=0.244 + boardMarkerSpacing * 0, z=-0.58, rotation=225, tags={"Marker_MP", "~0"}},
        {x=0.244 + boardMarkerSpacing * 1, z=-0.58, rotation=225, tags={"Marker_MP", "~1"}},
        {x=0.244 + boardMarkerSpacing * 2, z=-0.58, rotation=225, tags={"Marker_MP", "~2"}},
        {x=0.244 + boardMarkerSpacing * 3, z=-0.58, rotation=225, tags={"Marker_MP", "~3"}},
        {x=0.244 + boardMarkerSpacing * 4, z=-0.58, rotation=225, tags={"Marker_MP", "~4"}},
        {x=0.244 + boardMarkerSpacing * 5, z=-0.58, rotation=225, tags={"Marker_MP", "~5"}},
        {x=0.244 + boardMarkerSpacing * 6, z=-0.58, rotation=225, tags={"Marker_MP", "~6"}},
        {x=0.244 + boardMarkerSpacing * 7, z=-0.58, rotation=225, tags={"Marker_MP", "~7"}},
        CP_0 = {x=0.244 + boardMarkerSpacing * 0, z=-0.33, rotation=225, tags={"Marker_CP", "~0"}},
        {x=0.244 + boardMarkerSpacing * 1, z=-0.33, rotation=225, tags={"Marker_CP", "~1"}},
        {x=0.244 + boardMarkerSpacing * 2, z=-0.33, rotation=225, tags={"Marker_CP", "~2"}},
        {x=0.244 + boardMarkerSpacing * 3, z=-0.33, rotation=225, tags={"Marker_CP", "~3"}},
        {x=0.244 + boardMarkerSpacing * 4, z=-0.33, rotation=225, tags={"Marker_CP", "~4"}},
        {x=0.244 + boardMarkerSpacing * 5, z=-0.33, rotation=225, tags={"Marker_CP", "~5"}},
        {x=0.244 + boardMarkerSpacing * 6, z=-0.33, rotation=225, tags={"Marker_CP", "~6"}},
        {x=0.244 + boardMarkerSpacing * 7, z=-0.33, rotation=225, tags={"Marker_CP", "~7"}},
        {x=0.244 + boardMarkerSpacing * 0, z=-0.08, rotation=225, tags={"Marker_CP", "~8"}},
        {x=0.244 + boardMarkerSpacing * 1, z=-0.08, rotation=225, tags={"Marker_CP", "~9"}},
        {x=0.244 + boardMarkerSpacing * 2, z=-0.08, rotation=225, tags={"Marker_CP", "~10"}},
        {x=0.244 + boardMarkerSpacing * 3, z=-0.08, rotation=225, tags={"Marker_CP", "~11"}},
        {x=0.244 + boardMarkerSpacing * 4, z=-0.08, rotation=225, tags={"Marker_CP", "~12"}},
        {x=0.244 + boardMarkerSpacing * 5, z=-0.08, rotation=225, tags={"Marker_CP", "~13"}},
        {x=0.244 + boardMarkerSpacing * 6, z=-0.08, rotation=225, tags={"Marker_CP", "~14"}},
        {x=0.244 + boardMarkerSpacing * 7, z=-0.08, rotation=225, tags={"Marker_CP", "~15"}},
    }
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



-- EVENT TRIGGERS
function onLoad()  
    -- Create the visual layout of buttons.
    setupPlayerBoards()
end



-- BUTTON SETUP FUNCTIONS
-- [→onLoad()]: Sets up the clickable images onto the player boards.
function setupPlayerBoards()
    for _, obj in pairs(getObjectsWithTag("Tool_PlayerBoard")) do
        local assignedPlayer = nil
        for _, tag in pairs(obj.getTags()) do
            if string.find(tag, "PlayerAssigned_") then
                assignedPlayer =  string.sub(tag, 16)
                break
            end
        end
        
        generatePlayerBoard(obj, assignedPlayer)
    end
end

function generatePlayerBoard(boardObj, playerColor)
    generateButtons(boardObj)
end

function generateButtons(boardObj)
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
    for charName, character in pairs(characterData) do
        printDebug('looping through charTable: ' .. tostring(charName))

        table.insert(
            menuTiles,
            createXMLButton({
                boardObj     = boardObj,
                charSelect   = charName,
                gridPosition = positionLayout[charName],
                iconImage    = character.icon,
                tooltip      = (charName .. "\n(" .. character.sourceGame .. ")"),
                })
        )
    end

    -- Random selection buttons
    table.insert(
        menuTiles,
        createXMLButton({
            boardObj     = boardObj,
            charSelect   = "Random",
            gridPosition = positionLayout["Random_Witch"],
            iconImage    = gitLink("UI/RandomWitch.png"),
            tooltip      = "Random Witch",
            })
        )
    -- Clear selection button
    table.insert(
        menuTiles,
        createXMLButton({
            boardObj     = boardObj,
            charSelect   = "Clear",
            gridPosition = positionLayout["Clear_Witch"],
            iconImage    = gitLink("Characters/Cancel/Cancel_charSelect.png"),
            tooltip      = "Clear character board"
            })
        )
    
    -- Add all created tiles to the XML.
    boardObj.UI.setXmlTable(menuTiles)
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
        y = (args.gridPosition.y * 0.1) + 0.1,
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
        characterSelect(obj, args.charSelect)
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



-- PLAYER BOARD COMPONENT SPAWNING FUNCTIONS
function characterSelect(boardObj, character_ID)
    local assignedPlayer = nil
    for _, tag in pairs(boardObj.getTags()) do
        if string.find(tag, "PlayerAssigned_") then
            assignedPlayer =  string.sub(tag, 16)
            break
        end
    end
    
    -- Check for override inputs
    if character_ID == "Random" then
        character_ID = selectRandomWitch()
    elseif character_ID == "Clear" then
        removeAllPlayerOwnedObjects(assignedPlayer)
        updatePlayerCharSetting(assignedPlayer, nil)
        return
    end
    
    spawnCharacterComponents(assignedPlayer, boardObj, character_ID)
    updatePlayerCharSetting(assignedPlayer, character_ID)
end

function updatePlayerCharSetting(playerColor, character_ID)
    local playerData = Global.getTable("playerData")
    playerData[playerColor].charName = character_ID
    if characterData[character_ID] then
        playerData[playerColor].charType = characterData[character_ID].layoutType
    else
        playerData[playerColor].charType = nil
    end
    Global.setTable("playerData", playerData)
end

function spawnCharacterComponents(player, boardObj, character_ID)
        
    local playerPosition = boardObj.getPosition()
    playerPosition.y = playerPosition.y + 0.1
    
    -- Remove current character objects to clear the table.
    printDebug("\nCharacter selected. Despawning player objects.")
    removeAllPlayerOwnedObjects(player)
    
    local charData = characterData[character_ID]
    local layoutType = charData.layoutType
     
     -- Remove current character objects to clear the table.
    printDebug("\nCharacter selected. Despawning player objects.")
    removeAllPlayerOwnedObjects(player)
     
    local objToSpawn = nil
    
    -- Generate and spawn the Player Board (Surface for Cards, Magic Shards, etc.)
    -- All further spawns are now RELATIVE POSITIONED to the board for consistency with Snap Points.
    -- 
    printDebug("Spawning player board. Setting reference to spawned board.")
    objToSpawn = generateBoard(charData.playerBoard, player, charData.layoutType)
    objToSpawn.GMNotes = JSON.encode({charID = character_ID })
    local playerBoard = spawnObjectData({
        data = objToSpawn,
        position = {x=playerPosition.x, y=playerPosition.y, z=playerPosition.z},
        rotation = {x=0, y=180, z=0},
        })
    
    -- Standard Deck (Default 8 cards)
    printDebug("Spawning standard deck.")
    objToSpawn          = generateDeck(charData.deck, "standard", player)
    objToSpawn.Nickname = character_ID
    spawnComponent({
            objData     = objToSpawn,
            playerBoard = playerBoard,
            layoutType  = layoutType,
            snapPoint   = "stdDeck",
            flipped     = true})
    
    -- Enhanced Deck (Upgraded 8 or 10 cards)
    -- Position differs for Delta characters due to a change in board layout.
    printDebug("Spawning enhanced deck.")
    objToSpawn          = generateDeck(charData.deck, "enhanced", player)
    objToSpawn.Nickname = character_ID .. " (Enhanced Deck)"
    spawnComponent({
            objData     = objToSpawn,
            playerBoard = playerBoard,
            layoutType  = layoutType,
            snapPoint   = "enhDeck",
            flipped     = true})
    
    -- Witch Figure and gem tray, the movable player marker.
    printDebug("Spawning figure.")
    spawnComponent({
        objData     = generateObject({
            objType = "Figure",
            player  = player,
            objData = {
                frontURL = charData.figure.frontURL,
                colour   = charData.figure.baseColour,
                name     = character_ID
                }
            }),
        playerBoard = playerBoard,
        layoutType  = layoutType,
        snapPoint   = "shardTrayMark",
        offset      = {rot = 180}
        })
    
    -- Gem tray (invisible).
    -- We lower it manually to be submerged below the board itself.
    -- It is also unable to be interacted with.
    printDebug("Spawning tray.")
    spawnComponent({
        objData      = generateObject({
            objType = "Tray",
            player  = player,
            objData = {scale = traySizes[layoutType]}
            }),
        playerBoard  = playerBoard,
        layoutType   = layoutType,
        snapPoint    = "shardTrayMark",
        offset       = {y = -0.3},
        interactable = false})
    
    -- Stat tokens
    printDebug("Spawning stat tokens.")
    spawnComponent({
        objData = generateObject({
            objType = "Token",
            player  = player,
            objData = {
                colour = tokenColours["Injury"],
                tags   = {"MarkerToken", "Marker_Injury"}
                }
            }),
        playerBoard  = playerBoard,
        layoutType   = layoutType,
        snapPoint    = "Injury_0",
        registered   = true})
    spawnComponent({
        objData = generateObject({
            objType = "Token",
            player  = player,
            objData = {
                colour = tokenColours["MP"],
                tags   = {"MarkerToken", "Marker_MP"}
                }
            }),
        playerBoard  = playerBoard,
        layoutType   = layoutType,
        snapPoint    = "MP_0",
        registered   = true})
    spawnComponent({
        objData = generateObject({
            objType = "Token",
            player  = player,
            objData = {
                colour = tokenColours["CP"],
                tags   = {"MarkerToken", "Marker_CP"}
                }
            }),
        playerBoard  = playerBoard,
        layoutType   = layoutType,
        snapPoint    = "CP_0",
        registered   = true})
    
    -- Mission Marker Cards (Base only)
    if layoutType == "Base" then
        for i = 1,2,1 do
            spawnComponent({
                objData      = generateObject({
                    objType = "MissionMarker",
                    player  = player
                    }),
                playerBoard  = playerBoard,
                layoutType   = layoutType,
                snapPoint    = "missionCard_" .. i,
                offset       = {y = -0.4},
                interactable = false})
        end
    end
    
    -- Reference card (Optional)
    if charData.referenceCard ~= nil then
        printDebug("Spawning reference cards.")
        spawnComponent({
            objData = generateObject({
                    objType = "RefCard",
                    player  = player,
                    objData = {
                        frontURL = charData.referenceCard.frontURL,
                        colour   = charData.referenceCard.edgeColour,
                        }
                    }),
            playerBoard = playerBoard,
            layoutType = layoutType,
            snapPoint = "refCardMark"})
    end
    
    -- Custom Tiles (Optional)
    if charData.customTokens ~= nil then
        printDebug("Spawning custom tokens.")
        for _, tile in ipairs(charData.customTokens) do
            spawnComponent({
                objData     = generateObject({
                    objType = "CustomTile",
                    player  = player,
                    objData = {
                        frontURL      = tile.frontURL,
                        backURL       = tile.backURL,
                        colour        = tile.edgeColour,
                        scale         = {x = tile.scale, z = tile.scale},
                        tileType      = tile.type,
                        tileThickness = tile.thickness,
                        tags          = tile.tags
                        }
                    }),
                playerBoard = playerBoard,
                offset      = {x=tile.position.x, z=tile.position.z, rotation=tile.position.rotation},
                flipped     = tile.flipped})
        end
    end
    
end
-- Randomly selects a vaid Witch name with any of the defined characters listed in characterData.
function selectRandomWitch()
    -- Get a list of all available characters.
    local allCharacters = {}
    for charName, _ in pairs(characterData) do
        table.insert(allCharacters, charName)
    end
    
    -- Randomly pick an entry from the list.
    -- math.random() here selects an integer from 1 to the length of the list.
    -- This happens to be all possible indexes of the list.
    return allCharacters[math.random(#allCharacters)]
end
-- Find all objects owned by a player and deletes them. (Only affects objects with the correct tag!)
function removeAllPlayerOwnedObjects(player)
    for _, object in ipairs(getObjectsWithTag("PlayerOwned_" .. player)) do
        object.Destruct()
    end
end



-- OBJECT CREATION FUNCTIONS
-- Each function handles different object types to create.
-- Due to the rather bespoke nature of each type they've been split across multiple functions.
function spawnComponent(arg)
        -- Define values
        local objData           = arg.objData
        local playerBoard       = arg.playerBoard
        local snapPoint         = arg.layoutType and arg.snapPoint and boardSnapPoints[arg.layoutType][arg.snapPoint]
                                  or {x=0, z=0, rotation=0}
        local offset            = {x        = arg.offset and arg.offset.x   or 0,
                                   y        = arg.offset and arg.offset.y   or 0,
                                   z        = arg.offset and arg.offset.z   or 0,
                                   rotation = arg.offset and arg.offset.rot or 0}
        local flipped           = arg.flipped      or false
        local registered        = arg.registered   or false
        local interactable      = arg.interactable or true
        if objData == nil or playerBoard == nil then error("Invalid spawnComponent command.") return end
        
        printDebug("Given board: " .. playerBoard.getGUID())
        local boardRotation = playerBoard.getRotation()
        printDebug("Board rotation: " .. boardRotation.x .. ", " .. boardRotation.y .. ", " .. boardRotation.z .. ", ")

        local spawnPosition = playerBoard.positionToWorld({
            x = snapPoint.x + offset.x,
            y = offset.y + 0.3,
            z = snapPoint.z + offset.z
        })
        
        local spawnRotation = {
            x = boardRotation.x + 0,
            y = boardRotation.y + snapPoint.rotation + offset.rotation,
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
-- Decks take on an entirely different form to all other objects, and so have to be generated through a secondary function.
function generateDeck(deckData, deckType, player)
    local outputObject = generateObject({
            objType = "Deck",
            player  = player
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
            GMNotes  =  [[{"VPC":"]] .. card.VP .. [["}]],
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
    
    if player ~= nil then
        for i, card in ipairs(outputObject.ContainedObjects) do
            card.Tags = {"PlayerOwned_" .. player}
        end
    end
    
    return outputObject
end
-- Due to a rather large of unique requirements to construct, player boards are generated in an abstracting function.
function generateBoard(boardData, player, boardType)
    local outputObject = generateObject({
            objType = "Board",
            player  = player,
            objData = {
                frontURL = boardData.frontURL,
                backURL  = boardData.backURL,
                colour   = boardData.edgeColour,
                tags     = {"PlayerComponent_CharacterBoard"}
                }
            })
    
    outputObject.Locked   = true
    
    -- Add all default Snap Points
    for key, snapPoint in pairs(boardSnapPoints[boardType]) do
        table.insert(outputObject.AttachedSnapPoints, {
            Position = {
                x = snapPoint.x,
                y = 0.40,
                z = snapPoint.z
                },
            Rotation = {
                x = 0,
                y = snapPoint.rotation,
                z = 0
                },
            Tags = snapPoint.tags -- This is creating a reference to the original table values. DO NOT MODIFY THIS LATER!
            })
    end
    
    -- Add any additional Snap Points
    if boardData.additionalSnapPoints ~= nil then
        for key, snapPoint in pairs(boardData.additionalSnapPoints) do
        table.insert(outputObject.AttachedSnapPoints, {
            Position = {
                x = snapPoint.x,
                y = 0.40,
                z = snapPoint.z
                },
            Rotation = {
                x = 0,
                y = snapPoint.rotation,
                z = 0
                },
            Tags = snapPoint.tags
            })
    end
    end
    
    return outputObject
end

