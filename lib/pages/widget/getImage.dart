
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

getImage(String src, {double? height, double? width}) {
  print('imageSrc ::: ${src}');
  return src == '' || src=="string" ?/*CircleAvatar(
      radius: height!-10.r,
      backgroundImage: AssetImage('assets/user1.jpg',))*/
  Container(
    width: height==null ? 35 : height,
    height: width==null ? 35 : width,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        image: new DecorationImage(
            fit: BoxFit.fill,
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
        image: DecorationImage(
          image: NetworkImage(src),
          fit: BoxFit.fill
        )
      ),
      /*child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.grey[100]),
        imageProvider: NetworkImage(
        src)),
      ),*/
  );
}