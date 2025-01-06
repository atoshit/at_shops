let config = null;
let isClosing = false;
let currentView = 'main';
let cart = [];
let notifications = [];
let allItems = [];

function showView(viewName) {
    document.querySelector('.main-view').style.display = viewName === 'main' ? 'block' : 'none';
    document.querySelector('.items-view').style.display = viewName === 'items' ? 'block' : 'none';
    document.querySelector('.cart-view').style.display = viewName === 'cart' ? 'block' : 'none';
    
    if (viewName === 'cart') {
        updateCartView();
    }
    
    currentView = viewName;
}

function createItemElement(item) {
    const itemDiv = document.createElement('div');
    itemDiv.className = 'item-card';
    itemDiv.innerHTML = `
        <div class="item-top">
            <div class="item-icon">
                <i class="fas ${item.icon}"></i>
            </div>
            <div class="item-info">
                <h3>${item.label}</h3>
            </div>
        </div>
        <div class="item-bottom">
            <div class="quantity-container">
                <input type="number" min="1" value="1" class="item-quantity">
            </div>
            <div class="price-container">
                ${item.price}$
            </div>
            <button class="add-to-cart">
                <i class="fas ${config.Icons.cartAdd}"></i>
            </button>
        </div>
    `;

    const addButton = itemDiv.querySelector('.add-to-cart');
    const quantityInput = itemDiv.querySelector('.item-quantity');

    addButton.addEventListener('click', () => {
        const quantity = parseInt(quantityInput.value);
        addToCart(item, quantity);
    });

    return itemDiv;
}

function addToCart(item, quantity) {
    const existingItem = cart.find(i => i.id === item.id);
    if (existingItem) {
        existingItem.quantity += quantity;
    } else {
        cart.push({ ...item, quantity });
    }
    updateCartCount();
    showNotification(item, quantity);
}

function updateCartCount() {
    const count = cart.reduce((sum, item) => sum + item.quantity, 0);
    document.querySelector('.cart-count').textContent = count;
}

function showItems(categoryId) {
    const items = config.Items[categoryId];
    if (!items) return;

    const itemsGrid = document.querySelector('.items-grid');
    itemsGrid.innerHTML = '';
    
    items.forEach(item => {
        itemsGrid.appendChild(createItemElement(item));
    });

    const categoryLabel = config.Categories.find(cat => cat.id === categoryId)?.label || 'Catégorie';
    document.querySelector('.items-view h2').textContent = categoryLabel;

    showView('items');
}

function createCategoryElement(category, small = false) {
    const div = document.createElement('div');
    div.className = `category${small ? ' small' : ''}${category.locked ? ' locked' : ''}`;
    div.dataset.category = category.id;
    
    const icon = document.createElement('i');
    icon.className = `fas ${category.icon}`;
    
    const span = document.createElement('span');
    span.textContent = category.label;
    
    div.appendChild(icon);
    div.appendChild(span);
    
    if (category.locked) {
        const lockIcon = document.createElement('i');
        lockIcon.className = `fas ${config.Icons.lock}`;
        lockIcon.classList.add('lock-icon');
        div.appendChild(lockIcon);
    } else {
        div.addEventListener('click', () => {
            showItems(category.id);
        });
    }
    
    return div;
}

document.querySelectorAll('.back-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        showView('main');
    });
});

document.getElementById('cart-btn').addEventListener('click', () => {
    showView('cart');
});

function closeUI() {
    if (isClosing) return;
    isClosing = true;
    
    const container = document.querySelector('.container');
    container.style.animation = 'slideOut 0.2s ease-out forwards';
    
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });

    setTimeout(() => {
        document.body.style.display = 'none';
        container.style.animation = '';
        isClosing = false;
    }, 150);
}

window.addEventListener('message', function(event) {
    if (event.data.type === 'openShop') {
        if (isClosing) return;
        config = event.data.config;
        const container = document.querySelector('.container');
        document.body.style.display = 'block';
        container.style.animation = 'slideIn 0.2s ease-out';
        initializeUI();
    } else if (event.data.type === 'closeShop') {
        closeUI();
    }
});

function initializeUI() {
    if (!config) return;

    document.querySelector('.banner h1').textContent = config.Text.title;
    
    allItems = Object.values(config.Items).flat();

    const categoriesContainer = document.querySelector('.categories');
    categoriesContainer.innerHTML = ''; 

    const normalCategories = config.Categories.filter(cat => !cat.small);
    normalCategories.forEach(category => {
        categoriesContainer.appendChild(createCategoryElement(category));
    });

    const smallCategories = config.Categories.filter(cat => cat.small);
    if (smallCategories.length > 0) {
        const row = document.createElement('div');
        row.className = 'category-row';
        smallCategories.forEach(category => {
            row.appendChild(createCategoryElement(category, true));
        });
        categoriesContainer.appendChild(row);
    }

    document.querySelector('.search-bar input').placeholder = config.Text.searchPlaceholder;

    applyStyles();

    const searchInput = document.querySelector('.search-bar input');
    const searchBtn = document.querySelector('.search-btn');

    function performSearch() {
        const searchTerm = searchInput.value.trim().toLowerCase();
        if (searchTerm === '') return;

        const foundItems = allItems.filter(item => 
            item.label.toLowerCase().includes(searchTerm)
        );

        const itemsGrid = document.querySelector('.items-grid');
        itemsGrid.innerHTML = '';

        if (foundItems.length === 0) {
            itemsGrid.innerHTML = `
                <div class="search-no-results">
                    <i class="fas fa-search"></i>
                    <p>Aucun article trouvé pour "${searchInput.value}"</p>
                </div>
            `;
        } else {
            foundItems.forEach(item => {
                itemsGrid.appendChild(createItemElement(item));
            });
        }

        document.querySelector('.items-view h2').textContent = 'Résultats de recherche';
        showView('items');
    }

    searchBtn.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
}

