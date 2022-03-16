import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailView extends StatefulWidget {

  var url;
  DetailView({Key? myKey, this.url}) : super(key: myKey);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  late Map DetailResponse;
  late Image Sprite;

  Future fetchDetails() async {
    http.Response response;
    response = await http.get(Uri.parse("${widget.url}"));

    if(response.statusCode == 200){
      setState(() {
        DetailResponse = json.decode(response.body);
        Sprite = Image.network(DetailResponse['sprites']['front_default']);
      });
    }
  }

  @override
  void initState() {
    fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.deepPurple ,
      ),
      body:

        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(DetailResponse['sprites']['front_default']),
              ),
              Card(
                  child: ListTile(
                      title: Text('Name : '),
                      subtitle: Text(DetailResponse['forms'][0]['name'] , style: TextStyle(fontSize: 20),)
                  )
              ),
              Card(
                  child: ListTile(
                      title: Text('Type : '),
                      subtitle: DetailResponse['types'][0]==DetailResponse['types'].last?
                      Text(DetailResponse['types'][0]['type']['name'] , style: TextStyle(fontSize: 20)):
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: DetailResponse['types'][0]['type']['name'] , style: TextStyle(fontSize: 20)),
                            TextSpan(text: ' / '),
                            TextSpan(text: DetailResponse['types'][1]['type']['name'] , style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                  )
              ),
              Card(
                  child: ListTile(

                    title: Text('Abilities : '),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          DetailResponse['abilities'].length>=1?
                            TextSpan(text: DetailResponse['abilities'][0]['ability']['name'] , style: TextStyle(fontSize: 20))
                              :TextSpan(text: ' '),

                            TextSpan(text: ' / '),

                          DetailResponse['abilities'].length>=2?
                            TextSpan(text: DetailResponse['abilities'][1]['ability']['name'] , style: TextStyle(fontSize: 20))
                              :TextSpan(text: ' '),

                            TextSpan(text: ' / '),

                          DetailResponse['abilities'].length>=3?
                          TextSpan(text: DetailResponse['abilities'][2]['ability']['name'] , style: TextStyle(fontSize: 20))
                              :TextSpan(text: ' '),


                        ],
                      ),
                    ),
                  )
              ),
              Card(
                child: ListTile(
                  title: Text('HP : '),
                  subtitle: Text(DetailResponse['stats'][0]['base_stat'].toString()),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Attack : '),
                  subtitle: Text(DetailResponse['stats'][1]['base_stat'].toString()),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Defence : '),
                  subtitle: Text(DetailResponse['stats'][2]['base_stat'].toString()),
                ),
              ),
              Card(
                  child: ListTile(

                    title: Text('Weight / Height  : '),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: DetailResponse['weight'].toString()),
                          TextSpan(text: ' / '),
                          TextSpan(text: DetailResponse['height'].toString()),
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        )

     /* Container(
        child: ListView(
          children: const <Widget>[
            Card(
                child: ListTile(
                    title: Text('One-line ListTile')
                )
            ),
            Card(
                child: ListTile(
                    title: Text('One-line ListTile')
                )
            ),
            Card(
                child: ListTile(
                    title: Text('One-line ListTile')
                )
            ),
            Card(
                child: ListTile(
                    title: Text('One-line ListTile')
                )
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('Two-line ListTile'),
                subtitle: Text('Here is a second line'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text('Three-line ListTile'),
                subtitle: Text(
                    'A sufficiently long subtitle warrants three lines.'
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
          ],
        ),
      ) */  // Listview Card kullandığım

         /* Column(
            children: [
              Container(
              alignment: Alignment.topLeft,
              height: 100,
              width: 100,
              child:
              Image.network(DetailResponse['sprites']['front_default']),
              decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white
      ),
    ),Column(
              children: [
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                Text('Attributes:' , style: TextStyle(color: Colors.white),),
                ListView(
                  children: [
                    ListTile(
                      title: Text('Primary text'),
                      leading: Icon(Icons.label),
                      trailing: Text('Metadata'),
                    ),
                  ],
                )],


            )
            ],
          )  */  // unused old colomn child view

    );
  }
}

