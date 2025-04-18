import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.image,
      required this.title,
      required this.address,
      required this.description,
      required this.seller,
      required this.price});

  final String image;
  final String title;
  final String address;
  final String description;
  final String seller;
  final String price;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상품 상세"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(widget.image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 70,
                        color: Colors.orange,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.seller,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "39.3 C",
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(widget.address), Text("매너온도")],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.favorite_border),
            ),
            Spacer(),
            Text("${widget.price}원", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(width: 70),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.orange)),
              child: Text(
                "채팅하기",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
