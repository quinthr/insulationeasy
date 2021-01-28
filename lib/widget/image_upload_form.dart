import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../install_form.dart';
import '../models/FormImages.dart';

class ImageUploadForm extends StatefulWidget {
  @override
  _ImageUploadFormState createState() => _ImageUploadFormState();
}

Future<dynamic> fetchAndSetFormDataImages() async {
  final dataList =
  await FormImagesDB.getAll(await generateFormId());
  var formData = dataList.map(
        (item) => FormImages(
      imageData: item['imageData'],
      imageName: item['imageName'],
      indexnum: item['indexnum'],
    ),
  ).toList();
  if (formData == null){
    return 0;
  }
  return formData;
}

class _ImageUploadFormState extends State<ImageUploadForm> {
  String _intFormId = '';
  String _intUser = '';
  List<Asset> images = List<Asset>();
  List<Image> images2 = List<Image>();
  String _error = 'No Error Dectected';
  @override
  void initState() {
    super.initState();
  }
  _ImageUploadFormState() {
    fetchFormData().then((val) => setState(() {
      _intFormId = val[0].formId.toString();
    }));
    fetchAndSetFormDataImages().then((val3) => setState(() {
      if(val3.isEmpty){
        print('Empty');
      }
      else {
        List<Image> imageList = List<Image>();
        for(var i=0; i<val3.length; i++){
          if(val3[i].imageData != null){
            final Image image = Image.memory(val3[i].imageData);
            imageList.add(image);
          }
        }
        setState(() {
          images2 = imageList;
        });
      }
    }));
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(images2.length, (index) {
        Image image = images2[index];
        return image;
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    List<Image> imageList = List<Image>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FA9300",
          actionBarTitle: "Select Photos",
          allViewTitle: "Select Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#FA9300",
        ),
      );
      for(var i=0; i<resultList.length; i++){
        final ByteData byteData = await resultList[i].getByteData(quality: 20);
        final Image image = Image.memory(byteData.buffer.asUint8List());
        FormImagesDB.insert('installation_form_images', {
          'imageData': byteData.buffer.asUint8List(),
          'imageName': _intFormId+'-'+i.toString(),
          'indexnum': i,
          'formId': _intFormId,
          'status': 'Ongoing'
        });
        imageList.add(image);
      }
      for(var j=resultList.length; j<10; j++){
        FormImagesDB.insert('installation_form_images', {
          'imageData': null,
          'imageName': _intFormId+'-'+j.toString(),
          'indexnum': j,
          'formId': _intFormId,
          'status': 'Ongoing'
        });
      }
      setState(() {
        images = resultList;
        images2 = imageList;
      });
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _error = error;
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Images", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("4/6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchFormData(),
            builder: (ctx, snapshot) => Container(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      SizedBox(
                        height: deviceSize.height * 0.75,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            Expanded(
                              child: buildGridView(),
                            ),
                            RaisedButton(
                              onPressed: () { loadAssets(); },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFFF9800),
                                      Color(0xFFFB8C00),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                    'Add Images',
                                    style: TextStyle(fontSize: 14)
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    child: Text(
                                      'Upload at least 6 pictures including the site board:',
                                      textAlign: TextAlign.left,
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: RouteSettings(name: "installForm"),
                                    builder: (context) => InstallForm()),
                              );
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              //if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              //  Scaffold.of(context)
                              //      .showSnackBar(SnackBar(content: Text('Processing Data')));
                              //}
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]))
            )
        )
    );
  }
}