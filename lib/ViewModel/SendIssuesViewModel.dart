import 'dart:io';
import 'package:covid19/Services/SendIssuesService.dart';
import 'package:covid19/locator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid19/ViewModel/BaseModel.dart';

class SendIssuesViewModel extends BaseModel {
  final _services = locator<SendIssuesService>();

  /// NEVER use dynamic ///
  File _image;
  dynamic _pickImageError;
  File get image => _image;
  dynamic get pickImageError => _pickImageError;

  Future<void> selectImage() async {
    setBusy();
    File selected;
    try {
      selected = await ImagePicker.pickImage(source: ImageSource.gallery);
      _image = selected;
    } catch (e) {
      _pickImageError = e;
      print(e);
      setIdle();
    }
    callForImageCropping(_image);
    setIdle();
    notifyListeners();
  }

  Future<void> callForImageCropping(File iamge) async {
    setBusy();
    File _cropped;
    try {
      _cropped = await ImageCropper.cropImage(
        sourcePath: iamge.path,
      );
      _image = _cropped ?? _image;
    } catch (e) {
      _pickImageError = e;
      print(e);
    }
    setIdle();
    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    setBusy();
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    _image = response.file;
    setIdle();
    notifyListeners();
  }

  ///Form Validation///
  String _title, _subtitle, _description, _phoneNumber;
  String get subtitle => _subtitle;
  String get description => _description;
  String get phoneNumber => _phoneNumber;
  String get title => _title;

  void addTitle(String Title) {
    setBusy();
    _title = Title;
    setIdle();
    notifyListeners();
  }

  void addsubTitle(String subTitle) {
    setBusy();
    _subtitle = subTitle;
    setIdle();
    notifyListeners();
  }

  void addDescription(String Title) {
    setBusy();
    _description = Title;
    setIdle();
    notifyListeners();
  }

  void addPhoneNumber(String Title) {
    setBusy();
    _phoneNumber = Title;
    setIdle();
    notifyListeners();
  }

  ///Publishing///
  void publishToFirebase() {
    _services.publish();
  }

  //  TODO: Always call the dispose in the Service not in the ModelClass Not in the BaseView

}
