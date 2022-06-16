import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widgets.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.newsModel != null) {
      _titleController.text = widget.newsModel!.titulo;
      _linkController.text = widget.newsModel!.link;
    }
  }

  _save(){
    if(_formKey.currentState!.validate()){
      isLoading = true;
      setState((){});
      NewsModel newsModel = NewsModel(
        id: widget.newsModel!.id,
        link: _linkController.text,
        titulo: _titleController.text,
        fecha: _dateController.text,
        imagen: "",
      );
      _apiService.updateNews(newsModel).then((value){
        if(value != null){
          snackBarMessage(context, TypeMessage.success);
          Navigator.pop(context);
        }else{
          isLoading = false;
          snackBarMessage(context, TypeMessage.error);
          setState((){});
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
      ),
      body: !isLoading ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
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
      ): Center(child: CircularProgressIndicator()),
    );
  }
}
