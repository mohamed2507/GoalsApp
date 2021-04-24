import 'package:flutter/material.dart';

//import 'package:graphview/Graph.dart';
import 'package:graphview/GraphView.dart';
/*import 'package:graphview/Layout.dart';
import 'package:graphview/edgerenderer/ArrowEdgeRenderer.dart';
import 'package:graphview/edgerenderer/EdgeRenderer.dart';
import 'package:graphview/forcedirected/FruchtermanReingoldAlgorithm.dart';
import 'package:graphview/layered/SugiyamaAlgorithm.dart';
import 'package:graphview/layered/SugiyamaConfiguration.dart';
import 'package:graphview/layered/SugiyamaEdgeData.dart';
import 'package:graphview/layered/SugiyamaEdgeRenderer.dart';
import 'package:graphview/layered/SugiyamaNodeData.dart';
import 'package:graphview/tree/BuchheimWalkerAlgorithm.dart';
import 'package:graphview/tree/BuchheimWalkerConfiguration.dart';
import 'package:graphview/tree/BuchheimWalkerNodeData.dart';
import 'package:graphview/tree/TreeEdgeRenderer.dart';*/


class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {


  int n = 1;
  Widget getNodeText() {
    return Container(
        padding: EdgeInsets.all(16),
          color: Colors.green,
        child: Text("Node ${n++}"));
  }


  final Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
void initState() {
    final Node node1 = Node(getNodeText());
    final Node node2 = Node(getNodeText());
    final Node node3 = Node(getNodeText());
    final Node node4 = Node(getNodeText());
    final Node node5 = Node(getNodeText());
    final Node node6 = Node(getNodeText());
    final Node node8 = Node(getNodeText());
    final Node node7 = Node(getNodeText());
    final Node node9 = Node(getNodeText());
    final Node node10 = Node(getNodeText());
    final Node node11 = Node(getNodeText());
    final Node node12 = Node(getNodeText());

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3);
    graph.addEdge(node1, node4);
    graph.addEdge(node1, node5);
    graph.addEdge(node1, node6);
    graph.addEdge(node1, node7);
    graph.addEdge(node1, node8);


    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: InteractiveViewer(
         constrained: false,
         boundaryMargin: EdgeInsets.all(50),
         minScale: 0.01,
         maxScale: 5.6,
         child: GraphView(
           graph: graph,
            algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            paint: Paint()
              ..color = Colors.green
              ..strokeWidth = 1
              ..style = PaintingStyle.stroke,
           
         ),

         ),
       
    );
  }
}