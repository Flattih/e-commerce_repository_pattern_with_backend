import 'package:dio/dio.dart';
import 'package:e_commerce/utils/app_constants.dart';

class PopularProductRepo {
  late Dio dio;
  PopularProductRepo({required this.dio}) {
    dio = Dio(BaseOptions());
  }

  getPopularProductData() async {
    try {
      var response = await dio
          .get(AppConstants.BASE_URL + AppConstants.POPULAR_PRODUCT_URI);
      if (response.statusCode == 429) {}

      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
