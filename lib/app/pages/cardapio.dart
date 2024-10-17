import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => Cardapio(),
    ),
  );
}

class Cardapio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio do Restaurante',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'category': 'Entradas',
      'items': [
        {
          'name': 'Salada Caesar',
          'price': 12.0,
          'image': 'lib/app/images/saladaCesar.jpg',
          'descricao':
              'Uma deliciosa salada com alface romana, croutons crocantes e molho Caesar cremoso. Perfeita para começar sua refeição!'
        },
        {
          'name': 'Bruschetta',
          'price': 10.0,
          'image': 'lib/app/images/bruschetta.jpg',
          'descricao':
              'Fatias de pão italiano tostadas, cobertas com uma mistura fresca de tomates, manjericão e azeite de oliva. Uma explosão de sabor em cada mordida!'
        },
        {
          'name': 'Carpaccio',
          'price': 15.0,
          'image': 'lib/app/images/carpaccio.png',
          'descricao':
              'Finas fatias de carne bovina crua, temperadas com azeite, limão e queijo parmesão. Uma entrada sofisticada e leve!'
        },
      ],
    },
    {
      'category': 'Pratos Principais',
      'items': [
        {
          'name': 'Bife à Parmegiana',
          'price': 30.0,
          'image': 'lib/app/images/bifeParmegiana.jpg',
          'descricao':
              'Suculento bife empanado coberto com molho de tomate e queijo derretido, acompanhado de arroz e batatas fritas. Um clássico que nunca sai de moda!'
        },
        {
          'name': 'Frango Grelhado',
          'price': 25.0,
          'image': 'lib/app/images/frangoGrelhado.jpg',
          'descricao':
              'Peito de frango grelhado temperado com ervas finas, servido com legumes grelhados e arroz. Uma opção saudável e saborosa!'
        },
        {
          'name': 'Peixe ao Molho de Limão',
          'price': 28.0,
          'image': 'lib/app/images/peixeLimao.jpg',
          'descricao':
              'Filé de peixe grelhado, servido com um molho leve de limão e acompanhado de purê de batata. Fresco e delicioso!'
        },
      ],
    },
    {
      'category': 'Bebidas',
      'items': [
        {
          'name': 'Refrigerante',
          'price': 5.0,
          'image': 'lib/app/images/refrigerantes.jpg',
          'descricao':
              'Refresque-se com nosso refrigerante gelado, disponível em várias opções de sabores. O acompanhamento perfeito para sua refeição!'
        },
        {
          'name': 'Suco Natural',
          'price': 7.0,
          'image': 'lib/app/images/sucoFrutas.jpg',
          'descricao':
              'Suco feito com frutas frescas da estação. Uma opção saudável e saborosa para complementar seu pedido!'
        },
        {
          'name': 'Cerveja',
          'price': 10.0,
          'image': 'lib/app/images/cerveja.jpg',
          'descricao':
              'Cerveja gelada para acompanhar seus pratos. Escolha entre nossas opções de cervejas nacionais e importadas!'
        },
      ],
    },
    {
      'category': 'Sobremesas',
      'items': [
        {
          'name': 'Pudim',
          'price': 8.0,
          'image': 'lib/app/images/pudimLeite.jpg',
          'descricao':
              'Clássico pudim de leite, cremoso e coberto com calda de caramelo. Uma sobremesa irresistível!'
        },
        {
          'name': 'Torta de Limão',
          'price': 9.0,
          'image': 'lib/app/images/tortaLimao.jpg',
          'descricao':
              'Deliciosa torta de limão com recheio azedinho e cobertura de merengue. Perfeita para os amantes de limão!'
        },
        {
          'name': 'Sorvete',
          'price': 7.0,
          'image': 'lib/app/images/sorvete.jpg',
          'descricao':
              'Sorvete cremoso, disponível em diversos sabores. Uma maneira perfeita de finalizar sua refeição com frescor!'
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menuItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cardápio do Restaurante'),
          bottom: TabBar(
            isScrollable: true,
            tabs: menuItems.map((category) {
              return Tab(text: category['category']);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: menuItems.map((category) {
            return MenuCategory(items: category['items']);
          }).toList(),
        ),
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final double price;

  ItemDetailScreen({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  // Lista estática para armazenar os itens do pedido
  static List<Map<String, dynamic>> orderList = [];

  void _addToOrder(BuildContext context) {
    // Adiciona o item à lista de pedidos
    orderList.add({
      'name': name,
      'price': price,
      'quantity': 1, // Inicialmente, a quantidade é 1
    });

    // Exibe uma mensagem de confirmação
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item adicionado ao pedido com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToOrderSummary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSummaryScreen(orderItems: orderList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do Item
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 250, // Altura da imagem
              width: double.infinity,
            ),
            SizedBox(height: 16),
            // Nome do Item
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Descrição Completa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Preço
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Botão de Adicionar ao Pedido
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addToOrder(context);
                  _navigateToOrderSummary(
                      context); // Navega para a tela de resumo do pedido
                },
                child: Text('Adicionar ao Pedido'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MenuCategory extends StatelessWidget {
  final List<dynamic> items;

  MenuCategory({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            items[index]['image'],
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          title: Text(items[index]['name']),
          subtitle: Text('R\$ ${items[index]['price'].toStringAsFixed(2)}'),
          onTap: () {
            // Navegar para a tela de detalhes do item
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailScreen(
                  name: items[index]['name'],
                  image: items[index]['image'],
                  description: items[index]['descricao'],
                  price: items[index]['price'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class OrderSummaryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;

  OrderSummaryScreen({required this.orderItems});

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  double get totalPrice {
    return widget.orderItems.fold(0.0, (total, item) {
      return total + (item['price'] * item['quantity']);
    });
  }

  void _increaseQuantity(int index) {
    setState(() {
      widget.orderItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.orderItems[index]['quantity'] > 1) {
        widget.orderItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      widget.orderItems.removeAt(index);
    });
  }

  void _confirmOrder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pedido confirmado com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.orderItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(widget.orderItems[index]['name']),
                    subtitle: Text(
                        'Preço: R\$ ${widget.orderItems[index]['price'].toStringAsFixed(2)}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _decreaseQuantity(index),
                            ),
                            Text(widget.orderItems[index]['quantity']
                                .toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _increaseQuantity(index),
                            ),
                          ],
                        ),
                        Text(
                          'Total: R\$ ${(widget.orderItems[index]['price'] * widget.orderItems[index]['quantity']).toStringAsFixed(2)}',
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeItem(index),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total Geral: R\$ ${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => _confirmOrder(context),
              child: Text('Confirmar Pedido'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
