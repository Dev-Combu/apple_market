import 'package:apple_market/ui/detail/detail_page.dart';
import 'package:apple_market/ui/viewmodel/product_view_model.dart';
import 'package:apple_market/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
// 상단이동 버튼이 표시(visible)되어야하는지 판단용 변수
  bool _showBackToTopButton = false;

  // 스크롤 컨트롤러
  late ScrollController _scrollController;

  // onpressed 상태
  bool buttonOnpressed = false;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 1) {
            _showBackToTopButton = true; // 버튼 표시(visible = true)
          } else {
            _showBackToTopButton = false; // 버튼 숨김(visible = false)
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 컨트롤러 메모리 해제
    super.dispose();
  }

  // 스크롤 최상단 이동 버튼을 눌렀을 때, 리스트의 최상단으로 이동하는 코드
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

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
        controller: _scrollController,
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
                          price: result.price)));
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('상품 삭제'),
                  content: Text('이 상품을 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(), // 취소
                      child: Text('취소'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        setState(() {
                          state.removeAt(index);
                        });
                      },
                      child: Text('삭제'),
                    ),
                  ],
                ),
              );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.title,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(result.address),
                            Text(
                              NumberFormatter.format(result.price),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      floatingActionButton: AnimatedOpacity(
        opacity: _showBackToTopButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: ElevatedButton(
          onPressed: () {
            _scrollToTop();
          },
          style: ButtonStyle(
              side: WidgetStatePropertyAll(BorderSide(width: 1)),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              overlayColor: WidgetStateProperty.all(Colors.blue),
              shape: WidgetStatePropertyAll(CircleBorder()),
              fixedSize: WidgetStatePropertyAll(Size(100, 60)),
              iconSize: WidgetStatePropertyAll(40)),
          child: Icon(
            Icons.vertical_align_top,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
