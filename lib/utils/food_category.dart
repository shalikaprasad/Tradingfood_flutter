class FoodCategory {
  int id;
  String type;

  FoodCategory(this.id, this.type);

  static List<FoodCategory> getFoodCategory() {
    return <FoodCategory> [
      FoodCategory(1, 'Vegetable'),
      FoodCategory(2, 'Fruit'),
      FoodCategory(3, 'Beans'),
      FoodCategory(4, 'Food'),
      FoodCategory(5, 'Piece')
    ];
  }

}