import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget placeholderImage() {
  return SvgPicture.asset(
    "assets/icons/book_placeholder.svg",
    color: Colors.green.shade400.withOpacity(0.2),
    fit: BoxFit.cover,
  );
}

Widget networkImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
  );
}
