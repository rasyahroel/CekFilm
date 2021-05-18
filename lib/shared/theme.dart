part of 'shared.dart';

const double defaultMargin = 24;
const animationDuration = Duration(milliseconds: 200);

Color blackPrimary = Color(0xFF1A1A1A);
Color redPrimary = Color(0xFFFF443A);
Color yellowPrimary = Color(0xFFDAA004);
Color accentColor2 = Color(0xFFADADAD);
Color accentColor1 = Color(0xFFFFC727);
Color accentColor3 = Color(0xFFE62525);

TextStyle blackTextFont = GoogleFonts.quicksand()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w400);
TextStyle whiteTextFont = GoogleFonts.quicksand()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w400);
TextStyle yellowTextFont = GoogleFonts.quicksand()
    .copyWith(color: yellowPrimary, fontWeight: FontWeight.w400);
TextStyle redTextFont = GoogleFonts.quicksand()
    .copyWith(color: redPrimary, fontWeight: FontWeight.w400);
TextStyle greyTextFont = GoogleFonts.quicksand()
    .copyWith(color: accentColor2, fontWeight: FontWeight.w400);

TextStyle whiteNumberFont =
    GoogleFonts.quicksand().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.quicksand().copyWith(color: accentColor2);
