import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  ButtonState buttonState = ButtonState.idle;

  onPressed()  {
    setState(() {
      buttonState = ButtonState.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Screen'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('reports').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            List<DataRow> rows = [];

            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              rows.add(DataRow(
                cells: [
                  // DataCell(Text(data['sn'].toString())),
                  DataCell(Text(data['address'])),
                  DataCell(Text(data['category'])),
                  DataCell(Text(data['description'])),
                  DataCell(_remarkButton()),
                ],
              ));
            });

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  // DataColumn(label: Text('SN')),
                  DataColumn(
                      label: Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepOrange),
                      )),
                  DataColumn(
                      label: Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepOrange),
                      )),
                  DataColumn(
                      label: Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.deepOrange),
                  )),

                  DataColumn(
                      label: Text(
                    'Remark',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.deepOrange),
                  )),
                ],
                rows: rows,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _remarkButton() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Mark Resolved",
          icon: const Icon(Icons.send_sharp, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: const Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "Resolves",
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: (){}, height: 25, state: ButtonState.idle,
    radius: 20,
    );
  }

}
