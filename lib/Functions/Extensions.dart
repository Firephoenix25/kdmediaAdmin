extension WhatA on String {
  String toQueryCities() {
    String s = this;
    List list = s.split("/");
    print(s);

    s = list[list.length - 1];
    String len = list[list.length - 1].split("+")[0].length.toString();
    s = s.substring(int.parse(len) + 1);
    return s;
  }
}
