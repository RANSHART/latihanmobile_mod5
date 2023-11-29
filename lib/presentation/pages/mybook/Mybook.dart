import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_app/presentation/controllers/dashboard_controller.dart';
import 'package:module_app/presentation/components/booklist/booklist.dart';

class Mybook extends GetView<DashboardController> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Mybook({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Buku'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => controller.tempimagePath.value == ''
                      ? Center(
                          child: Text(
                            'Pilih gambar dari kamera/galeri',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Image.file(File(controller.tempimagePath.value),
                          fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.getImageCamera2();
                    },
                    child: Text('Kamera'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.getImageGallery2();
                    },
                    child: Text('Galeri'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;

                  if (controller.tempimagePath.value.isNotEmpty &&
                      title.isNotEmpty &&
                      description.isNotEmpty) {
                    controller.addBookWithInfo(
                        title, description, controller.tempimagePath.value);

                    // Reset input fields
                    titleController.clear();
                    descriptionController.clear();
                    controller.tempimagePath.value = '';

                    // Inform user that the book was uploaded
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Buku berhasil diupload ke dalam daftar')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Silakan isi semua informasi terlebih dahulu')),
                    );
                  }
                },
                child: Text('Upload'),
              ),
              SizedBox(height: 20),
              BookList(controller.bookInfos
                  .toList()), // Menampilkan daftar buku yang telah diunggah di bawah tombol "Upload"
            ],
          ),
        ),
      ),
    );
  }
}
