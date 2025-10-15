import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DebugScreen extends StatefulWidget {
  @override
  _DebugScreenState createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  String _selectedBox = 'managers';  // Default
  final List<String> _boxes = ['managers', 'players', 'teams'];
  Map<dynamic, dynamic> _data = {};
  TextEditingController _editController = TextEditingController();

  Future<void> _loadBoxData(String boxName) async {
    var box = Hive.box(boxName);
    setState(() {
      _data = {for (var key in box.keys) key: box.get(key)};
    });
  }

  Future<void> _exportToJson(String boxName) async {
    var box = Hive.box(boxName);
    var jsonData = jsonEncode(box.toMap());  // Convierte a JSON
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$boxName.json');
    await file.writeAsString(jsonData);
    Share.shareXFiles([XFile(file.path)], text: 'Export de $boxName');  // Comparte via app (e.g., Drive, email)
  }

  Future<void> _importFromJson(String boxName, String jsonString) async {
    var box = Hive.box(boxName);
    var data = jsonDecode(jsonString);
    await box.putAll(data);  // Sobrescribe
    _loadBoxData(boxName);
  }

  @override
  void initState() {
    super.initState();
    _loadBoxData(_selectedBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consola Debug')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedBox,
            onChanged: (value) {
              setState(() {
                _selectedBox = value!;
                _loadBoxData(_selectedBox);
              });
            },
            items: _boxes.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                var key = _data.keys.elementAt(index);
                var value = _data[key];
                return ListTile(
                  title: Text('$key: ${jsonEncode(value.toMap())}'),  // Muestra como JSON
                  onTap: () {
                    _editController.text = jsonEncode(value.toMap());
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Editar $key'),
                        content: TextField(controller: _editController, maxLines: 5),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              var newData = jsonDecode(_editController.text);
                              // Asume tipo basado en box; expande por tipo
                              if (_selectedBox == 'managers') {
                                var manager = Manager.fromMap(newData);  // Agrega fromMap a models
                                await Hive.box<Manager>(_selectedBox).put(key, manager);
                              } // Similar para otros
                              Navigator.pop(ctx);
                              _loadBoxData(_selectedBox);
                            },
                            child: Text('Guardar'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _exportToJson(_selectedBox),
            child: Text('Exportar a JSON'),
          ),
          // Para import: Agrega un button con file_picker si quieres pick JSON file
        ],
      ),
    );
  }
}