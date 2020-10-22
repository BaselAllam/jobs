import 'package:flutter/material.dart';
import 'package:jobs/details.dart';
import 'package:jobs/jobmodel.dart';
import 'package:jobs/loading.dart';
//import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';



// how Provider works




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final TextEditingController searchController = TextEditingController();

bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black, size: 20.0),
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)
              ),
              height: 40.0,
                  margin: EdgeInsets.all(5.0),
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'ex: Back-end Developer',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      controller: searchController,
                      onSubmitted: (value) {
                        setState(() {
                          pressed = true;
                          context.read<JobController>().getJobs(searchController.text);
                        });
                      },
                    ),
                ),
            actions:[
               IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                searchController.clear();
                context.read<JobController>().allJobs.clear();
                setState(() {
                  pressed = false;
                });
              }
            ),
            ]
          ),
          backgroundColor: Colors.grey[100],
          body: body()
        );
      }
  body() {
    if(context.select((JobController job)=> job.isLoading == true)){
      return Center(child: Loading());
    }else if(context.select((JobController job)=> job.allJobs.length < 1)){
      return Center(child: Text('no Jobs found'));
    }else{
      return Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: pressed == false ? Center(child: Icon(Icons.search, color: Colors.grey, size: 50.0)) : 
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: context.watch<JobController>().allJobs.length,
          itemBuilder: (context, index){
            return Builder(builder: (context){
              final item = context.select((JobController job) => job.allJobs[index]);
              return Item(
                item.type,
                item.company,
                item.location,
                item.title,
                item.companyLogo,
                item.url,
              ); 
            });
          }
        ),
      );
    }
  }
}




class Item extends StatefulWidget {

final String jobType;
final String companyName;
final String location;
final String jobTitle;
final String companyLogo;
final String id;

Item(this.jobType, this.companyName, this.location, this.jobTitle, this.companyLogo, this.id);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height/2.5,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${widget.companyLogo}'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                    shape: BoxShape.rectangle,
                  ),
                  height: 100.0,
                ),
                Text(
                  'Company Name: ${widget.companyName}',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                Text(
                  'Job Location: ${widget.location}',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                Divider(color: Colors.grey, endIndent: 30.0, indent: 30.0, height: 10.0),
                Text(
                  'Job Title: ${widget.jobTitle}',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                Text(
                  'Job Type: ${widget.jobType}',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                Align(
                  alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Text(
                      'see full details',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.indigo, fontSize: 15.0, fontWeight: FontWeight.bold)
                    ),
                    onTap: () {
                      Provider.of<JobController>(context, listen: false).getSeelctedJob(widget.id);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {return Details();}));
                    },
                  ),
                ),
              ],
            ),
      );
  }
}








// how Scoped Model Works


// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

// final TextEditingController searchController = TextEditingController();

// bool pressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<JobController>(
//       builder: (context, child, JobController job){
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0.0,
//             backgroundColor: Colors.transparent,
//             iconTheme: IconThemeData(color: Colors.black, size: 20.0),
//             title: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15.0)
//               ),
//               height: 40.0,
//                   margin: EdgeInsets.all(5.0),
//                   child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         labelText: 'ex: Back-end Developer',
//                         labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
//                       ),
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.search,
//                       controller: searchController,
//                       onSubmitted: (value) {
//                         setState(() {
//                           pressed = true;
//                           job.getJobs(searchController.text);
//                         });
//                       },
//                     ),
//                 ),
//             actions:[
//                IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 searchController.clear();
//                 job.allJobs.clear();
//                 setState(() {
//                   pressed = false;
//                 });
//               }
//             ),
//             ]
//           ),
//           backgroundColor: Colors.grey[100],
//           body: body()
//         );
//       }
//     );
//       }
//   body() {
//     return Container(
//         margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
//         child: pressed == false ? Center(child: Icon(Icons.search, color: Colors.grey, size: 50.0)) : 
//         ScopedModelDescendant<JobController>(
//           builder: (context, child, JobController controller){
//             if(controller.isLoading == true){
//               return Center(child: Loading());
//             }else if(controller.allJobs.length < 1){
//               return Center(child: Text('No Job Found'));
//             }else{
//               return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: controller.allJobs.length,
//                 itemBuilder: (context, index){
//                   return Item(
//                     controller.allJobs[index].type,
//                     controller.allJobs[index].company,
//                     controller.allJobs[index].location,
//                     controller.allJobs[index].title,
//                     controller.allJobs[index].companyLogo,
//                     controller.allJobs[index].id
//                   );
//                 }
//               );
//             }
//           }
//         ),
//       );
//   }
// }




// class Item extends StatefulWidget {

// final String jobType;
// final String companyName;
// final String location;
// final String jobTitle;
// final String companyLogo;
// final String id;

// Item(this.jobType, this.companyName, this.location, this.jobTitle, this.companyLogo, this.id);

//   @override
//   _ItemState createState() => _ItemState();
// }

// class _ItemState extends State<Item> {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<JobController>(
//       builder: (context, child, JobController job){
//         return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//           color: Colors.white,
//         ),
//         height: MediaQuery.of(context).size.height/2.5,
//         margin: EdgeInsets.all(10.0),
//         padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage('${widget.companyLogo}'),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
//                     shape: BoxShape.rectangle,
//                   ),
//                   height: 100.0,
//                 ),
//                 Text(
//                   'Company Name: ${widget.companyName}',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
//                 ),
//                 Text(
//                   'Job Location: ${widget.location}',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
//                 ),
//                 Divider(color: Colors.grey, endIndent: 30.0, indent: 30.0, height: 10.0),
//                 Text(
//                   'Job Title: ${widget.jobTitle}',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
//                 ),
//                 Text(
//                   'Job Type: ${widget.jobType}',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal)
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                     child: InkWell(
//                       child: Text(
//                       'see full details',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(color: Colors.indigo, fontSize: 15.0, fontWeight: FontWeight.bold)
//                     ),
//                     onTap: () {
//                       job.getSeelctedJob(widget.id);
//                       Navigator.push(context, MaterialPageRoute(builder: (_) {return Details();}));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//       );
//       }
//     );
//   }
// }