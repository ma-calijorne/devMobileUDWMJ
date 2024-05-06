import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void favoritar(){

    if(favorites.contains(current)){
      favorites.remove(current);
    }else{
      favorites.add(current);
    }
    notifyListeners();
  }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var wordPair = appState.current;

    IconData icon;
    if (appState.favorites.contains(wordPair)){
      icon = Icons.favorite;
    }else{
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Meu Primeiro APP Flutter:'),
          BigCard(wordPair: wordPair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children :[
              ElevatedButton(onPressed: () {
                    appState.getNext();
                  },
                    child: Text('Gerar Dupla de Palavra'),
                ),
              SizedBox(width: 10,),
              ElevatedButton.icon(
                onPressed: (){
                  appState.favoritar();
                },
                icon: Icon(icon),
                label: Text('Like'),
           ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.wordPair,
  });

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color : theme.colorScheme.primary,
      child: Padding(
        padding : const EdgeInsets.all(20),
        child: Text(
            wordPair.asLowerCase,
            style: style,
            semanticsLabel: "${wordPair.first} ${wordPair.second}",
        ),
      ),
    );
  }
}