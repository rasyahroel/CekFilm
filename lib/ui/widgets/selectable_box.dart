part of 'widgets.dart';

class SelectedTableBox extends StatefulWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  SelectedTableBox(this.text,
      {this.isSelected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 60,
      this.onTap,
      this.textStyle});

  @override
  _SelectedTableBoxState createState() => _SelectedTableBoxState();
}

class _SelectedTableBoxState extends State<SelectedTableBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap();
          }
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: (!widget.isEnabled)
                  ? Colors.white
                  : widget.isSelected
                      ? yellowPrimary
                      : Colors.transparent,
              border: Border.all(
                  color: (!widget.isEnabled)
                      ? yellowPrimary
                      : widget.isSelected
                          ? Colors.transparent
                          : Colors.white)),
          child: Center(
            child: Text(
              widget.text ?? "None",
              style: (widget.textStyle ?? whiteTextFont)
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ));
  }
}
