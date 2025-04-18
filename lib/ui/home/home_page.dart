import 'package:apple_market/ui/detail/detail_page.dart';
import 'package:apple_market/ui/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModel);

    return Scaffold(
      appBar: AppBar(
        title: Text("르탄동"),
        centerTitle: false,
        actions: [Icon(Icons.notifications_none)],
      ),
      body: ListView.builder(
        itemCount: state.length,
        itemBuilder: (BuildContext context, int index) {
          final result = state[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                          image:
                              "assets/sample_image/${result.imageFileName}.png",
                          title: result.title,
                          address: result.address,
                          description: result.description,
                          seller: result.seller,
                          price: result.price.toString())));
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(),
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(2, 2),
                      )
                    ]),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                          "assets/sample_image/${result.imageFileName}.png"),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.title,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            Text(result.address),
                            Text(result.price.toString()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.forum),
                                SizedBox(width: 2),
                                Text(result.chats.toString()),
                                SizedBox(width: 10),
                                Icon(Icons.favorite_border),
                                SizedBox(width: 2),
                                Text(result.likes.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
