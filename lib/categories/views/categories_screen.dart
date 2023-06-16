import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<bool> _selections = List.generate(6, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: const Text(
                "Escolha pelo menos\n 3 categorias",
                style: TextStyle(color: Colors.white,fontSize: 26,),textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selections[index] = !_selections[index];
                      });
                    },
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.asset(
                            'assets/images/image_$index.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_selections[index])
                          Container(
                            color: Colors.red.withOpacity(0.5),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    child: ElevatedButton(
                      onPressed:_onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text('PRÓXMO',style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
  void _onNextPressed(){
    Modular.to.pushNamed("/tabs");
  }
}