function applyStyles() {
    const style = document.createElement('style');
    const positions = {
        'top-left': {
            top: '20px',
            left: '20px',
            transform: 'none'
        },
        'top-right': {
            top: '20px',
            right: '20px',
            transform: 'none'
        },
        'center': {
            top: '50%',
            left: '50%',
            transform: 'translate(-50%, -50%)'
        },
        'center-left': {
            top: '50%',
            left: '20px',
            transform: 'translateY(-50%)'
        },
        'center-right': {
            top: '50%',
            right: '20px',
            transform: 'translateY(-50%)'
        }
    };

    const position = positions[config.Position] || positions['top-right'];

    style.textContent = `
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideOut {
            from {
                opacity: 1;
                transform: translateX(0);
            }
            to {
                opacity: 0;
                transform: translateX(20px);
            }
        }

        .container {
            background-color: ${config.Colors.background};
            border-radius: ${config.Style.borderRadius};
            position: absolute;
            ${Object.entries(position).map(([key, value]) => `${key}: ${value};`).join('\n')}
            animation-fill-mode: forwards;
        }
        .banner {
            background: linear-gradient(135deg, ${config.Colors.primary}, ${config.Colors.primaryGradient});
        }
        .category {
            background-color: ${config.Colors.categoryBg};
            border-radius: ${config.Style.buttonRadius};
        }
        .category:hover {
            background-color: ${config.Colors.categoryHover};
        }
        .category i {
            color: ${config.Colors.primary};
        }
        .search-no-results {
            color: ${config.Colors.text};
            font-size: ${config.Style.fontSize.text};
        }
        .notification {
            background: ${config.Colors.primary};
            padding: ${config.Style.spacing.notificationPadding};
            font-size: ${config.Style.fontSize.notification};
        }
        .category.locked {
            background-color: ${config.Colors.locked};
            cursor: not-allowed;
            position: relative;
        }

        .category.locked i:not(.lock-icon) {
            opacity: 0.5;
        }

        .category.locked span {
            color: ${config.Colors.lockedText} !important;
        }

        .lock-icon {
            position: absolute;
            right: 15px;
            color: ${config.Colors.lockedText};
            font-size: ${config.Style.fontSize.small};
        }
        /* ... autres styles ... */
    `;
    document.head.appendChild(style);
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeUI();
    }
});

document.querySelector('.close-btn').addEventListener('click', closeUI); 

function updateCartView() {
    const cartItems = document.querySelector('.cart-items');
    const cartFooter = document.querySelector('.cart-footer');
    cartItems.innerHTML = '';
    let total = 0;

    if (cart.length === 0) {
        cartItems.innerHTML = `
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <p>Votre panier est vide</p>
            </div>
        `;
        cartFooter.style.display = 'none';
        return;
    }

    cartFooter.style.display = 'block';
    
    cart.forEach(item => {
        const cartItem = document.createElement('div');
        cartItem.className = 'cart-item';
        cartItem.innerHTML = `
            <div class="item-icon">
                <i class="fas ${item.icon}"></i>
            </div>
            <div class="cart-item-info">
                <h3>${item.label}</h3>
                <span class="item-price">${item.price}$</span>
            </div>
            <div class="cart-item-actions">
                <div class="cart-item-quantity">
                    <button class="quantity-btn minus">
                        <i class="fas fa-minus"></i>
                    </button>
                    <span>${item.quantity}</span>
                    <button class="quantity-btn plus">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
                <button class="remove-item">
                    <i class="fas fa-trash"></i>
                </button>
            </div>
        `;

        cartItem.querySelector('.minus').addEventListener('click', () => {
            if (item.quantity > 1) {
                item.quantity--;
                updateCartView();
                updateCartCount();
            }
        });

        cartItem.querySelector('.plus').addEventListener('click', () => {
            item.quantity++;
            updateCartView();
            updateCartCount();
        });

        cartItem.querySelector('.remove-item').addEventListener('click', () => {
            cart = cart.filter(i => i.id !== item.id);
            updateCartView();
            updateCartCount();
        });

        total += item.price * item.quantity;
        cartItems.appendChild(cartItem);
    });

    document.querySelector('.total-amount').textContent = `${total}$`;
}

document.querySelector('.pay-cash').addEventListener('click', () => {
    if (cart.length === 0) return;
    fetch(`https://${GetParentResourceName()}/payCart`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ method: 'cash', items: cart })
    });
});

document.querySelector('.pay-card').addEventListener('click', () => {
    if (cart.length === 0) return;
    fetch(`https://${GetParentResourceName()}/payCart`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ method: 'card', items: cart })
    });
});

function showNotification(item, quantity) {
    const total = item.price * quantity;
    
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.innerHTML = `
        <i class="fas fa-cart-plus"></i>
        <div class="notification-content">
            <div class="notification-title">Ajouté au panier</div>
            <div class="notification-details">
                ${quantity}x ${item.label} - Total: ${total}$
            </div>
        </div>
    `;

    const container = document.querySelector('.notifications');
    if (!container) {
        const notifContainer = document.createElement('div');
        notifContainer.className = 'notifications';
        document.body.appendChild(notifContainer);
    }

    document.querySelector('.notifications').appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
} 