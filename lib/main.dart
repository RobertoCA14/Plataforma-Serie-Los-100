import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(Aplicacion());
}

class Aplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Serie Favorita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Paginas(),
    );
  }
}

class Paginas extends StatefulWidget {
  @override
  _PaginasState createState() => _PaginasState();
}

class _PaginasState extends State<Paginas> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentPage = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Serie Favorita'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: 'Portada',
            ),
            Tab(
              icon: Icon(Icons.people),
              text: 'Personajes',
            ),
            Tab(
              icon: Icon(Icons.camera),
              text: 'Momentos',
            ),
            Tab(
              icon: Icon(Icons.info),
              text: 'Acerca de',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'En mi vida',
            ),
            Tab(
              icon: Icon(Icons.contact_mail),
              text: 'Contrátame',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Portada(),
          PersonajesScreen(), // Cambiado aquí
          MomentosFavoritosScreen(),
          AcercaDeScreen(),
          EnMiVidaScreen(),
          Contratame(),
        ],
      ),
    );
  }
}

class Portada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el ID del video de la URL de YouTube
    String? videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=2NUnsXkcX4E&ab_channel=Crusshy");

    return Scaffold(
      appBar: AppBar(
        title: Text('Los 100'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId ?? '', // Usa el valor de videoId o una cadena vacía si es nulo
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
  }
}

class PersonajesScreen extends StatelessWidget {
  final List<Character> characters = [
    Character(
      name: 'Bellamy y Clarke',
      photoUrl: 'assets/Bellamyyclarke.jpg',
      details: 'Detalles del Personaje 1.',
    ),
    Character(
      name: 'Murpfhy',
      photoUrl: 'assets/Murphy1.jpg',
      details: 'Detalles del Personaje 2...',
    ),
    Character(
      name: 'Octavia',
      photoUrl: 'assets/Octavia.jpg',
      details: 'Detalles del Personaje 3...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes'),
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(characters[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CharacterDetailsScreen(
                    character: characters[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Character {
  final String name;
  final String photoUrl;
  final String details;

  Character({
    required this.name,
    required this.photoUrl,
    required this.details,
  });
}

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              character.photoUrl,
              width: 600,
              height: 600,
            ),
            SizedBox(height: 20),
            Text(
              character.details,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}



class MomentoFavorito {
  final String titulo;
  final String fotoUrl;
  final String videoUrl;

  MomentoFavorito({
    required this.titulo,
    required this.fotoUrl,
    required this.videoUrl,
  });
}

class MomentosFavoritosScreen extends StatelessWidget {
  final List<MomentoFavorito> momentos = [
    MomentoFavorito(
      titulo: 'Momentos Bellamy y Clarke',
      fotoUrl: 'assets/Bellamyyclarke.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=2NUnsXkcX4E&ab_channel=Crusshy',
    ),
    MomentoFavorito(
      titulo: 'Momento Murphy',
      fotoUrl: 'assets/Murphy1.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=2NUnsXkcX4E&ab_channel=Crusshy',
    ),
    MomentoFavorito(
      titulo: 'Momento Octavia',
      fotoUrl: 'assets/Octavia.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=2NUnsXkcX4E&ab_channel=Crusshy',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Momentos Favoritos'),
      ),
      body: ListView.builder(
        itemCount: momentos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(momentos[index].titulo),
            leading: Image.asset(
              momentos[index].fotoUrl,
              width: 50,
              height: 50,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleMomentoScreen(momento: momentos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalleMomentoScreen extends StatelessWidget {
  final MomentoFavorito momento;

  DetalleMomentoScreen({required this.momento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(momento.titulo),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              momento.fotoUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Text(
            momento.titulo,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(momento.videoUrl) ?? '',
                flags: YoutubePlayerFlags(autoPlay: true, mute: false),
              ),
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
        ],
      ),
    );
  }
}



class Serie {
  final String nombre;
  final int temporadas;
  final String creador;

  Serie({
    required this.nombre,
    required this.temporadas,
    required this.creador,
  });
}

class AcercaDeScreen extends StatelessWidget {
  final Serie serie = Serie(
    nombre: 'Los 100',
    temporadas: 7,
    creador: 'Jason Rothenberg',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Un apocalipsis nuclear destruye la vida humana en la Tierra. Los únicos supervivientes son los habitantes de las estaciones espaciales internacionales. Tres generaciones después, la escasez de recursos los obliga a tomar medidas desesperadas.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Nombre: ${serie.nombre}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Temporadas: ${serie.temporadas}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Creador: ${serie.creador}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}



class EnMiVidaScreen extends StatelessWidget {
  final String videoUrl = 'https://www.youtube.com/watch?v=2NUnsXkcX4E&ab_channel=Crusshy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('En mi vida'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Comparte un video explicando por qué esta serie es importante para ti',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Contratame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrátame'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/foto2x2.jpg'), // Reemplaza con la ruta de tu foto
            ),
            SizedBox(height: 20),
            Text(
              'Roberto A. Cuevas M.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Desarrollador de aplicaciones móviles',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Correo electrónico: Robel970914@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Teléfono: +8096981890',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Sitio web: www.Robert970914.com',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}