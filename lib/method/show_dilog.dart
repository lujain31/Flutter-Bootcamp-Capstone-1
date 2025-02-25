import 'package:flutter/material.dart';
import 'package:team_hack/screens/hackathon_detail_screen/widgets/primary_button.dart';

showsuccessDiolg({required BuildContext context, String? successMessage}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Image.asset(
                "assets/images/success_icon.png",
                width: 180,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  const Text(
                    "Success",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xff07CC66),
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    successMessage!,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 18,
                    title: "Done",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
