import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/ui/first/search.dart';
import 'package:rest_api_ex/ui/first/store_list.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sampleList = ['참바른빵', '소세지빵', '초코소라빵', '초코케이크'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(sampleList),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('FirstPage'),
      ),
      body: const StoreList(),
    );
  }
}
