part of 'shared.dart';

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}

Widget flushBar(String message, Color colors, BuildContext context) {
  return Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      duration: Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: colors,
      message: message)
    ..show(context);
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

void getSnackbar(String title, String message,
    {EdgeInsets margin = const EdgeInsets.all(12),
    Color backgroundColor = Colors.white70,
    SnackPosition position = SnackPosition.BOTTOM}) {
  return Get.snackbar(title, message,
      margin: margin,
      backgroundColor: backgroundColor,
      snackPosition: position);
}
