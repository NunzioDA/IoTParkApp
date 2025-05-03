import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class TemperatureSetPage extends StatefulWidget {
  final int startTemperature;
  const TemperatureSetPage({
    super.key,
    this.startTemperature = 21,
  });

  @override
  State<TemperatureSetPage> createState() => _TemperatureSetPageState();
}

class _TemperatureSetPageState extends State<TemperatureSetPage> {
  late GlobalKey<FormState> formKey;
  int choosenTemperature = 20;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Desired Temperature"),
                      const Gap(20),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          controller: TextEditingController(text: widget.startTemperature.toString()),
                          decoration: InputDecoration(label: Text("Temperature")),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the temperature';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if(value!="") choosenTemperature = int.parse(value);
                          },
                        ),
                      ),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: (){
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pop(choosenTemperature);
                          }
                        }, 
                        child: Text("Got it!")
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}

