import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shopApp/search_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/endpoints.dart';
import 'states.dart';

class SearchShopCubit extends Cubit<SearchStates> {
  SearchShopCubit() : super(SearchInitialState());

  static SearchShopCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(
    String text,
  ) {
    emit(SearchLoadingstat());
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSucessState());
    }).catchError((e) {
      emit(SearchErrorState());
    });
  }
}
