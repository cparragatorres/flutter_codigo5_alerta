import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widgets.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class GeneralFormPage extends StatefulWidget {
  NewsModel? newsModel;

  GeneralFormPage({this.newsModel});

  @override
  State<GeneralFormPage> createState() => _GeneralFormPageState();
}

class _GeneralFormPageState extends State<GeneralFormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final APIService _apiService = APIService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageNews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.newsModel != null) {
      _titleController.text = widget.newsModel!.titulo;
      _linkController.text = widget.newsModel!.link;
      _dateController.text = widget.newsModel!.fecha;
    }
  }

  getImageGallery() async {
    XFile? imageXFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    imageNews = imageXFile;
    setState(() {});
  }

  _save() {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      NewsModel newsModel = NewsModel(
        id: widget.newsModel!.id,
        link: _linkController.text,
        titulo: _titleController.text,
        fecha: _dateController.text,
        imagen: "",
      );
      File? _image = imageNews == null ? null : File(imageNews!.path);

      _apiService.updateNews2(newsModel, _image).then((value) {
        if (value != null) {
          snackBarMessage(context, TypeMessage.success);
          Navigator.pop(context);
        } else {
          isLoading = false;
          snackBarMessage(context, TypeMessage.error);
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text("Form"),
        actions: [
          IconButton(
            onPressed: () {
              getImageGallery();
            },
            icon: Icon(
              Icons.image,
            ),
          ),
        ],
      ),
      body: !isLoading
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputTextFieldWidget(
                        hintText: "Título",
                        controller: _titleController,
                      ),
                      InputTextFieldWidget(
                        hintText: "Link",
                        controller: _linkController,
                      ),
                      InputTextFieldWidget(
                        hintText: "Fecha",
                        controller: _dateController,
                        isSelectDate: true,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        width: double.infinity,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: imageNews == null
                              ? Image.asset(
                                  "assets/images/imagex1.jpeg",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(imageNews!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      divider20(),
                      ButtonNormalWidget(
                        title: "Guardar",
                        onPressed: () {
                          _save();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
