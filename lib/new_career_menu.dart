// lib/new_career_menu.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';  // Agrega este paquete a pubspec.yaml: cached_network_image: ^3.4.0
import 'data_manager.dart';
import 'models/manager.dart';

class NewCareerMenu extends StatefulWidget {
  @override
  _NewCareerMenuState createState() => _NewCareerMenuState();
}

class _NewCareerMenuState extends State<NewCareerMenu> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  String _selectedStyle = 'Ofensivo';
  String _selectedAvatar = 'https://robohash.org/avatar1?set=set5&size=80x80';  // Default
  String _selectedLeague = 'Inglaterra';
  String _selectedClub = 'Liverpool';

  final List<String> _styles = ['Ofensivo', 'Defensivo', 'Equilibrado'];

  // URLs de avatares reales (pixel art/random faces via robohash.org - genera avatares pixelados)
  final List<String> _avatars = [
    'https://robohash.org/avatar1?set=set5&size=80x80',
    'https://robohash.org/avatar2?set=set5&size=80x80',
    'https://robohash.org/avatar3?set=set5&size=80x80',
    'https://robohash.org/avatar4?set=set5&size=80x80',
    'https://robohash.org/avatar5?set=set5&size=80x80',
  ];

  Map<String, List<String>> _leagues = {};  // Cargado dinámicamente

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await DataManager.initializeData();  // Inicializa si no existe
    setState(() {
      _leagues = DataManager.getLeaguesAndTeams();
      if (_leagues.isNotEmpty) {
        _selectedLeague = _leagues.keys.first;
        _selectedClub = _leagues[_selectedLeague]![0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Carrera'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crear Entrenador', style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            DropdownButton<String>(
              value: _selectedStyle,
              onChanged: (value) {
                setState(() {
                  _selectedStyle = value!;
                });
              },
              items: _styles.map((style) => DropdownMenuItem(value: style, child: Text(style))).toList(),
              hint: Text('Estilo de Juego Preferido'),
            ),
            Text('Elegir Avatar'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _avatars.map((avatarUrl) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatarUrl;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: _selectedAvatar == avatarUrl ? Colors.blue : Colors.transparent, width: 2),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: avatarUrl,
                        width: 80,
                        height: 80,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Elegir Club', style: Theme.of(context).textTheme.headlineSmall),
            if (_leagues.isNotEmpty)
              DropdownButton<String>(
                value: _selectedLeague,
                onChanged: (value) {
                  setState(() {
                    _selectedLeague = value!;
                    _selectedClub = _leagues[value]![0];
                  });
                },
                items: _leagues.keys.map((league) => DropdownMenuItem(value: league, child: Text(league))).toList(),
                hint: Text('Liga'),
              ),
            if (_leagues.isNotEmpty)
              DropdownButton<String>(
                value: _selectedClub,
                onChanged: (value) {
                  setState(() {
                    _selectedClub = value!;
                  });
                },
                items: _leagues[_selectedLeague]!.map((club) => DropdownMenuItem(value: club, child: Text(club))).toList(),
                hint: Text('Club'),
              ),
            if (_leagues.isEmpty)
              Text('Cargando ligas... o error al inicializar'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty && _surnameController.text.isNotEmpty) {
                  var manager = Manager(
                    name: _nameController.text,
                    surname: _surnameController.text,
                    style: _selectedStyle,
                    avatar: _selectedAvatar,
                  );
                  await DataManager.saveManager(manager);
                  // TODO: Navega a siguiente pantalla o muestra éxito
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Manager guardado!')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Completa los campos')));
                }
              },
              child: Text('CREAR'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('VOLVER'),
            ),
          ],
        ),
      ),
    );
  }
}