import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/item_home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Alerta Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              ItemHomeWidget(
                title: "Noticias",
                image: "https://images.pexels.com/photos/3856050/pexels-photo-3856050.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              ),

              ItemHomeWidget(
                title: "Personal",
                image: "https://images.pexels.com/photos/1557547/pexels-photo-1557547.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              ),

            ],
          ),
        ),
      ),
    );
  }
}


