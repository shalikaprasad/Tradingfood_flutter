class ShopCategory {
  int id;
  String type;

  ShopCategory(this.id, this.type);

  static List<ShopCategory> getShopCategory() {
    return <ShopCategory> [
      ShopCategory(1, 'Fruit'),
      ShopCategory(2, 'Vegetable'),
      ShopCategory(3, 'Book'),
      ShopCategory(4, 'Fruit and Vegetable'),
      ShopCategory(5, 'Fair')
    ];
  }

}