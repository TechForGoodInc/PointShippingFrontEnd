import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/classes_and_methods/package.dart';
import 'package:frontend/classes_and_methods/user.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

import 'package:frontend/checkout_page.dart';

class ARElements extends StatefulWidget {
  ARElements({this.user});
  final User user;
  _ARKitHomePage createState() => _ARKitHomePage();
}

class _ARKitHomePage extends State<ARElements> {
  ARKitController arkitController;
  ARKitPlane plane;
  ARKitNode node;
  String anchorId;
  vector.Vector3 lastPosition;
  bool confirmDimension = false;
  bool buttonStatus = true;
  double dimension;
  List<double> dimensions = [];

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: buildChildren());
  }

  List<Widget> buildChildren() {
    List<Widget> builder = [
      ARKitSceneView(
        showFeaturePoints: true,
        planeDetection: ARPlaneDetection.vertical,
        onARKitViewCreated: onARKitViewCreated,
        enableTapRecognizer: true,
      ),
    ];

    if (dimensions.length == 3) {
      builder.add(Expanded(
          child: Align(
              alignment: Alignment(0.0, 0.9),
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (buttonStatus == true) {
                    if (details.delta.dx < 0) {
                      setState(() {
                        buttonStatus = false;
                      });
                    }
                  } else {
                    if (details.delta.dx > 0) {
                      setState(() {
                        buttonStatus = true;
                      });
                    }
                  }
                },
                child: buttonStatus
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.of(context).push(_confirmSubmit());
                        },
                        backgroundColor: Colors.green,
                        splashColor: Colors.blue,
                        label: Text('Confirm'),
                        icon: Icon(
                          Icons.check,
                        ),
                      )
                    : FloatingActionButton.extended(
                        onPressed: _cancelSubmit,
                        backgroundColor: Colors.red,
                        splashColor: Colors.blue,
                        label: Text('Cancel'),
                        icon: Icon(Icons.cancel),
                      ),
              ))));
      builder.add(Expanded(
          child: Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: buttonStatus ? Colors.green : Colors.red,
            ),
            height: 150,
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dimensions[0].toStringAsFixed(2) + 'cm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  dimensions[1].toStringAsFixed(2) + 'cm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  dimensions[2].toStringAsFixed(2) + 'cm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            )),
      )));
    }

    if (confirmDimension) {
      builder.add(Expanded(
          child: Align(
        alignment: Alignment(0.0, 0.9),
        child: GestureDetector(
          onPanUpdate: (details) {
            if (buttonStatus == true) {
              if (details.delta.dx < 0) {
                setState(() {
                  buttonStatus = false;
                });
              }
            } else {
              if (details.delta.dx > 0) {
                setState(() {
                  buttonStatus = true;
                });
              }
            }
          },
          child: buttonStatus
              ? FloatingActionButton.extended(
                  onPressed: _confirmDimension,
                  backgroundColor: Colors.green,
                  splashColor: Colors.blue,
                  label: Text(dimension.toStringAsFixed(2) + 'cm'),
                  icon: Icon(
                    Icons.check,
                  ),
                )
              : FloatingActionButton.extended(
                  onPressed: _deleteDimension,
                  backgroundColor: Colors.red,
                  splashColor: Colors.red,
                  label: Text(dimension.toStringAsFixed(2) + 'cm'),
                  icon: Icon(Icons.cancel),
                ),
        ),
      )));
    }

    return builder;
  }

  Route _confirmSubmit() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CheckOutPage(
        previousPackage: false,
        package: new Package(
            width: dimensions[0], height: dimensions[1], length: dimensions[2]),
        user: widget.user,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _cancelSubmit() {
    dimensions.removeRange(0, 3);
    setState(() {
      buttonStatus = true;
    });
  }

  void _confirmDimension() {
    setState(() {
      dimensions.add(dimension);
      buttonStatus = true;
      confirmDimension = false;
      arkitController.remove('one');
      arkitController.remove('two');
      arkitController.remove('label');
      arkitController.remove('line');
      arkitController.remove('plane');
      anchorId = null;
      lastPosition = null;
    });
  }

  void _deleteDimension() {
    setState(() {
      confirmDimension = false;
      buttonStatus = true;
      arkitController.remove('one');
      arkitController.remove('two');
      arkitController.remove('label');
      arkitController.remove('line');
      arkitController.remove('plane');
      anchorId = null;
      lastPosition = null;
    });
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onARTap = (List<ARKitTestResult> ar) {
      final planeTap = ar.firstWhere(
        (tap) => tap.type == ARKitHitTestResultType.existingPlaneUsingExtent,
        orElse: () => null,
      );
      if (planeTap != null && confirmDimension != true) {
        _onPlaneTapHandler(planeTap.worldTransform);
      }
    };
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }
    if (anchorId != null) {
      _addPlane(
        arkitController,
        anchor,
      );
    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId) {
      return;
    }
    final ARKitPlaneAnchor planeAnchor = anchor;
    node.position.value =
        vector.Vector3(planeAnchor.center.x, 0, planeAnchor.center.z);
    plane.width.value = planeAnchor.extent.x;
    plane.height.value = planeAnchor.extent.z;
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;
    plane = ARKitPlane(
      width: anchor.extent.x,
      height: anchor.extent.z,
      materials: [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty(color: Colors.white),
        )
      ],
    );

    node = ARKitNode(
      name: 'plane',
      geometry: plane,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
  }

  void _onPlaneTapHandler(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y,
      transform.getColumn(3).z,
    );
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.constant,
      diffuse:
          ARKitMaterialProperty(color: const Color.fromRGBO(255, 153, 83, 1)),
    );
    final sphere = ARKitSphere(
      radius: 0.003,
      materials: [material],
    );
    final node = ARKitNode(
      name: (lastPosition != null) ? 'one' : 'two',
      geometry: sphere,
      position: position,
    );
    arkitController.add(node);
    if (lastPosition != null) {
      final line = ARKitLine(
        fromVector: lastPosition,
        toVector: position,
      );
      final lineNode = ARKitNode(geometry: line, name: 'line');
      arkitController.add(lineNode);

      final d = _calculateDistanceBetweenPoints(position, lastPosition);
      dimension = d;
      setState(() {
        confirmDimension = true;
      });
      final distance = d.toStringAsFixed(2) + 'cm';
      final point = _getMiddleVector(position, lastPosition);
      _drawText(distance, point);
    }
    lastPosition = position;
  }

  double _calculateDistanceBetweenPoints(vector.Vector3 A, vector.Vector3 B) {
    final length = A.distanceTo(B);
    return length * 100;
  }

  vector.Vector3 _getMiddleVector(vector.Vector3 A, vector.Vector3 B) {
    return vector.Vector3((A.x + B.x) / 2, (A.y + B.y) / 2, (A.z + B.z) / 2);
  }

  void _drawText(String text, vector.Vector3 point) {
    final textGeometry = ARKitText(
      text: text,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty(color: Colors.red),
        )
      ],
    );
    const scale = 0.001;
    final vectorScale = vector.Vector3(scale, scale, scale);
    final node = ARKitNode(
        geometry: textGeometry,
        position: point,
        scale: vectorScale,
        name: 'label');
    arkitController
        .getNodeBoundingBox(node)
        .then((List<vector.Vector3> result) {
      final minVector = result[0];
      final maxVector = result[1];
      final dx = (maxVector.x - minVector.x) / 2 * scale;
      final dy = (maxVector.y - minVector.y) / 2 * scale;
      final position = vector.Vector3(
        node.position.value.x - dx,
        node.position.value.y - dy,
        node.position.value.z,
      );
      node.position.value = position;
    });
    arkitController.add(node);
  }
}
