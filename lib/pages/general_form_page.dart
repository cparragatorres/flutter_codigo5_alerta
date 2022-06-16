import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widgets.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';

class GeneralFormPage extends StatefulWidget {
  const GeneralFormPage({Key? key}) : super(key: key);

  @override
  State<GeneralFormPage> createState() => _GeneralFormPageState();
}

class _GeneralFormPageState extends State<GeneralFormPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  final APIService _apiService = APIService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text("Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
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
              divider20(),
              ButtonNormalWidget(
                title: "Guardar",
                onPressed: () {
                  _apiService.updateNews();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
