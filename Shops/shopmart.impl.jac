# ============================================================
# 💡 SHOPMART IMPLEMENTATIONS
# Contains helper functions or implementations for extension
# ============================================================

impl Product.show_info {
    print(f"📦 Product: {self.name}, Price: {self.price}, Stock left: {self.stock}");
}

impl Customer.checkout {
    total = 0.0;
    for item in self.cart {
        total += item.price;
    }

    if len(self.cart) == 0 {
        print(f"❗ {self.name} has no items in cart!");
        return;

    print(f"🧾 Checkout summary for {self.name}:");
    for item in self.cart {
        print(f" - {item.name} @ Ksh {item.price}");

    print(f"✅ Total: Ksh {total}");
}
