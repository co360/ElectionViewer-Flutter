part of 'component.dart';

class XTopBar extends AppBar {
  
  XTopBar({
    Key key,
    String textTitle,
    Widget leading,
    Color backgroundColor,
    TextStyle textStyle, 
  }) : super(
    key: key,
    backgroundColor: backgroundColor ?? whiteColor,
    centerTitle: true,
    elevation: 0,
    title: Text(textTitle, style: textStyle ?? blackTitle,),
    leading: leading
  );
}