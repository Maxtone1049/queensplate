// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../assets/app_colors.dart';

// enum ProfileOptionAction { viewImage, profileCamera, library, remove }

// class PhotoManager {
//   File? file;

//   Future<File?> pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ['png', 'jpg'],
//           allowMultiple: true);

//       if (result != null) {
//         file = File(result.files.single.path!);
//       } else {
//         // User canceled the picker
//       }
//       return file;
//     } catch (e) {
//       debugPrint('Error picking file: $e');
//       return null;
//     }
//   }

//   Future<void> pickImage(
//       {@required BuildContext? context, Function(File? file)? file}) async {
//     ProfileOptionAction? action;
//     if (Platform.isAndroid) {
//       action = await showModalBottomSheet(
//           context: context!,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(25.r))),
//           builder: (context) => BottomSheet(
//               onClosing: () {},
//               builder: (context) => Wrap(
//                     children: <Widget>[
//                       ListTile(
//                           title: Center(
//                             child: Text(
//                               'Take Photo',
//                               style: TextStyle(
//                                   color: AppColors.primary,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           onTap: () => Navigator.pop(
//                               context, ProfileOptionAction.profileCamera)),
//                       const Divider(),
//                       ListTile(
//                           title: Center(
//                             child: Text(
//                               'Choose Photo',
//                               style: TextStyle(
//                                   color: AppColors.primary,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           onTap: () => Navigator.pop(
//                               context, ProfileOptionAction.library)),
//                       InkWell(
//                         onTap: () =>
//                             Navigator.pop(context, ProfileOptionAction.remove),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(12.0),
//                           color: Colors.grey[200],
//                           child: Center(
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )));
//     } else if (Platform.isIOS) {
//       action = await showModalBottomSheet(
//           backgroundColor: Colors.transparent,
//           context: context!,
//           builder: (context) => CupertinoActionSheet(
//                   actions: <Widget>[
//                     CupertinoButton(
//                         child: Text(
//                           'Take Photo',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         onPressed: () => Navigator.pop(
//                             context, ProfileOptionAction.profileCamera)),
//                     CupertinoButton(
//                         child: Text(
//                           'Choose Photo',
//                           style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         onPressed: () => Navigator.pop(
//                             context, ProfileOptionAction.library)),
//                   ],
//                   cancelButton: CupertinoButton(
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                       onPressed: () => Navigator.pop(context))));
//     }

//     if (action == null) return;
//     final getFile = await handleProfileAction(context!, action: action);
//     file!(getFile as File?);
//   }

//   Future<XFile?>? handleProfileAction(BuildContext context,
//       {@required ProfileOptionAction? action}) {
//     switch (action!) {
//       case ProfileOptionAction.viewImage:
//       case ProfileOptionAction.library:
//         return _getImage(context, ImageSource.gallery);
//       case ProfileOptionAction.profileCamera:
//         return _getImage(context, ImageSource.camera);
//       case ProfileOptionAction.remove:
//         break;
//     }
//     return null;
//   }

//   Future<XFile?> _getImage(BuildContext context, ImageSource source) async {
//     final picker = ImagePicker();

//     try {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         return pickedFile;
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//     }
//     return null;
//   }

//   Future<File?> _cropImage(BuildContext context, XFile imageFile) async {
//     final img = ImageCropper();
//     final croppedImage = await img.cropImage(
//         sourcePath: imageFile.path,
//         maxWidth: 1080,
//         maxHeight: 1080,
//         aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//         // aspectRatioPresets: [
//         //   CropAspectRatioPreset.square,
//         //   CropAspectRatioPreset.ratio3x2,
//         //   CropAspectRatioPreset.original,
//         //   CropAspectRatioPreset.ratio4x3,
//         //   CropAspectRatioPreset.ratio16x9
//         // ],
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'BillTopng',
//               toolbarColor: Colors.black,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(minimumAspectRatio: 1.0)
//         ]);
//     // final response = await _compressImageFiles(croppedImage!);
//     // return response;
//   }

//   // Future<File?> _compressImageFiles(CroppedFile mFile) async {
//   //   final dir = await AppHelpers.findLocalPath();
//   //   final ext = mFile.path.split('.').last;
//   //   final targetPath =
//   //       "${dir.absolute.path}/${AppHelpers.generateKey(15)}.$ext";

//   //   XFile? result = await FlutterImageCompress.compressAndGetFile(
//   //       mFile.path, targetPath,
//   //       quality: 10);

//   //   return File(result?.path ?? '');
//   // }
// }
