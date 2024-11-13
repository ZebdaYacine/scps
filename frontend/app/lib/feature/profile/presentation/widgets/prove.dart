// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api
import 'package:app/core/extension/extension.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/feature/profile/presentation/pages/web/profile_page.dart';
import 'package:app/feature/profile/presentation/widgets/generated_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProveCard extends StatefulWidget {
  final String Link;
  const ProveCard({
    super.key,
    required this.Link,
  });

  @override
  State<ProveCard> createState() => _ProveCardState();
}

class _ProveCardState extends State<ProveCard> {
  String? imageUrl;

  final nameuserController = TextEditingController();
  @override
  void dispose() {
    nameuserController.dispose();

    super.dispose();
  }

  Future<void> _loadImage() async {
    try {
      logger.d(widget.Link);
      String imagePath = widget.Link;
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pièce justificative",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: imageUrl == null
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.fill,
                          // width: MediaQuery.of(context).size.width,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Veuillez fournir une pièce justificative de votre adresse email ou votre numéro de carte d'identité.",
              style: TextStyle(fontSize: 16),
            ),
            GeneratedBtn(
              callback: () {},
            ),
            AuthField(
              nameFiedl: "N'assurnce",
              controller: nameuserController,
              isPwdField: false,
            ),
            AuthGradientButton(
              buttonText: 'Valider la demande',
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
