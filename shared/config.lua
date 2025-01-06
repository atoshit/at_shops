Config = {}

Config.Position = "top-right"

Config.Colors = {
    primary = "rgb(0, 150, 136)",
    primaryGradient = "rgb(0, 121, 107)",
    background = "rgba(32, 32, 32, 0.95)",
    categoryBg = "rgb(45, 45, 45)",
    categoryHover = "rgb(55, 55, 55)",
    text = "white",
    placeholder = "rgb(150, 150, 150)",
    itemBg = "rgb(35, 35, 35)",
    danger = "#ff5252",
    overlay = "rgba(0, 0, 0, 0.3)",
    inputBg = "rgb(45, 45, 45)",
    inputFocusBg = "rgb(55, 55, 55)",
    cartItemBg = "rgb(35, 35, 35)",
    borderColor = "rgba(255, 255, 255, 0.1)",
    locked = "rgb(70, 70, 70)",
    lockedText = "rgba(255, 255, 255, 0.5)"
}

Config.Style = {
    borderRadius = "8px",
    buttonRadius = "4px",
    fontSize = {
        title = "20px",
        category = "13px",
        text = "13px",
        small = "12px",
        large = "16px",
        icon = "24px",
        notification = "14px"
    },
    spacing = {
        menuPadding = "15px 20px",
        categoryGap = "8px",
        iconGap = "12px",
        itemPadding = "12px 15px",
        notificationPadding = "12px 15px"
    },
    animation = {
        duration = "0.2s",
        type = "ease-out"
    },
    opacity = {
        hover = "0.9",
        inactive = "0.7"
    }
}

Config.Icons = {
    store = "fa-store",
    close = "fa-times",
    back = "fa-arrow-left",
    search = "fa-search",
    cart = "fa-shopping-cart",
    cartAdd = "fa-cart-plus",
    minus = "fa-minus",
    plus = "fa-plus",
    trash = "fa-trash",
    emptyCart = "fa-shopping-cart",
    noResults = "fa-search",
    lock = "fa-lock"
}

Config.Text = {
    title = "Supérette",
    searchPlaceholder = "RECHERCHER UN ARTICLE",
    emptyCart = "Votre panier est vide",
    noResults = "Aucun article trouvé pour",
    searchResults = "Résultats de recherche",
    total = "Total:",
    addedToCart = "Ajouté au panier",
    payButtons = {
        cash = "Payer en espèces",
        card = "Payer par carte"
    }
}

Config.Categories = {
    {
        id = "food",
        label = "NOURRITURE",
        icon = "fa-hamburger",
        locked = false
    },
    {
        id = "drinks",
        label = "BOISSONS",
        icon = "fa-wine-bottle",
        locked = false
    },
    {
        id = "electronics",
        label = "ÉLECTRONIQUE",
        icon = "fa-mobile-alt",
        locked = false
    },
    {
        id = "tools",
        label = "OUTILS",
        icon = "fa-tools",
        small = true,
        locked = false
    },
    {
        id = "misc",
        label = "DIVERS",
        icon = "fa-box-open",
        small = true,
        locked = true
    }
}

Config.Items = {
    food = {
        {
            id = "bread",
            label = "Pain",
            price = 1,
            icon = "fa-bread-slice",
            description = "Du pain frais"
        }
    },
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