import 'package:flutter/material.dart';
import '../classes/classes.dart';
import 'package:graphview/GraphView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
class ActionsPage extends StatefulWidget {
  final String goal; 
 ActionsPage({Key key,this.goal}) : super(key: key);
  @override
   ActionsPageState createState() =>  ActionsPageState();
}
class  ActionsPageState extends State <ActionsPage> {
  Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  List controllers=[];
  ValueKey onPressedKeyNode;
  
  bool bottom=false;
  //List<Node> nodes=[];
  List nodes=[];
  Node goalNode;

  int n=0;
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
          
          child: Text(widget.goal,
            style: GoogleFonts.pacifico(
              fontSize: 30
            ),
          )
        )
      )
    );
      builder
    ..siblingSeparation = (100)
    ..levelSeparation = (150)
    ..subtreeSeparation = (150)
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    graph.addNode(goalNode);   
  }
  Widget getNodeText(bool finished,int id) {
    ValueKey key=ValueKey(id);
    
    TextEditingController a=new TextEditingController();
    controllers.add({'controller':a,'id':id});
    return GestureDetector(

      onLongPress: ()
      {
        setState(() {
                  bottom=!bottom;
                  onPressedKeyNode=key;
                });
      },
      child: ConstrainedBox(
      //key: ValueKey(n-1),
        constraints: BoxConstraints(
          maxWidth: 200,
          minHeight: 70
        ),
        child: Container( 

          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(width: !finished?1:2.5,color:!finished?Colors.blue:Colors.greenAccent),
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
                setState(() {
                  int val=onPressedKeyNode.value;     
                  for(int i=0;i<nodes.length;i++){
                    if(nodes[i]['id']==val){
                      graph.removeNode(nodes[i]['node']);
                      graph.removeEdge(Edge(goalNode,nodes[i]['node']));
                      nodes.removeAt(i);
                      controllers.removeAt(i);
                      break;
                    }
                  }   
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
      floatingActionButton: FloatingActionButton
      (
        onPressed: (){done();},
        child: Icon(Icons.done),
        backgroundColor: Colors.greenAccent,
      ),
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
    );
  }
  void addAction()
  {
    Node w=Node(getNodeText(false,n));

    setState(() { 
      nodes.add({'node':w,'id':n});
          graph.addEdge(goalNode,w,paint:Paint()..color=Colors.green[400]);
    });
    n+=1;
   
  }
  void done()
  {
    List <ActionToDo>listActions=[];
    
    for( dynamic c in controllers)
    {
      listActions.add(new ActionToDo(name: c['controller'].text,id:Uuid().v1()));
      
    }
    Navigator.pop(context,listActions);
  }
  
}