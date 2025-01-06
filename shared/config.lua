Config = {}

Config.Position = "top-right" --"top-left", "top-right", "center", "center-left", "center-right"

Config.Colors = {
    primary = "rgb(0, 150, 136)",
    primaryGradient = "rgb(0, 121, 107)", 
    background = "rgba(32, 32, 32, 0.95)", 
    categoryBg = "rgb(45, 45, 45)",
    categoryHover = "rgb(55, 55, 55)", 
    text = "white", 
    placeholder = "rgb(150, 150, 150)" 
}

Config.Style = {
    borderRadius = "8px", 
    buttonRadius = "4px", 
    fontSize = {
        title = "20px",
        category = "13px"
    },
    spacing = {
        menuPadding = "15px 20px",
        categoryGap = "8px",
        iconGap = "12px"
    }
}

Config.Categories = {
    {
        id = "food",
        label = "NOURRITURE",
        icon = "fa-hamburger"
    },
    {
        id = "drinks",
        label = "BOISSONS",
        icon = "fa-wine-bottle"
    },
    {
        id = "electronics",
        label = "ÉLECTRONIQUE",
        icon = "fa-mobile-alt"
    },
    {
        id = "tools",
        label = "OUTILS",
        icon = "fa-tools",
        small = true
    },
    {
        id = "misc",
        label = "DIVERS",
        icon = "fa-box-open",
        small = true
    }
}

Config.Text = {
    title = "Supérette",
    searchPlaceholder = "RECHERCHER UN ARTICLE"
} 