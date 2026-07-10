function gitLink(fileDirectory)
    return Global.call("gitLink", fileDirectory)
end

local btnScale  = 130
local btnMargin = 0

local btnSpacing           = (1 / 490) + ( (btnScale/490) * (btnMargin/100))
local luaToXmlRatioPos     = 100
local luaToXmlRatioBtnSize = 0.204

local btnTransparency = 0

local gameModeToggle = "Default"
local dealMissionBusy = false
local spawnCladBusy = false

local messageColors = Global.getTable("messageColors")

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
    icon         = "https://hackclad.wiki.gg/images/Rosette_Icon.png",
    layoutType   = "Base",
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Rosette_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Flare_Icon.png",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Flare/Flare_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=199, g=206, b=120}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Flare_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Luna_Icon.png",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Luna/Luna_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=151, g=122, b=200}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Luna_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Mia_Icon.png",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Mia/Mia_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=144, g=156, b=130}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Mia_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Amelia_Icon.png",
    layoutType   = "Base",
    playerBoard  = {
        frontURL = gitLink("Characters/Amelia/Amelia_playerBoard.png"),
        backURL  = "",
        edgeColour = {r=117, g=169, b=199}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Amelia_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Croy_Icon.png",
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
        frontURL   = "https://hackclad.wiki.gg/images/Croy_Portrait.png",
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
    icon         = "https://hackclad.wiki.gg/images/Lov_Icon.png",
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
        frontURL   = "https://hackclad.wiki.gg/images/Lov_Portrait.png",
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
    ["Rosette-?"] = {
    icon         = "https://hackclad.wiki.gg/images/Rosette_Delta_Icon.png",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Rosette_Delta/Rosette_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Rosette_Delta/Rosette_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=45, g=41, b=41}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Rosette_Delta_Portrait.png",
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
    ["Flare-?"]   = {
    icon         = "https://hackclad.wiki.gg/images/Flare_Delta_Icon.png",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Flare_Delta/Flare_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Flare_Delta/Flare_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=40, g=45, b=40}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Flare_Delta_Portrait.png",
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
    ["Luna-?"]    = {
    icon         = "https://hackclad.wiki.gg/images/Luna_Delta_Icon.png",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Luna_Delta/Luna_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Luna_Delta/Luna_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=40, g=35, b=45}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Luna_Delta_Portrait.png",
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
    ["Mia-?"]     = {
    icon         = "https://hackclad.wiki.gg/images/Mia_Delta_Icon.png",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Mia_Delta/Mia_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Mia_Delta/Mia_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=45, g=41, b=35}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Mia_Delta_Portrait.png",
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
    ["Amelia-?"]  = {
    icon         = "https://hackclad.wiki.gg/images/Amelia_Delta_Icon.png",
    layoutType   = "Delta",
    playerBoard  = {
        frontURL = gitLink("Characters/Amelia_Delta/Amelia_Delta_playerBoard.webp"),
        backURL  = gitLink("Characters/Amelia_Delta/Amelia_Delta_playerBoardBack.jpeg"),
        edgeColour = {r=30, g=50, b=50}
        },
    figure       = { 
        frontURL   = "https://hackclad.wiki.gg/images/Amelia_Delta_Portrait.png",
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
    icon = "https://hackclad.wiki.gg/images/thumb/Shell_Clad_Icon.png/80px-Shell_Clad_Icon.png",
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
    icon = "https://hackclad.wiki.gg/images/thumb/Hydra_Clad_Icon.png/80px-Hydra_Clad_Icon.png",
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
    ["Wyrm Clad (Extra Deck)"] = {
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
    ["Shell Clad (Extra Deck)"] = {
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

--[=[ The stored data for Mission Cards.
]=]
local missionData = {
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

-- The relative offset for each button position.
-- These are not defined within the characterData table for easier modification and re-use.
-- We only use X and Z because Y is fixed for all buttons!
local positionLayout  = {
    ["Mission_Dropdown"]  = {x = 1,   z = 2},
    ["Setup_PlayerOrder"] = {x = -2,   z = 3},
    ["Setup_NinethCard"] = {x = 0,   z = 3},
    ["Setup_MissionDeal"] = {x = 2,   z = 3},
    ["Board_Disable"]     = {x = 6,   z = 3},
    ["Board_Enable"]      = {x = 6,   z = 3},
    
    ["Gamemode_Default"] = {x = -2, z = -3},
    ["Gamemode_Coop"]    = {x = 1, z = -3},
    
    ["Rosette"]   = {x = 1,   z = 1.5},
    ["Flare"]     = {x = 2,   z = 1.5},
    ["Luna"]      = {x = 3,    z = 1.5},
    ["Mia"]       = {x = 4,    z = 1.5},
    ["Amelia"]    = {x = 5,    z = 1.5},
    ["Croy"]      = {x = 2.5, z = 0.5},
    ["Lov"]       = {x = 3.5,  z = 0.5},
    ["Rosette-?"] = {x = 1,   z = -0.5},
    ["Flare-?"]   = {x = 2,   z = -0.5},
    ["Luna-?"]    = {x = 3,    z = -0.5},
    ["Mia-?"]     = {x = 4,    z = -0.5},
    ["Amelia-?"]  = {x = 5,    z = -0.5},
    
    ["Random_Witch"]    = {x = 2.5, z = -1.5},
    ["Clear_Witch"]     = {x = 3.5,  z = -1.5},
    ["Random_Clad"]    = {x = -3.5, z = -1.5},
    ["Clear_Clad"]     = {x = -2.5, z = -1.5},
    
    ["Wyrm Clad"] = {x = -4, z = 1},
    ["Shell Clad"] = {x = -3, z = 1},
    ["Hydra Clad"] = {x = -2, z = 1},
    ["Wyrm Clad (Expert)"] = {x = -4, z = 0},
    ["Wyrm Clad (Extra Deck)"] = {x = -3, z = 0},
    ["Shell Clad (Extra Deck)"] = {x = -2, z = 0},
}
local xmlSwitchImages = {
    modeDefault = {
        enabled  = gitLink("/UI/Gamemode_Default_Enabled.png"),
        disabled = gitLink("/UI/Gamemode_Default_Disabled.png"),
        },
    modeCoop = {
        enabled  = gitLink("/UI/Gamemode_Coop_Enabled.png"),
        disabled = gitLink("/UI/Gamemode_Coop_Disabled.png"),
        },
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
local entryPointPositions = {
    A = {x = 2, y = 1},
    B = {x = 5, y = 2},
    C = {x = 4, y = 5},
    D = {x = 1, y = 4},
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

local templateDeck          = {
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
}
local templateBoard         = {
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
}
local templateFigure        = {
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
}
local templateToken         = {
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
}
local templateRefCard       = {
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
}
local templateCustomTile    = {
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
}
local templateTray          = {
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
}
local templateMissionMarker = {
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

function getPlayerCharacter(player)
    local playerBoard = Global.call("getPlayerBoard", player)
    if playerBoard == nil then return nil end
    
    local boardGMNotes = JSON.decode(playerBoard.getGMNotes())
    local charName = boardGMNotes and boardGMNotes.charID or nil
    
    return charName
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


-- Setting up XML buttons.
function onLoad()  
    -- Create the visual layout of buttons.
    generateButtons()
end

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
    for charName, character in pairs(characterData) do
        printDebug('looping through charTable: ' .. tostring(charName))

        table.insert(
            menuTiles,
            createXMLButton("characterSelect_" .. charName,
                positionLayout[charName],
                character.icon,
                charName)
            )
        
        -- Wrapper function to allow buttons to pass arguments
        -- I hate TTS sometimes oh my god.
        local btnFunction = function(obj, player, alt_click)
            characterSelect(player, charName)
        end
        
        _G["onClick_" .. "characterSelect_" .. charName] = btnFunction
    end

    -- Clad buttons
    for charName, clad in pairs(cladData) do
        printDebug('looping through clad Data table: ' .. tostring(charName))
        table.insert(
            menuTiles,
            createXMLButton("cladSelect_" .. charName,
                positionLayout[charName],
                clad.icon,
                charName)
            )

        local btnFunction = function(obj, player, alt_click)
            cladSelect(player, charName)
        end
        
        _G["onClick_" .. "cladSelect_" .. charName] = btnFunction
    end


    -- Random Selection Buttons
    table.insert(
        menuTiles,
        createXMLButton("Random_Witch",
            positionLayout["Random_Witch"],
            gitLink("UI/RandomWitch.png"),
            "Random Witch")
        )
    table.insert(
        menuTiles,
        createXMLButton("Random_Clad",
            positionLayout["Random_Clad"],
            gitLink("UI/RandomClad.png"),
            "Random Clad")
        )
    
    -- Clear Buttons
    table.insert(
        menuTiles,
        createXMLButton("Clear_Witch",
            positionLayout["Clear_Witch"],
            gitLink("Characters/Cancel/Cancel_charSelect.png"),
            "Clear character board")
        )
    table.insert(
        menuTiles,
        createXMLButton("Clear_Clad",
            positionLayout["Clear_Clad"],
            gitLink("Characters/Cancel/Cancel_charSelect.png"),
            "Clear Clad decks")
        )
    
    -- Player Order Button
    table.insert(
        menuTiles,
        createXMLButton("PlayerOrder",
            positionLayout["Setup_PlayerOrder"],
            gitLink("/Table/PlayerRandom.png"),
            "Setup random player order")
        )
    
    -- 9th Card Button
    table.insert(
        menuTiles,
        createXMLButton("NinethCard",
            positionLayout["Setup_NinethCard"],
            "https://hackclad.wiki.gg/images/HacKClaD_Attack_Magic_Icon.png",
            "Setup players' first Enhanced card (9th card)")
        )
    
    -- Mission Button
    table.insert(
        menuTiles,
        createXMLButton("MissionDeal",
            positionLayout["Setup_MissionDeal"],
            gitLink("/UI/MissionShard.png"),
            "Setup Mission cards")
        )
    
    -- GAME MODE BUTTONS
    table.insert(
        menuTiles,
        createXMLButtonWide("Mode_Default",
            positionLayout["Gamemode_Default"],
            xmlSwitchImages.modeDefault.enabled,
            "Standard Game Mode")
        )
    table.insert(
        menuTiles,
        createXMLButtonWide("Mode_Coop",
            positionLayout["Gamemode_Coop"],
            xmlSwitchImages.modeCoop.disabled,
            "Cooperation Mode")
        )
    
    -- DISABLE/ENABLE BUTTONS
    table.insert(
        menuTiles,
        createXMLButton("Board_Disable",
            positionLayout["Board_Disable"],
            "https://hackclad.wiki.gg/images/HacKClaD_Reaction_Icon.png",
            "Lock the board to disable buttons.")
        )
    local buttonBoardEnable = createXMLButton("Board_Enable",
            positionLayout["Board_Enable"],
            "https://hackclad.wiki.gg/images/HacKClaD_Reaction_Icon.png",
            "Re-enable setup board.",
            false)
    buttonBoardEnable.attributes.scale = "0 0 0"
    table.insert(
        menuTiles,
        buttonBoardEnable
        )
    
    
    -- Add all created tiles to the XML.
    self.UI.setXmlTable(menuTiles)
end

-- Creates a TTS Button element and returns an XML table for an image lined up with the button.
-- We return the element so we can combine the button tables into one table to generate the final XML.
function createXMLButton(selectionID, gridPosition, iconImage, tooltip, initActive)
    -- We receive the grid-based position and scale it according to the button sizes.
    -- We do not use the Y position as all buttons are kept on the same height.
    local placementPosition = {
        x = gridPosition.x * btnScale,
        y = 0.80,
        z = gridPosition.z * btnScale,
    }

    --[=[ Generate the XML image.
          A LOT of garbage math because the Lua buttons and XML images do not use the same scales.
          In-game the buttons may appear slightly smaller, this is because TTS has a small, invisible,
          FIXED SIZE padding around the buttons. This scales the image to the clickable size of the button
          as opposed to the visible size. --]=]
    local XMLTile = {
        tag = "Image",
        attributes = {
            id            = selectionID,
            image         = iconImage or "",
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
        clickFunction = 'onClick_' .. selectionID,
        color         = {0.2, 1, 1, btnTransparency},
        position      = gridPosition,
        tooltip       = tooltip,
        active        = initActive
        })
    
    return XMLTile
end

function createXMLButtonWide(selectionID, gridPosition, iconImage, tooltip)

    -- We move it across by half a space to ensure the left edge aligns as expected rather than centred.
    gridPosition.x = gridPosition.x + 0.5

    -- We receive the grid-based position and scale it according to the button sizes.
    -- We do not use the Y position as all buttons are kept on the same height.
    local placementPosition = {
        x = gridPosition.x * btnScale,
        y = 0.80,
        z = gridPosition.z * btnScale,
    }

    --[=[ Generate the XML image.
          A LOT of garbage math because the Lua buttons and XML images do not use the same scales.
          In-game the buttons may appear slightly smaller, this is because TTS has a small, invisible,
          FIXED SIZE padding around the buttons. This scales the image to the clickable size of the button
          as opposed to the visible size. --]=]
    local XMLTile = {
        tag = "Image",
        attributes = {
            id            = selectionID,
            image         = iconImage or "",
            active        = true,
            height        = btnScale*luaToXmlRatioBtnSize,
            width         = btnScale*luaToXmlRatioBtnSize*2, -- Double Width
            position      =
                (placementPosition.x) * luaToXmlRatioPos * btnSpacing * -1 .. " " ..
                placementPosition.z * luaToXmlRatioPos * btnSpacing * -1 .. " " .. 
                (placementPosition.y * luaToXmlRatioPos * -1) + -1, -- Negative because XML images are stupid; and a tiny bit above to maybe fix the stupid rendering.
            rotation      = "0 0 180", -- The entire thing is upside down because the XML buttons just RENDER THAT WAY I GUESS.
            raycastTarget = false,
            visibility    = "Red|Blue|Yellow|Green|Orange|Purple|White|Teal|Pink|Brown|Black|Grey"
      }}
    
    createGridButton({
        clickFunction = 'onClick_' .. selectionID,
        color         = {0.2, 1, 1, btnTransparency},
        position      = gridPosition,
        tooltip       = tooltip,
        width         = 2 -- Double width
        })
    
    return XMLTile
end


function createGridButton(args)
    self.createButton({
        label          = args.label,
        font_size      = args.fontSize or 50,
        click_function = args.clickFunction,
        function_owner = self,
        width          = btnScale * (args.width or 1),
        height         = btnScale * (args.height or 1),
        color          = args.color or {1, 1, 1, 1},
        position       = {
            x =  (args.position.x or 0) * btnScale * btnSpacing, -- NOT Negative because buttons are exceeding stupid
            y =  (args.position.y or 0.8),
            z =  (args.position.z or 0) * btnScale * btnSpacing * -1,
        },
        tooltip        = args.tooltip or "",
        scale          = args.active == false and {x=0, y=0, z=0} or {x=1, y=1, z=1},
    })
end


function onClick_Board_Disable(obj, player)
    xmlTable = self.UI.getXmlTable()
    for _, tag in ipairs(xmlTable) do
        if tag.attributes.id ~= "Board_Enable" then
            tag.attributes.scale = "0 0 0"
        else
            tag.attributes.scale = "1 1 1"
        end
    end
    self.UI.setXmlTable(xmlTable)
    
    for _, button in ipairs(self.getButtons()) do
        self.editButton({
            index = button.index,
            scale = button.click_function ~= "onClick_Board_Enable" and {x=0, y=0, z=0} or {x=1, y=1, z=1}
            })
    end
end

function onClick_Board_Enable(obj, player)
    xmlTable = self.UI.getXmlTable()
    for _, tag in ipairs(xmlTable) do
        if tag.attributes.id ~= "Board_Enable" then
            tag.attributes.scale = "1 1 1"
        else
            tag.attributes.scale = "0 0 0"
        end
    end
    self.UI.setXmlTable(xmlTable)
    
    for _, button in ipairs(self.getButtons()) do
        self.editButton({
            index = button.index,
            scale = button.click_function ~= "onClick_Board_Enable" and {x=1, y=1, z=1} or {x=0, y=0, z=0}
            })
    end
end


function onClick_NinethCard(obj, player)
    local playerData = Global.getTable("playerData")
    local seated  = getSeatedPlayers()
    local enhancePlayers = {}
    for _, player in ipairs(seated) do
        -- If the player has a designated playing zone. Other seated players are irrelevant.
        if playerData[player] and playerData[player].boardZoneGUID ~= nil then
            table.insert(enhancePlayers, player)
            if getPlayerCharacter(player) == nil then
                printToAll("One or more players has no valid character selected.", messageColors.Error)
                return false
            end
        end
    end
    
    Global.call("startDeckEnhance", enhancePlayers)
end

-- Randomly performs a characterSelect() with any of the defined characters listed in characterData.
function onClick_Random_Witch(obj, player)
    -- Get a list of all available characters.
    local allCharacters = {}
    for charName, _ in pairs(characterData) do
        table.insert(allCharacters, charName)
    end
    
    -- Randomly pick an entry from the list.
    -- math.random() here selects an integer from 1 to the length of the list.
    -- This happens to be all possible indexes of the list.
    local chosenCharacter = allCharacters[math.random(#allCharacters)]

    -- Select the desired character.
    characterSelect(player, chosenCharacter)
end

function onClick_Random_Clad(obj, player)
    -- Get a list of all available characters.
    local allClad = {}
    for charName, _ in pairs(cladData) do
        table.insert(allClad, charName)
    end
    
    -- Randomly pick an entry from the list.
    -- math.random() here selects an integer from 1 to the length of the list.
    -- This happens to be all possible indexes of the list.
    local chosenClad = allClad[math.random(#allClad)]

    -- Select the desired character.
    cladSelect(player, chosenClad)
end


function onClick_Clear_Witch(obj, player)
    removeAllPlayerOwnedObjects(player)
end

function onClick_Clear_Clad(obj, player)
    removeAllPlayerOwnedObjects("Clad")
end

function onClick_PlayerOrder(obj, player)
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
        Wait.time(function()
            local witchFigure = getPlayerFigure(player)
            local placementPosition = Global.call("findArenaPositionByGrid", entryPointPositions[entryAssignment[i]])
            witchFigure.setPositionSmooth(placementPosition)
            witchFigure.setRotation({x=0, y=0, z=0})
            end,
            0.4*i, 1)
    end
end

function onClick_Mode_Default(obj, player)
    printToAll("Game Mode: Standard", messageColors.Default)
    gameModeToggle = "Default"
    
    xmlTable = self.UI.getXmlTable()
    for _, tag in ipairs(xmlTable) do
        if tag.attributes.id == "Mode_Default" then
            tag.attributes.image = xmlSwitchImages.modeDefault.enabled
        elseif tag.attributes.id == "Mode_Coop" then
            tag.attributes.image = xmlSwitchImages.modeCoop.disabled
        end
    end
    
    self.UI.setXmlTable(xmlTable)
end

function onClick_Mode_Coop(obj, player)
    printToAll("Game Mode: Cooperation Mode", messageColors.Default)
    gameModeToggle = "Coop"
    
    xmlTable = self.UI.getXmlTable()
    for _, tag in ipairs(xmlTable) do
        if tag.attributes.id == "Mode_Default" then
            tag.attributes.image = xmlSwitchImages.modeDefault.disabled
        elseif tag.attributes.id == "Mode_Coop" then
            tag.attributes.image = xmlSwitchImages.modeCoop.enabled
        end
    end
    
    self.UI.setXmlTable(xmlTable)
end

function onClick_MissionDeal(obj, btnPlayer)
    if dealMissionBusy then return false end
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
    local modeType = "Base"
    local numPlayers = 0
    for playerColor, playerData in pairs(Global.getTable("playerData")) do
        if Player[playerColor].seated == true then
            numPlayers = numPlayers + 1
            charName = getPlayerCharacter(playerColor)
            if charName == nil then
                printToAll("One or more players has no valid character selected.", messageColors.Error)
                return false
            elseif characterData[charName].layoutType == "Delta" then
                modeType = "Delta"
            end
        end
    end
    if numPlayers == 1 then modeType = "Solo" end
    
    
    printToAll("Dealing Mission Cards.", messageColors.Default)
    local missionDeck = spawnObjectData({
        data = generateMissionDeck(missionData),
        position = {x=-20, y=0.25, z=25},
        rotation = {x=0, y=180, z=0}
    })
    missionDeck.addTag("PlayerComponent_MissionCard") -- For some reason this can't be set in the generateObject data???
    missionDeck.shuffle()

    -- Delay dealing for visual confirmation.
    -- Also helps reduce effect of spamming the button.
    dealMissionBusy = true
    Wait.time(
        function()
            -- Under Delta and Coop rules, deal to each mission char.
            if modeType == "Delta" or modeType == "Solo" or gameModeToggle == "Coop" then
                -- Delay re-enabling until the cards have likely reach player's hands.
                Wait.time(
                    function()
                        dealMissionBusy = false
                    end,
                    0.8, 1)
            
                for playerColor, playerData in pairs(Global.getTable("playerData")) do
                    if Player[playerColor].seated == true then
                        charName = getPlayerCharacter(playerColor)
                        if characterData[charName].layoutType == "Base" then
                        
                            local dealCount = ((modeType       == "Solo")    and 2) or
                                              ((gameModeToggle == "Default") and 5) or
                                              ((gameModeToggle == "Coop")    and 2) or
                                              1
                            for i=1,dealCount do 
                                local dealtCard = missionDeck.takeObject()
                                dealtCard.addTag("PlayerOwned_" .. playerColor)
                                dealtCard.deal(1, playerColor, 1)
                            end
                        end
                    end
                end
            else -- Under Base Game rules, community pool.
            
                -- Delay re-enabling until all the cards have had time to be dealt.
                Wait.time(
                    function()
                        dealMissionBusy = false
                    end,
                    2, 1)
            
                -- Loop through dealing out each community card individually.
                for i=1,10 do
                    local basePosition = self.getPosition()
                    basePosition = {
                        x = basePosition.x + (poolGrid[i].x * 3.5),
                        y = 0.5,
                        z = basePosition.z - 10 + (poolGrid[i].z * 5),
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

function UI_onValueChanged_missionSelectDrop(player, selectedIndex, id)
    print(selectedIndex)
end

-- Find all objects assigned to a player and deletes them.
-- This only affects objects spawned via this script, other objects will not have this tag!
function removeAllPlayerOwnedObjects(player)
    for _, object in ipairs(getObjectsWithTag("PlayerOwned_" .. player)) do
        object.Destruct()
    end
end




function characterSelect(player, character_ID)
    local playerPositionsTable = Global.getVar("playerPositions") or {}
    local playerPosition = playerPositionsTable[player]
    local charData = characterData[character_ID]
    local layoutType = charData.layoutType
    
    
    -- Check the player has a valid seat on the table. If not, let them know they made an error!
    if playerPositionsTable[player] == nil then
        broadcastToColor([[Lov Says: "Please sit at a valid seat before selecting a character!"]], player, {r=0.5, g=0.1, b=0.8})
        return
    end
    
    printDebug("\nCharacter selected. Despawning player objects.")
    
    -- Remove current character objects to clear the table.
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

function cladSelect(player, clad_ID)
    -- Do not spawn a new clad while it's busy spawning one in.
    if spawnCladBusy then return end
    
    local turnBoard = Global.getVar("turnBoard")
    
    local deckPositions = {
        voltage1 = getBoardSnapPointPosition(turnBoard, "~Deck"),
        voltage2 = getBoardSnapPointPosition(turnBoard, "~Voltage2"),
        voltage3 = getBoardSnapPointPosition(turnBoard, "~Voltage3"),
        }
        
    removeAllPlayerOwnedObjects("Clad")

    local cladDeckVoltage1 = spawnCladDeck({
        objData   = generateCladDeck(cladData[clad_ID].deck, "voltage1"),
        snapPoint = "~Deck",
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
        
    if gameModeToggle == "Default" then
        -- Shuffle the Voltage 1 deck
        spawnCladBusy = true
        Wait.time(function()
            cladDeckVoltage1.shuffle()
            end,
            0.2, 1)
        Wait.time(function()
            spawnCladBusy = false
            end,
            0.3, 1)
            
    elseif gameModeToggle == "Coop" then        
        spawnCladBusy = true
        
        -- Move the Voltage 2 deck into the Voltage 1 deck.
        Wait.time(function()
            cladDeckVoltage1.putObject(cladDeckVoltage2)
            end,
            0.2, 1)
        
        -- Shuffle the Voltage 1 deck
        Wait.time(function()
            cladDeckVoltage1.shuffle()
            end,
            0.7, 1)
        
        -- Move 3 cards into the Voltage 3 deck
        Wait.time(function()
            Wait.time(function()
                cladDeckVoltage3 = cladDeckVoltage3.putObject(cladDeckVoltage1.takeObject())
                end,
                0.1, 3)   
            end,
            1.2, 1)
        
        -- Shuffle the Voltage 3 deck.
        Wait.time(function()
            cladDeckVoltage3.shuffle()
            end,
            2.1, 1) 
    
        -- Move 3 cards back into the Voltage 2 deck.
        Wait.time(function()
            Wait.time(function()
                local newCard = cladDeckVoltage3.takeObject()
                newCard.setPositionSmooth({
                    x = deckPositions.voltage2.x,
                    y = deckPositions.voltage2.y + 0.25,
                    z = deckPositions.voltage2.z
                })
                end,
                0.1, 3) -- Repeat 2 times total.
            end,
            2.6, 1)
            
        -- Setup complete, re-enable controls.
        Wait.time(function()
            spawnCladBusy = false
            end,
            3.0, 1) 
    end
end

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

