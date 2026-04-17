
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennisapp/common/common.dart';
import 'package:tennisapp/modules/profile/view/profile_edit_view.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController(text: 'Test');
  TextEditingController txtEmail = TextEditingController(text: ''.isEmpty ? 'Остутствует' : 'Руслан');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Back button
                      if (Navigator.of(context).canPop() == true)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.grey[700], size: 20),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      if (Navigator.of(context).canPop() == true)
                      SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Профиль',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Внесите изменения в ваш профиль',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(57,194,125, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileEditView()
                            ));
                          },
                          icon: Icon(Icons.edit_outlined, color: Colors.white, size: 22),
                          padding: EdgeInsets.zero,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(File(image!.path),
                        width: 100, height: 100, fit: BoxFit.cover),
                  )
                      : Icon(
                    Icons.person_outline,
                    size: 65,
                    color: Colors.grey.shade400,
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Редактирование фото",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 12,
                      )
                    ],
                  ),
                ),
                Text(
                  "Привет, Руслан!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(250,249,251, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    spacing: 2,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Имя', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                          Text('data', style: TextStyle(color: Color.fromRGBO(142,143,144, 1))),
                        ],
                      ),
                      const Divider(color: Color.fromRGBO(229,231,235, 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                          Text('data', style: TextStyle(color: Color.fromRGBO(142,143,144, 1))),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red.shade400),
                      ),
                      child: Text(
                        'Выйти',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
            ]),
          ),
        ),
      )
    );
  }
}