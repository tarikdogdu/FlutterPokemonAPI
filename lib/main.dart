import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myflutterapp1/details.dart';
import 'package:myflutterapp1/Favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: HomePage(),debugShowCheckedModeBanner: false,));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Map APIResponse;
  late List listofResults;
  List<String> Favorites = [];
  int addtoFav = 0;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

    if(response.statusCode == 200){
      setState(() {
        APIResponse = json.decode(response.body);
        listofResults = APIResponse['results'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Pokemon List'), backgroundColor: Colors.deepPurple,
          centerTitle: true,
          leading: TextButton(style:
              ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.red ),),

            onPressed: (){

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteView(favList: Favorites,) ));

            },
            child: Icon(Icons.star),
    ),
      ),
      body:
            Container(
              child: ListView.builder(
                  itemCount: listofResults.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DetailView(url: listofResults[index]['url'])));

                          //buraya navigator gelcek


                        },
                        leading: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            Favorites.length == 0? Favorites.add(listofResults[index]['name']) : print('');
                            for(String name in Favorites){
                              name!=listofResults[index]['name']?
                                  addtoFav = 1 : addtoFav = 0;
                            }
                            addtoFav == 1? Favorites.add(listofResults[index]['name']) : print('');
                          },
                          child: Icon(Icons.star_border)
                        ),
                        title: Text(listofResults[index]['name']),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    );
                  }
                  ),
            ),

      
    );
  }
}

