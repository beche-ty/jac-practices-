# ============================================================
# 🏬 SHOPMART SYSTEM — main Jac logic
# Demonstrates admin, customer, and product interactions
# ============================================================

# ------------------- NODE DEFINITIONS -------------------

node Product {
    has name: str;
    has price: float;
    has stock: int;

    can show_info with entry {
        print(f"🛍️ Product: {self.name} | Price: {self.price} | Stock: {self.stock}");
    }
}

node Admin {
    has name: str;

    can add_product with entry {
        print(f"👩‍💼 Admin {self.name} is adding products to the shelf...");
    }
}

node Customer {
    has name: str;
    has cart: list[Product] = [];

    can browse with entry {
        print(f"🧍 Customer {self.name} is browsing the shop...");
    }

    can add_to_cart with Product entry {
        print(f"🛒 {self.name} added {here.name} to cart.");
        self.cart.append(here);
    }

    can checkout with entry {
        total = 0.0;
        for item in self.cart {
            total += item.price;
        }
        print(f"💰 {self.name} is checking out with total = Ksh {total}");
    }
}

# ------------------- WALKER DEFINITIONS -------------------

walker ShopWalker {
    can manage with Admin entry {
        here::add_product;
    }

    can display_products with Product entry {
        here::show_info;
    }

    can shopping with Customer entry {
        here::browse;
        visit --> Product;
        here::checkout;
    }
}

# ------------------- MAIN ENTRY -------------------

with entry {
    # Create nodes
    admin = spawn Admin(name="Alice");
    cust = spawn Customer(name="Bob");
    prod1 = spawn Product(name="Laptop", price=75000, stock=3);
    prod2 = spawn Product(name="Phone", price=30000, stock=5);
    prod3 = spawn Product(name="Headphones", price=5000, stock=10);

    # Build graph
    admin ++> prod1;
    admin ++> prod2;
    admin ++> prod3;
    cust ++> prod1;
    cust ++> prod2;
    cust ++> prod3;

    # Spawn a walker
    walker  spawn ShopWalker;

    # Run actions
    walker.manage;
    walker.display_products;
    walker.shopping;
}
