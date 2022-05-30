import 'package:dio/dio.dart';
import 'package:e_commerce/utils/app_constants.dart';

class RecommendedProductRepo {
  late Dio dio;
  RecommendedProductRepo({required this.dio}) {
    dio = Dio(BaseOptions());
  }

  getRecommendedProductData() async {
    try {
      var response = await dio
          .get(AppConstants.BASE_URL + AppConstants.RECOMMENDED_PRODUCT_URI);

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
