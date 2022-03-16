import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  List<String> favList;
  FavoriteView({Key? myKey, required this.favList}) : super(key: myKey);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Pokemons'),backgroundColor: Colors.deepPurple),
      body: ListView.builder(
          itemCount: widget.favList.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text("${widget.favList[index]}"),
                trailing: TextButton(
                  child: Text('Unfavorite'),
                  onPressed: (){
                    widget.favList.removeAt(index);
                  },
                ),
              ),
            );
          } )
    );
  }
}
