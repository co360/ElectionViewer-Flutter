part of 'component.dart';

class XTextField extends StatelessWidget {

  final String text;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final void Function(String) onChanged;

  const XTextField({ 
  Key key,
  this.text,
  this.controller,
  this.obscureText,
  this.suffixIcon,
  this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged ?? (value) {},
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: blackSubtitleRegular.copyWith(color: greyColor),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: mainColor,
            width: 3
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: mainColor,
            width: 3
          )
        ),
      ),
    );
  }
}