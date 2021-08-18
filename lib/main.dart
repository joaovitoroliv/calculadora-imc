import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

//Criar um Stateful Widget
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Declaramos o peso
  TextEditingController weightController = TextEditingController();

  //Declaramos a altura
  TextEditingController heightController = TextEditingController();

  //Chave Global
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    //Setar o estado para Informe seus dados
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      //double.parse transforma o conteudo de weightController.text em double
      double weight = double.parse(weightController.text);
      double height =
          double.parse(heightController.text) / 100; //Pegar altura em metros
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          //Icone Refresh
          IconButton(onPressed: _resetField, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //colocar pagina para rolar para não sobrepor informação
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //recuo
        child: Form(
          //Validar os campos
          key: _formKey,
          child: Column(
            //Centralizar em linha - em cross
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //Criar os widgets da coluna
            children: [
              //Imagem
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              //Campo para digitar o peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                //Avisar quem são os meus controladores
                controller: weightController,
                //Null Safety
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso!";
                  }
                }),
              //Campo para digitar a altura
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  //Avisar quem são os meus controladores
                  controller: heightController,
                  //Null Safety
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua altura";
                    }
                  }),
              //Botao com fundo verde
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    //Função ao pressionar
                    onPressed: (){
                      //Null Safety
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
