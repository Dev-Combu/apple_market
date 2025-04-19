//번호,이미지 파일명,상품명,상품 소개,판매자,가격,주소,좋아요,채팅
class Product {
  final int id;
  final String imageFileName;
  final String title;
  final String description;
  final String seller;
  final int price;
  final String address;
  int likes;
  final int chats;
  bool isliked;

  Product({
    required this.id,
    required this.imageFileName,
    required this.title,
    required this.description,
    required this.seller,
    required this.price,
    required this.address,
    required this.likes,
    required this.chats,
    required this.isliked,
  });

  factory Product.fromCsv(List<dynamic> csvRow) {
    return Product(
      id: int.parse(csvRow[0].toString()),
      imageFileName: csvRow[1].toString(),
      title: csvRow[2].toString(),
      description: csvRow[3].toString(),
      seller: csvRow[4].toString(),
      price: int.parse(csvRow[5].toString()),
      address: csvRow[6].toString(),
      likes: int.parse(csvRow[7].toString()),
      chats: int.parse(csvRow[8].toString()),
      isliked: csvRow[9].toString().toLowerCase() == 'false',
    );
  }
}
