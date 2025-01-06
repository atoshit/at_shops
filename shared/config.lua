Config = {}

--[[ 
    Configuration des catégories et articles disponibles dans les supérettes
    Structure:
    - Chaque catégorie est une table avec un nom unique (food, drinks, etc.)
    - Chaque article doit avoir:
        - id: identifiant unique correspondant à l'item dans l'inventaire
        - label: nom affiché dans le menu
        - price: prix de vente
        - icon: icône FontAwesome (sans le "fa-")
        - description: description détaillée de l'item
]]
Config.Items = {
    -- Catégorie Nourriture
    food = {
        {
            id = "bread", -- ID de l'item (DOIT correspondre à l'ID dans votre inventaire)
            label = "Pain", -- Nom affiché dans le menu
            price = 1, -- Prix en dollars
            icon = "fa-bread-slice", -- Icône FontAwesome (la liste complète: https://fontawesome.com/icons)
            description = "Du pain frais" -- Description affichée au survol
        }
    },

    -- Catégorie Boissons
    drinks = {
        {
            id = "cola",
            label = "Cola",
            price = 2,
            icon = "fa-bottle-droplet",
            description = "Une boisson rafraîchissante"
        },
        {
            id = "water",
            label = "Eau",
            price = 1,
            icon = "fa-bottle-water",
            description = "Bouteille d'eau"
        },
    },

    -- Catégorie Électronique
    electronics = {
        {
            id = "phone",
            label = "Téléphone",
            price = 750,
            icon = "fa-mobile-screen",
            description = "Un téléphone portable"
        },
        {
            id = "radio",
            label = "Radio",
            price = 250,
            icon = "fa-walkie-talkie",
            description = "Une radio portable"
        },
    },

    -- Catégorie Outils
    tools = {
        {
            id = "weapon_hammer",
            label = "Marteau",
            price = 500,
            icon = "fa-hammer",
            description = "Un marteau"
        }
    }
}

--[[
    Configuration des catégories disponibles dans les supérettes
    Structure:
    - Chaque catégorie est une table avec un nom unique (food, drinks, etc.)
    - Chaque catégorie doit avoir:
        - id: identifiant unique correspondant à la catégorie
        - label: nom affiché dans le menu
        - icon: icône FontAwesome (sans le "fa-")
        - small: si true, la catégorie sera affiché en petit
        - locked: si true, la catégorie sera verrouillé et ne pourra pas être acheté
]]
Config.Categories = {
    {
        id = "food",
        label = "Nourriture",
        icon = "fa-burger",
        small = false,
        locked = false
    },
    {
        id = "drinks",
        label = "Boissons",
        icon = "fa-bottle-water",
        small = false,
        locked = false
    },
    {
        id = "electronics",
        label = "Électronique",
        icon = "fa-mobile-screen",
        small = false,
        locked = false
    },
    {
        id = "tools",
        label = "Outils",
        icon = "fa-hammer",
        small = true,
        locked = true
    },
    {
        id = "misc",
        label = "Divers",
        icon = "fa-question",
        small = true,
        locked = false
    }
    
}

-- Configuration des textes de l'interface
Config.Text = {
    title = "Supérette",
    searchPlaceholder = "RECHERCHER UN ARTICLE"
}

-- Configuration des icônes
Config.Icons = {
    cartAdd = "fa-cart-plus",
    lock = "fa-lock"
}

-- Configuration des couleurs et du style
Config.Colors = {
    primary = "rgb(0, 150, 136)",
    primaryGradient = "rgb(0, 121, 107)",
    background = "rgba(32, 32, 32, 0.95)",
    categoryBg = "rgb(45, 45, 45)",
    categoryHover = "rgb(55, 55, 55)",
    text = "white",
    locked = "rgba(32, 32, 32, 0.5)",
    lockedText = "rgba(255, 255, 255, 0.5)"
}

Config.Style = {
    borderRadius = "8px",
    buttonRadius = "4px",
    fontSize = {
        small = "12px",
        text = "13px",
        notification = "14px"
    },
    spacing = {
        notificationPadding = "12px 15px"
    }
}

Config.Position = "top-right"

--[[
    Configuration des emplacements des supérettes
    - pos: coordonnées de la supérette (x, y, z)
    - blip: configuration du point sur la carte
        - sprite: icône du blip (liste: https://docs.fivem.net/docs/game-references/blips/)
        - color: couleur du blip (liste: https://docs.fivem.net/docs/game-references/blips/#blip-colors)
        - scale: taille du blip
        - label: texte affiché au survol du blip
]]
Config.Shops = {
    {
        pos = vec3(251.30451965332, -1955.1026611328, 23.036136627197),
        blip = {
            sprite = 59, -- ID 59 = Icône de supérette
            color = 25, -- 25 = Blanc
            scale = 0.7, -- Taille du blip sur la carte
            label = "Supérette" -- Nom affiché sur la carte
        }
    },
    {
        pos = vec3(239.38481140137, -1942.4749755859, 23.436708450317),
        blip = {
            sprite = 59,
            color = 25,
            scale = 0.7,
            label = "Supérette"
        }
    },
    -- Vous pouvez ajouter d'autres supérettes en copiant le modèle ci-dessus
}

-- Distance à laquelle le joueur peut interagir avec la supérette (en unités GTA)
Config.InteractionDistance = 2.0 

-- Distance à laquelle le marker devient visible (en unités GTA)
Config.DrawDistance = 10.0 

--[[
    Configuration du marker 3D qui apparaît au sol
    - type: type de marker (liste: https://docs.fivem.net/docs/game-references/markers/)
    - scale: taille du marker sur chaque axe
    - color: couleur RGBA (Rouge, Vert, Bleu, Alpha/Opacité)
    - bobUpAndDown: animation de flottement
    - faceCamera: le marker se tourne vers la caméra
    - rotate: rotation continue du marker
]]
Config.Marker = {
    type = 21, -- Type 21 = Flèche vers le bas
    scale = {x = 0.5, y = 0.5, z = 0.5}, -- Dimensions du marker
    color = {r = 0, g = 150, b = 136, a = 100}, -- Couleur turquoise semi-transparente
    bobUpAndDown = true, -- Le marker flotte de haut en bas
    faceCamera = true, -- Le marker fait toujours face au joueur
    rotate = true -- Le marker tourne sur lui-même
}

--[[
    GUIDE D'UTILISATION:

    1. Pour ajouter un nouvel article:
       - Choisissez une catégorie existante ou créez-en une nouvelle
       - Copiez un article existant et modifiez ses propriétés
       - Assurez-vous que l'ID correspond à un item existant dans votre inventaire
       - Choisissez une icône sur FontAwesome (https://fontawesome.com/icons)

    2. Pour ajouter une nouvelle supérette:
       - Copiez un bloc existant dans Config.Shops
       - Modifiez les coordonnées (pos)
       - Personnalisez le blip si nécessaire
       - Vous pouvez ajouter autant de supérettes que vous voulez

    3. Pour personnaliser l'apparence:
       - Ajustez les couleurs dans Config.Marker
       - Modifiez les distances d'interaction et d'affichage
       - Changez le type de marker pour un style différent

    4. Points importants:
       - Les IDs des items doivent correspondre à votre système d'inventaire
       - Les coordonnées doivent être précises pour un bon placement
       - Les distances sont en unités GTA (environ 1 mètre = 1 unité)
]] 