
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

getImage(String src, {double? height, double? width}) {
  return src == "" || src =="string" ?Container(
      width: height==null ? 35 : height,
      height: width==null ? 35 : width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
          image: new DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/my_profile.png')
          )
      ))
      :
  Container(
      width: height==null ? 35 : height,
      height: width==null ? 35 : width,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
        color: Colors.grey[100],
          border: Border(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.grey[100]),
        imageProvider: NetworkImage(
        src)),
      ),
  );
}