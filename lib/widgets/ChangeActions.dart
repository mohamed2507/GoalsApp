import 'package:flutter/material.dart';
import '../classes/classes.dart';
import 'package:graphview/GraphView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
class ActionsChangePage extends StatefulWidget {
  final data;
 ActionsChangePage({Key key,this.data}) : super(key: key);
  @override
   ActionsChangePageState createState() =>  ActionsChangePageState();
}
class  ActionsChangePageState extends State <ActionsChangePage> {
  bool bottom=false;
  Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  List<TextEditingController> controllers=[];
  ValueKey onPressedKeyNode;
  List<Node> nodes=[];
  Node goalNode;
  List<ActionToDo>actions=[];
  int n=0;
    Widget getNodeText(textAction,bool done) {
    ValueKey key=ValueKey(n);
    n+=1;
    TextEditingController a=new TextEditingController();
    controllers.add(a);
    a.text=textAction;
    return GestureDetector(
      onLongPress: ()
      {
        setState(() {
                  bottom=!bottom;
                  onPressedKeyNode=key;
                  
                });
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 200,
          minHeight: 70
        ),
        child: Container( 
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(width: !done?1:2.5,color:!done?Colors.blue:Colors.greenAccent),
            borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: a,
            cursorColor: Colors.black,
            style: GoogleFonts.pacifico(
              fontSize: 20
            ),       
          ) 
        )
      ),
    );
  }


  @override
  void initState() { 
    super.initState();
    goalNode=Node(
      ConstrainedBox(
        constraints: BoxConstraints(
        maxWidth: double.infinity,
        minHeight: 100 
      ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20)
            
          ),
          
          child: Text(widget.data['goal'],
            style: GoogleFonts.pacifico(
              fontSize: 30
            ),
          )
        )
      )
    );
    graph.addNode(goalNode);
    if(widget.data['actions']!=null){
    for (ActionToDo action in widget.data['actions'])
    {
      actions.add(action);
      Node node=Node(getNodeText(action.name,action.finished));
      nodes.add(node);
      graph.addNode(node);
      graph.addEdge(goalNode,node,paint:Paint()..color=Colors.green[400]);
    }}
      builder
    ..siblingSeparation = (100)
    ..levelSeparation = (150)
    ..subtreeSeparation = (150)
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;       
  }
  Widget buttomBar()
  {
    return AnimatedContainer(
      duration: Duration(seconds: 4),
      child:BottomAppBar(  
        child: Row(
          children: [
            IconButton(
              icon:Icon(Icons.cancel),
              onPressed: (){
                setState(() {
                                  bottom=false;
                  });
              },
            ),
            IconButton(
              icon:Icon(Icons.delete),
              onPressed: (){
                Graph g=Graph();
                g=graph;
                setState(() {
                  graph.removeEdge(Edge(goalNode,nodes[onPressedKeyNode.value]));
                  graph.removeNode(nodes[onPressedKeyNode.value]);
                  nodes.removeAt(onPressedKeyNode.value);
                  controllers.removeAt(onPressedKeyNode.value);
                  bottom=false;             
                  });     
                },
              ),


            ],
          ),
        )
      ) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar:!bottom?null:buttomBar(),
      appBar: AppBar(
      
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()
            {
              addAction();
            },
          ),
        ],
          title:Text( "Add Actions"),
         elevation: 10,
         centerTitle: true,
         backgroundColor: Colors.green[300],
      ),
      body: SafeArea(
    
        child:Center(
              child:InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(50),
                minScale:0.01,
                maxScale:2.5,
                child:GraphView(
                  algorithm:  BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                  graph: graph,
                ),
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          done();
        },
        backgroundColor: Colors.green,
      ),
      resizeToAvoidBottomInset: true,
    );
  }
  void addAction()
  {
    Node w=Node(getNodeText('',false));

    setState(() { 
      nodes.add(w);
          graph.addEdge(goalNode,w,paint:Paint()..color=Colors.green[400]);
    });
  }
  void done()
  {
    List <ActionToDo>listActions=[];
    for( TextEditingController controller in controllers)
    {
      listActions.add(new ActionToDo(name: controller.text,id:Uuid().v1()));
    }

    Navigator.pop(context,listActions);
  }
  
}