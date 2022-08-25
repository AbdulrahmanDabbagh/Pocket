import 'package:flutter/material.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_constant.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      this.label,
      this.onChanged,
      this.suffixIcon,
      this.hint,
      this.obscure = false,
      this.validator})
      : super(key: key);
  final String? label;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool obscure;
  final String? hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 5, bottom: 10),
            child: Text(label!),
          ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstant.radius),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstant.radius),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstant.radius),
                borderSide: const BorderSide(color: Colors.red)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstant.radius),
                borderSide: const BorderSide(color: Colors.transparent)),
            isDense: true,
            fillColor: AppColors.gray,
            filled: true,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(minHeight: 0, maxHeight: 30),
          ),
          onChanged: onChanged,
          obscureText: obscure,
          validator: validator,
        ),
      ],
    );
  }
}
