import 'package:flutter/material.dart';

class PagaManager {
  PagaManager(this._pageController);

  PageController _pageController;
  int curPage = 0;

  void setpage(int page) {
    if (page == curPage)
      return;
    else {
      _pageController.jumpToPage(page);
      this.curPage = page;
    }
  }
}
