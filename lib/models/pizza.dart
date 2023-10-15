class Pizza {
  int _idPizza;
  String _namePizza;
  String _pricePizza;
  String _imagePizza;

  int get idPizza => _idPizza;
  set idPizza(int value) => _idPizza = value;

  String get namePizza => _namePizza;
  set namePizza(String value) => _namePizza = value;

  String get pricePizza => _pricePizza;
  set pricePizza(String value) => _pricePizza = value;

  String get imagePizza => _imagePizza;
  set imagePizza(String value) => _imagePizza = value;

  Pizza(this._idPizza, this._namePizza, this._pricePizza, this._imagePizza);
}