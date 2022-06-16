import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';

class GeneralFormPage extends StatefulWidget {
  const GeneralFormPage({Key? key}) : super(key: key);

  @override
  State<GeneralFormPage> createState() => _GeneralFormPageState();
}

class _GeneralFormPageState extends State<GeneralFormPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

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
            ],
          ),
        ),
      ),
    );
  }
}
