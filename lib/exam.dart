import 'package:flutter/material.dart';

void main() {
  runApp(OnetScreen());
}

class OnetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('O-NET'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox(), // ลบปุ่มย้อนกลับที่อยู่ใน AppBar
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink[100]!,
                  Colors.orange[100]!,
                  Colors.purple[100]!
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // เพิ่ม Stack เพื่อให้ BackButton อยู่ใน CircleAvatar
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25, // ขนาดของ CircleAvatar
                                  backgroundColor: Colors.pink,
                                  child: BackButton(
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 10, // ขนาดของวงกลมสีเขียว
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16), // ระยะห่างระหว่าง CircleAvatar กับข้อความ
                            Text(
                              'O-NET',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: ListTile(
                                leading: Text(
                                  '256${3 - index}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text('ภาษาอังกฤษ'),
                                subtitle: Text('80 ข้อ'),
                                trailing: InkWell(
                                  onTap: () {},
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
