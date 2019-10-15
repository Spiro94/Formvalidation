import 'dart:convert';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = 'https://flutter-varios-27931.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    final response = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }


    Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
    final response = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }


  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final producto = new ProductoModel.fromJson(prod);
      producto.id = id;

      productos.add(producto);
    });

    print(productos);
    return productos;
  }

  Future<bool> eliminarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final response = await http.delete(url);

    final decodedData = json.decode(response.body);
    print(decodedData); //Devuelve null si ok
    return true;
  }
}
