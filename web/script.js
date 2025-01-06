let config = null;
let isClosing = false;

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
}

function createCategoryElement(category, small = false) {
    const div = document.createElement('div');
    div.className = `category${small ? ' small' : ''}`;
    div.dataset.category = category.id;
    
    const icon = document.createElement('i');
    icon.className = `fas ${category.icon}`;
    
    const span = document.createElement('span');
    span.textContent = category.label;
    
    div.appendChild(icon);
    div.appendChild(span);
    
    div.addEventListener('click', () => {
        fetch(`https://${GetParentResourceName()}/selectCategory`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ category: category.id })
        });
    });
    
    return div;
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