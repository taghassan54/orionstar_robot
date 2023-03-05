import 'package:flutter/foundation.dart';

class PaginationState<T> {
  int currentPage = 1;
  int totalPageCount = 1;
  bool onFetching = true;
  List<T> listItems = [];

  bool get hasMore => totalPageCount >= currentPage;

  void gotNextPageData(List<T> nextItems, int totalPage) {
    totalPageCount = totalPage;
    ++currentPage;

    onFetching = false;
    listItems.addAll(nextItems);

  }

  void sendRequestForNextPage(){
    onFetching = true;
  }

  void dispose() {
    onFetching = true;
    totalPageCount = 1;
    currentPage = 1;
    listItems.clear();
  }
}
