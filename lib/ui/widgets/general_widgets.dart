import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';

SizedBox divider12() => const SizedBox(height: 12.0);
SizedBox divider20() => const SizedBox(height: 20.0);
SizedBox divider30() => const SizedBox(height: 30.0);
SizedBox divider40() => const SizedBox(height: 40.0);

void snackBarMessage(BuildContext context, TypeMessage typeMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: messageColor[typeMessage],
      content: Row(
        children: [
          Icon(
            messageIcon[typeMessage],
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Text(
              messages[typeMessage]!,
            ),
          ),
        ],
      ),
    ),
  );
}
