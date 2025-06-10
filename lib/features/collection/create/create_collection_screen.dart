import 'package:dex_collection/Hive/collection/collection_provider.dart';
import 'package:dex_collection/l10n/generated/app_localizations.dart';
import 'package:dex_collection/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateCollectionScreen extends ConsumerStatefulWidget {
  const CreateCollectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCollectionScreenState();
}

class _CreateCollectionScreenState
    extends ConsumerState<CreateCollectionScreen> {
  TextEditingController nameController = TextEditingController();

  saveCollection() async {
    ref
        .read(collectionStateProvider.notifier)
        .addCollection(
          Collection(
            name: nameController.text,
            color: availableColors[selectedColorIndex].toARGB32(),
          ),
        );
    if (mounted) {
      context.pop();
    }
  }

  // Lista di 10 colori disponibili
  final List<Color> availableColors = [
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
  ];
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: availableColors[selectedColorIndex],
        title: Text(AppLocalizations.of(context)!.createCollectionTitle),
        actions: [
          IconButton(onPressed: saveCollection, icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            // Picker dei colori
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: availableColors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final color = availableColors[index];
                  final isSelected = index == selectedColorIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: isSelected ? 4 : 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 20,
                        child:
                            isSelected
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // child: Form(
        //   key: _formKey, // GlobalKey<FormState>
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   child: Column(
        //     children: <Widget>[
        //       TextFormField(
        //         decoration: InputDecoration(
        //           // Label for the name field
        //           labelText: 'Name',

        //           // Border style for the text field
        //           border: OutlineInputBorder(),
        //         ),
        //         validator: (value) {
        //           // Validation function for the name field
        //           if (value!.isEmpty) {
        //             // Return an error message if the name is empty
        //             return 'Please enter collection name.';
        //           }

        //           // Return null if the name is valid
        //           return null;
        //         },
        //         onSaved: (value) {
        //           // Save the entered name
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
