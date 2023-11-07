
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatelessWidget {
  String imagePath;
  ImageDialog(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width-800,
        height: MediaQuery.of(context).size.width-200,
        child: Stack(
          children: [
            imagePath != "" ?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  /*image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.fill
                  )*/
              ),
              child: PhotoView(
                  backgroundDecoration: BoxDecoration(color: Colors.grey[100]),
                  imageProvider: NetworkImage(imagePath)),
            ): Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Text(
                "(Image not uploaded)",
                style: TextStyle(fontSize: 18,color: Colors.red),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: IconButton(
                  icon: Icon(Icons.close,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}