# 🏪 Système de Supérettes Optimisé pour FiveM

[Help](https://discord.gg/atoshi)

## 📝 Description
Un système de supérettes moderne et optimisé pour FiveM, offrant une interface utilisateur fluide et des performances exceptionnelles. Le script permet aux joueurs d'acheter divers articles dans des supérettes réparties sur la carte, avec un système de paiement en espèces ou par carte.

### ✨ Caractéristiques Principales
- Interface utilisateur moderne et responsive
- Système de catégories d'articles
- Recherche d'articles en temps réel
- Panier d'achats dynamique
- Double méthode de paiement (espèces/carte)
- Animations de paiement par TPE
- Système de notifications intégré
- Protection anti-exploit
- Optimisation maximale des performances

## 🚀 Performance
- Utilisation CPU : 0.00ms hors zone
- Utilisation CPU en zone : ~0.02ms
- Gestion optimisée des événements
- Nettoyage automatique des sessions
- Mise en cache des données fréquemment utilisées

## 📦 Installation
1. Téléchargez les fichiers
2. Placez le dossier dans votre dossier `resources`
3. Ajoutez `ensure at_shops` à votre `server.cfg`
4. Configurez le fichier `config.lua` selon vos besoins

## ⚙️ Configuration
Le fichier `config.lua` permet de personnaliser :
- Les articles disponibles et leurs prix
- Les emplacements des supérettes
- L'apparence des markers et blips
- Les distances d'interaction
- Et bien plus encore...

### Exemple de Configuration

```lua
Config.Items = {
    food = {
        {
            id = "bread",
            label = "Pain",
            price = 1,
            icon = "fa-bread-slice",
            description = "Du pain frais"
        }
    }
}
```

## 🔒 Sécurité
- Validation côté serveur de toutes les transactions
- Système de token unique par session
- Vérification de la proximité du joueur
- Protection contre les injections d'événements
- Nettoyage automatique des sessions inactives

## 🔧 Dépendances
- [es_extended](https://github.com/esx-framework/esx_core)
- Font Awesome 6 (inclus)

## ⚡ Optimisations
- Utilisation de variables locales pour les fonctions natives
- Boucles optimisées avec compteurs numériques
- Gestion intelligente des états
- Mise en cache des données fréquentes
- Utilisation minimale des événements réseau

## 🎨 Personnalisation
- Interface entièrement personnalisable via CSS
- Système de markers configurable
- Messages et textes modifiables
- Icônes personnalisables (FontAwesome)

## 📊 Utilisation des Ressources
### Client
- Hors zone : 0.00ms
- Dans une zone : ~0.02ms
- Pendant l'utilisation : ~0.05ms

### Serveur
- Au repos : 0.00ms
- Pendant une transaction : ~0.01ms

## 🛠️ Support Technique
Pour toute question ou problème :
1. Vérifiez la configuration
2. Consultez les logs serveur
3. Assurez-vous que les dépendances sont à jour

## 📝 Notes de Version
### Version 1.0.0
- Interface utilisateur moderne
- Système de paiement dual
- Protection anti-exploit
- Optimisations de performance
- Documentation complète

## 📜 Licence
Ce script est protégé par licence. Voir le fichier `LICENSE` pour plus de détails.

## ⚠️ Points Importants
1. Assurez-vous que les IDs des items correspondent à votre système d'inventaire
2. Vérifiez les coordonnées des supérettes avant le déploiement
3. Testez les transactions avant la mise en production
4. Surveillez les logs pour détecter d'éventuelles tentatives d'exploitation

## 🔄 Mises à Jour Futures
- Système de promotions
- Interface admin
- Statistiques de vente
- Système de stock
- Support multi-langues

## 🔄 Futures Mises à Jour Détaillées

### 1. Système de Promotions
**Description :**
- Promotions temporaires sur certains articles
- Réductions en pourcentage ou prix fixe
- Promotions limitées dans le temps
- Promotions spéciales (2+1 gratuit, etc.)

**Implémentation :**
```lua
Config.Promotions = {
    {
        type = "percentage", -- Type de promotion
        value = 20, -- -20%
        items = {"bread", "water"}, -- Articles concernés
        startTime = "10:00", -- Heure de début
        endTime = "18:00", -- Heure de fin
        days = {1, 2, 3, 4, 5} -- Jours actifs (1 = Lundi)
    },
    {
        type = "bundle", -- Promotion pack
        items = {"cola"},
        buyCount = 2, -- Acheter 2
        freeCount = 1, -- En avoir 3
        duration = 7 -- Durée en jours
    }
}
```

### 2. Interface Administrateur
**Description :**
- Gestion des prix en temps réel
- Création/modification des promotions
- Visualisation des statistiques
- Gestion des stocks
- Configuration des supérettes

**Implémentation :**
```lua
-- Commande admin
RegisterCommand("shop_admin", function(source)
    if IsPlayerAdmin(source) then
        TriggerClientEvent("at_shops:openAdminPanel", source, {
            stats = GetShopStats(),
            inventory = GetShopInventory(),
            promotions = Config.Promotions
        })
    end
end)
```

### 3. Statistiques de Vente
**Description :**
- Suivi des ventes par article/catégorie
- Graphiques de performance
- Heures de pointe
- Articles les plus vendus
- Revenus générés

**Implémentation :**
```sql
-- Structure de la base de données
CREATE TABLE shop_sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    item_id VARCHAR(50),
    quantity INT,
    price FLOAT,
    payment_method VARCHAR(10),
    timestamp DATETIME,
    shop_id INT
);

-- Exemple de requête statistique
SELECT 
    item_id,
    SUM(quantity) as total_sold,
    SUM(quantity * price) as revenue,
    DATE_FORMAT(timestamp, '%H:00') as hour
FROM shop_sales
GROUP BY item_id, hour
ORDER BY revenue DESC;
```

### 4. Système de Stock
**Description :**
- Stock limité par article
- Réapprovisionnement automatique
- Alertes de stock bas
- Système de commande pour les admins
- Variations de prix selon le stock

**Implémentation :**
```lua
Config.Inventory = {
    ["bread"] = {
        maxStock = 100, -- Stock maximum
        restock = { -- Paramètres de réapprovisionnement
            amount = 20, -- Quantité par réapprovisionnement
            interval = 3600, -- Intervalle en secondes
            minStock = 10 -- Seuil d'alerte
        },
        dynamicPricing = { -- Prix dynamique selon le stock
            basePrice = 1,
            maxIncrease = 0.5, -- +50% max
            threshold = 20 -- % de stock restant
        }
    }
}
```

### 5. Support Multi-langues
**Description :**
- Support de plusieurs langues
- Détection automatique de la langue
- Interface de traduction pour admins
- Possibilité d'ajouter facilement des langues

**Implémentation :**
```lua
Config.Locales = {
    ['fr'] = {
        ['shop_name'] = 'Supérette',
        ['cart_empty'] = 'Votre panier est vide',
        ['payment_success'] = 'Paiement accepté',
        -- etc...
    },
    ['en'] = {
        ['shop_name'] = 'Shop',
        ['cart_empty'] = 'Your cart is empty',
        ['payment_success'] = 'Payment accepted',
        -- etc...
    }
}

-- Système de traduction
function _U(key, lang)
    lang = lang or GetPlayerLocale()
    return Config.Locales[lang][key] or key
end
```

### Intégration Globale
Toutes ces fonctionnalités seront :
1. Accessibles via une interface admin unifiée
2. Synchronisées en temps réel
3. Sauvegardées dans une base de données
4. Optimisées pour maintenir les performances
5. Configurables via le fichier config.lua
6. Sécurisées contre les exploits
7. Documentées en détail

### Impact sur les Performances
- Utilisation de cache pour les données fréquentes
- Mise à jour asynchrone des statistiques
- Optimisation des requêtes SQL
- Limitation des synchronisations réseau
- Gestion intelligente des événements

## Image
![Menu principal](image.png)
![Dans une catégorie](image-1.png)
![Panier d'achat vide](image-2.png)
![Panier d'achat rempli](image-3.png)
![Notification](image-4.png)
![Interface Payement](image-5.png)
