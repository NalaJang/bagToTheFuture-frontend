import 'package:flutter/material.dart';

class SearchWidget extends SearchDelegate {
  String selectedResult = '';
  final List<String> sampleList;
  final List<String> sampleRecentList = [];

  SearchWidget(this.sampleList);

  @override
  String get searchFieldLabel => '검색어를 입력해 주세요.';

  @override
  List<Widget>? buildActions(BuildContext context) {
    print('${sampleList.length}');
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Text('취소'),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(selectedResult),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = sampleRecentList
        : suggestionList.addAll(
            sampleList.where((e) => e.contains(query)),
          );
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {

        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );

      },
    );
  }
}
