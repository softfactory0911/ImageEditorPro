import 'package:flutter/material.dart';

import '../image_editor_pro.dart';

class TextAddEdit extends StatefulWidget {
  final int index;
  final Map mapValue;
  final bool isEdit;

  const TextAddEdit({
    Key key,
    this.mapValue,
    this.index,
    this.isEdit,
  }) : super(key: key);

  @override
  _TextAddEditState createState() => _TextAddEditState();
}

class _TextAddEditState extends State<TextAddEdit> {
  final formState = GlobalKey<FormState>();
  final textFieldController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      textFieldController.text = widget.mapValue['name'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  widget.isEdit ? 'Edit Text' : 'Add Text',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              TextFormField(
                controller: textFieldController,
                decoration: InputDecoration(
                  hintText: 'Insert your message',
                ),
                onChanged: (value) {
                  widgetJson[widget.index]['name'] = value;
                },
                validator: (value) {
                  return value == null || value.isEmpty ? 'Please insert your message' : null;
                },
              ),
              SizedBox(height: 8),
              Text('Size adjust'),
              Slider(
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  value: widgetJson[widget.index]['size'],
                  min: 0.0,
                  max: 100.0,
                  onChangeEnd: (value) {
                    setState(() => widgetJson[widget.index]['size'] = value.toDouble());
                  },
                  onChanged: (value) {
                    setState(() {
                      slider = value;
                      widgetJson[widget.index]['size'] = value.toDouble();
                    });
                  }),
              SizedBox(height: 8),
              widget.isEdit
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widgetJson.removeAt(widget.index);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                            ),
                            child: Text('REMOVE'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              onPrimary: Colors.white,
                            ),
                            child: Text('UPDATE'),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formState.currentState.validate()) {
                            Navigator.pop(context, true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        child: Text('SAVE TEXT'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
