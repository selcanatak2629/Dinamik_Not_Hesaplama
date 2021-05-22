import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  double ortalama=0;
  List<Ders> tumDersler;

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // contracter
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // klavye acılınca hatayı onler
      appBar: AppBar(
        title: Text("Benim Ortalamam"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // yatayda butun alana yaıylır
        children: [
          // STATİC FORMU TUTAN CONTAİNER
          Container(
            padding: EdgeInsets.all(12),
            //color: Colors.pink.shade300,
            child: Form(
              key: formKey,
              child: buildFormColumn(),
            ),
          ),
          // DİNAMİK LİSTEYİ TUTAN CONTAİNER
          Expanded(
            child: Container(
              color: Colors.blue.shade200,
              child: buildList(),
            ),
          )
        ],
      ),
    );
  }

// stattic form için
  Widget buildFormColumn() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Ders Adı",
            hintText: "Ders Adını Giriniz",
            border: OutlineInputBorder(),
          ),
          validator: (girilenDeger) {
            if (girilenDeger.length > 0) {
              return null;
            } else {
              return "Ders adı boş olamaz.";
            }
          },
          onSaved: (kaydedilenDeger) {
            dersAdi = kaydedilenDeger;
            setState(() {
              tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi));
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              child: buildDropDownButton(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              child: buildDropDownButton2(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
          height: 70,
          color: Colors.pink.shade200,
          child: Center(child: Text("ortalama: $ortalama")),
        )
      ],
        
    );
  }

  Widget buildDropDownButton2() {
    return DropdownButton(
      items: dersHarfDegerleritems(),
      value: dersHarfDegeri,
      onChanged: (secilenHarf) {
        setState(() {
          dersKredi = secilenHarf;
        });
      },
    );
  }

  List<DropdownMenuItem<double>> dersHarfDegerleritems() {
    List<DropdownMenuItem<double>> harfler = [];

    harfler.add(
      DropdownMenuItem(
        value: 4,
        child: Text(
          "AA",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    harfler.add(
      DropdownMenuItem(
        value: 3.5,
        child: Text(
          "BA",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    harfler.add(
      DropdownMenuItem(
        value: 3,
        child: Text(
          "BB",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    harfler.add(DropdownMenuItem(
      value: 2.5,
      child: Text(
        "CB",
        style: TextStyle(fontSize: 20),
      ),
    ));
    harfler.add(DropdownMenuItem(
      value: 2,
      child: Text(
        "CC",
        style: TextStyle(fontSize: 20),
      ),
    ));
    harfler.add(DropdownMenuItem(
      value: 1.5,
      child: Text(
        "DC",
        style: TextStyle(fontSize: 20),
      ),
    ));
    harfler.add(DropdownMenuItem(
      value: 1,
      child: Text(
        "DD",
        style: TextStyle(fontSize: 20),
      ),
    ));
    harfler.add(DropdownMenuItem(
      value: 0,
      child: Text(
        "FF",
        style: TextStyle(fontSize: 20),
      ),
    ));

    return harfler;
  }

  Widget buildDropDownButton() {
    return DropdownButton(
      items: dersKredileriItems(),
      value: dersKredi,
      onChanged: (secilenKredi) {
        setState(() {
          dersKredi = secilenKredi;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i index",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
    return krediler;
  }

  //dinamik liste için
  Widget buildList() {
    return ListView.builder(
      itemBuilder: _listeElemenOlustur,
      itemCount: tumDersler.length,
    );
  }

  Widget _listeElemenOlustur(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(tumDersler[index].ad),
        subtitle: Text(tumDersler[index].kredi.toString() +
            "kredi ders degeri" +
            tumDersler[index].harfDegeri.toString()),
      ),
    );
  }
}

// dinamik liste için model sınıf
class Ders {
  String ad;
  double harfDegeri;
  int kredi;

  Ders(this.ad, this.harfDegeri, this.kredi);
}
