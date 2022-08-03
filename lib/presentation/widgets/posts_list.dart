import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/helpers/constants.dart';
import 'package:kortobaa/models/post.dart';
import 'package:kortobaa/presentation/widgets/post_widget.dart';
import 'package:kortobaa/providers/post_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../helpers/upload_file.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  UploadTask? task;
  File? file;
  String? urlDownload;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        StreamBuilder<List<Post>>(
            stream: Provider.of<PostsProvider>(context).readPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final posts = snapshot.data;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: posts?.length,
                  itemBuilder: (context, index) => PostWidget(
                    postId: posts![index].postId,
                    likes: posts[index].likes,
                    image: posts[index].image,
                    details: posts[index].details,
                    isBookmarked: posts[index].isFavorite,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.sh, horizontal: 0.1.sw),
          child: FloatingActionButton(
            onPressed: () {
              buildShowDialog(context);
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Future selectFile(StateSetter setState) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future<dynamic> buildShowDialog(context) {
    TextEditingController _detailsController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();
    bool _isLoading = false;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: StatefulBuilder(builder: (context, _setState) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(8.r),
            content: Form(
              key: _formKey,
              child: Container(
                height: 320.h,
                width: 344.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectFile(_setState);
                      },
                      child: file != null
                          ? SizedBox(
                              height: 157.h,
                              width: 328.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  file!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 157.h,
                              width: 328.w,
                              decoration: BoxDecoration(
                                color: kLightGrey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Color(0xffC7DCE5),
                                    size: 80,
                                  ),
                                  Text(
                                    'رفع صورة',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اكتب تعليقا حول الصورة',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    TextFormField(
                      controller: _detailsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك اكتب تعليقاً';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(
                          fontSize: 18, color: kNavyBlue, height: 1.5),
                      decoration: InputDecoration(),
                      maxLines: 2,
                      maxLength: 120,
                      cursorHeight: 30,
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('تجاهل'),
              ),
              SizedBox(
                width: 77.w,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isLoading == true) return;
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    _setState(() {
                      _isLoading = true;
                    });
                    await uploadFile().then((value) {
                      final newPost = Post(
                          details: _detailsController.text,
                          image: urlDownload ?? '',
                          likes: {});
                      Provider.of<PostsProvider>(context, listen: false)
                          .addPost(newPost);
                    });
                    _setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: _isLoading == true
                      ? SizedBox(
                          child: CircularProgressIndicator(
                            color: kOffWhite,
                          ),
                          height: 20.r,
                          width: 20.r,
                        )
                      : Text('نشر'),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
