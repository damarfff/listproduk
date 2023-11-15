import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc.dart';
import 'produk.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: BlocListener<AuthenticationBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ProdukListPage()),
              );
            }
          },
          child: LoginForm(authBloc: authBloc),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final AuthenticationBloc authBloc;
  String username = 'damar'; 
  String password = 'damar'; 

  LoginForm({required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onChanged: (value) => username = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) => password = value,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              authBloc.add(LoginEvent(username: username, password: password));
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}


class ProdukListPage extends StatelessWidget {
  final List<Produk> produks = [
    Produk(id: 1, name: 'Kertas HVS', price: 500),
    Produk(id: 2, name: 'Buku Gambar', price: 3500),
    Produk(id: 3, name: 'Pulpen ', price: 2500),
    Produk(id: 4, name: 'Pensil', price: 1500),
    Produk(id: 5, name: 'Spidol', price: 4000),
    Produk(id: 6, name: 'Penggaris', price: 4500),
    Produk(id: 7, name: 'Penghapus', price: 1000),
    Produk(id: 8, name: 'Stabilo', price: 5000),
    Produk(id: 9, name: 'Tinta Spidol', price: 10000),
    Produk(id: 10, name: 'Kertas Karton', price: 3000),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Harga Produk')),
      body: ListView.builder(
        itemCount: produks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(produks[index].name),
            subtitle: Text('Harga RP: ${produks[index].price.toString()}'),
          );
        },
      ),
    );
  }
}
