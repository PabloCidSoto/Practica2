import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatelessWidget {
  const Opcion1Screen({Key? key}) : super(key: key);

  double calcularPropina(double total) {
    return total * .10;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtPropinaCon = TextEditingController();

    TextFormField txtPropina = TextFormField(
      controller: txtPropinaCon,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Introduce el total para capturar la propina',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Future<void> _mostrarPropina(dynamic total) async {  
      if (double.tryParse(total) != null) {
        total = double.parse(total);
        double propina = calcularPropina(total);
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Propina calculada'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Consumo total: \$$total',textAlign: TextAlign.end),
                    SizedBox(height: 8,),
                    Text('Propina: \$$propina',textAlign: TextAlign.end),
                    SizedBox(height: 8,),
                    Text('Total: \$${propina + total}', textAlign: TextAlign.end,)
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text('Error al ingresar la propina')],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de propina'),
        backgroundColor: ColorSettings.colorPrimary,
      ),      
      body: Center(
          child: Card(
            elevation: 7.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children:[
                      Icon(Icons.monetization_on,size: 50,),
                      Title(color: Colors.black,                   
                        child: Text('Propina', style: TextStyle(fontSize: 35), textAlign: TextAlign.center,)
                      ),
                    ]
                  ),
                  SizedBox( height: 8,),
                  txtPropina
                ],
              )
            )
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_mostrarPropina(txtPropinaCon.text)},
        tooltip: 'Calcular propina',
        child: const Icon(Icons.monetization_on_outlined),
      ),
    );
  }
}
