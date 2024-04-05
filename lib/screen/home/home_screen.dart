import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components/home/search_widget.dart';
import 'components/home/store_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                delegate: SearchWidget(sampleList),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text('FirstPage'),
      ),
      body: const StoreListWidget(),
    );
  }
}
