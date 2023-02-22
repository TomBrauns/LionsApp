import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';


class EditDocumentPage extends StatefulWidget{
  final String documentId;

  EditDocumentPage({required this.documentId});

  @override
  _EditDocumentPageState createState() => _EditDocumentPageState();

}

class _EditDocumentPageState extends State<EditDocumentPage>{
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _loadDocument();
  }

  @override
  void dispose(){
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadDocument() async{
    final documentSnapshot = await FirebaseFirestore.instance.collection('events').doc(widget.documentId).get();

    if(documentSnapshot.exists){
      final data = documentSnapshot.data();
      _titleController.text = data?['eventName'] ?? '';
      _descriptionController.text = data?['eventInfo'] ?? '';
    }
  }

  Future<void> _updateDocument() async{
    if(_formKey.currentState?.validate() ?? false){
      await FirebaseFirestore.instance.collection('events').doc(widget.documentId).update({
        'eventName': _titleController.text,
        'eventInfo': _descriptionController.text,
      });
      Navigator.pop(context);
    }
  }

  Future<void> _deleteDocument() async{
    await FirebaseFirestore.instance.collection('events').doc(widget.documentId).delete();
    _eventPage();
  }

  void _eventPage(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (builder) => Events()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateDocument,
                child: Text('Speichern'),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteDocument,
              )
            ],
          ),
        ),
      ),
    );
  }





}