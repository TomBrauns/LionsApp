import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/agb.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;
  bool isChecked = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController postalcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetnrController = TextEditingController();

  // For the Postal code keyboardType: TextInputType.number

  bool _isObscure = true;
  bool _isObscure2 = true;
  var rool = "friend";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 29, 89, 167),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Registrierung",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: firstnameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Vorname',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextFormField(
                              controller: lastnameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Nachname',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.name,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email darf nicht leer sein";
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              return ("Bitte gültige Email Adresse angeben");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Passwort',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Passwort darf nicht leer sein";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Bitte gültiges Passwort mit mind. 6 Zeichen angeben");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2 ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Passwort bestätigen',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text != passwordController.text) {
                              return "Passwörter stimmen nicht überein";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // Workspace for non required Data ( Postalcode, City, Street and Streetnr)
                        // TODO: Add attribute to make them optional
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: postalcodeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '* Postleizahl',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '* Stadtname',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.name,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // TODO: Add attribute to make them optional
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: streetController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '* Straßenname',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextFormField(
                              controller: streetnrController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '* Hausnummer und Adresszusatz',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.name,
                            )),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              uploadIMG();
                            },
                            icon: const Icon(Icons.camera_alt)),
                        const SizedBox(height: 24),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (checked) => setState(() {
                              isChecked = checked ?? false;
                            }),
                          ),
                          InkWell(
                              child: const Text(
                                "ABG's akzeptieren",
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AGB()),
                                );
                              }),
                        ]),

                        /*  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(RRR
                              "Rolle : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.blue[900],
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.white,
                              focusColor: Colors.white,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ), */
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                const CircularProgressIndicator();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Zurück zu Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () async {
                                setState(() {
                                  showProgress = true;
                                });

                                signUp(
                                  firstnameController.text,
                                  lastnameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  postalcodeController.text,
                                  cityController.text,
                                  streetController.text,
                                  streetnrController.text,
                                  rool,
                                );
                              },
                              child: const Text(
                                "Registrieren",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadIMG() async {
    String imageUrl = '';
    //IMAGEPICKER
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //UPLOAD TO FIREBASE
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('user_images').child(FirebaseAuth.instance.currentUser!.uid);
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));
      //Success: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
    //Store
    await referenceImageToUpload.putFile((File(file!.path)));
    //LINK IN FIRESTORE
    Map<String, dynamic> dataToUpdate = {};
    if (imageUrl != null && imageUrl.isNotEmpty) {
      dataToUpdate['image_url'] = imageUrl;
    }

    if (dataToUpdate.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(dataToUpdate);
    } else {}
  }

  void signUp(String firstname, String lastname, String email, String password, String? postalcode, String? cityname, String? streetname, String? streetnumber, String rool) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {postDetailsToFirestore(firstname, lastname, email, postalcode, cityname, streetname, streetnumber, rool)}).catchError((e) {});
    }
  }

  void postDetailsToFirestore(String firstname, String lastname, String email, String? postalcode, String? cityname, String? streetname, String? streetnumber, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'postalcode': postalcode,
      'cityname': cityname,
      'streetname': streetname,
      'streetnumber': streetnumber,
      'rool': rool,
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

// Definiere eine Funktion, um das Bild in Firebase Storage zu speichern
  Future<String> _uploadImage(File image) async {
    String? userID = FirebaseAuth.instance.currentUser!.uid;
    // Erhalte eine Referenz auf das Firebase Storage Bucket
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final Reference ref = storage.ref().child('profile_images').child(fileName);

    // Lade das Bild auf Firebase Storage hoch
    final UploadTask uploadTask = ref.putFile(image);
    final TaskSnapshot downloadUrl = (await uploadTask);

    // Speichere die Download-URL des Bildes in Firestore
    final String url = (await downloadUrl.ref.getDownloadURL());
    FirebaseFirestore.instance.collection('user_profiles').doc(userID).set({
      'profile_picture': url,
    }, SetOptions(merge: true));

    // Gib die Download-URL zurück
    return url;
  }

  Future<void> uploadFileToFirebaseStorage(File file) async {
    try {
      // Create a unique filename for the file
      String filename = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

      // Get a reference to the Firebase Storage location where we will upload the file
      final ref = FirebaseStorage.instance.ref().child(filename);

      // Upload the file to Firebase Storage
      await ref.putFile(file);

      print('File uploaded to Firebase Storage successfully');
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
    }
  }
}



/* für Flutter Web, wird das bild zerlegt, damit der Browser erlaubt es hochzuladen - funzt auch
TODO: isPlatformWEB usw.. einbauen
 Future<void> uploadIMG() async {
    //IMAGE PICKER
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //CONVERT IMAGE TO BYTES
    final bytes = await file!.readAsBytes();

    //UPLOAD TO FIREBASE
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('user_images').child(FirebaseAuth.instance.currentUser!.uid);
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //HANDLE ERRORS/SUCCESS
    try {
      //STORE THE FILE
      await referenceImageToUpload.putData(bytes);
      //SUCCESS: GET THE DOWNLOAD URL
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      //LINK IN FIRESTORE
      Map<String, dynamic> dataToUpdate = {};
      if (imageUrl != null && imageUrl.isNotEmpty) {
        dataToUpdate['image_url'] = imageUrl;
      }

      if (dataToUpdate.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(dataToUpdate);
      } else {}
    } catch (error) {
      //SOME ERROR OCCURRED
    }
  }
 */