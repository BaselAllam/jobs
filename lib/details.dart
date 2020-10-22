import 'package:flutter/material.dart';
import 'package:jobs/jobmodel.dart';
//import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';



// how Provider works



class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text('Job Details',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
          child: Builder(builder: (context) {
            final item = context.select((JobController job) => job.selectedJob);
            return Column(
            children: [
              Flexible(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${item.companyLogo}'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                            height: 100.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Company Name: ${item.company}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: Text('Company Site',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              onTap: () {
                                launch('${item.companyUrl}');
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
                      padding: EdgeInsets.all(5.0),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          ListTile(
                            title: Text('Job Title:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal)
                              ),
                            subtitle: Text('${item.title}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)
                              ),
                          ),
                          ListTile(
                            title: Text('Job Location:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal)
                              ),
                            subtitle: Text('${item.location}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)
                              ),
                          ),
                          ListTile(
                            title: Text('Job Type:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal)
                              ),
                            subtitle: Text('${item.type}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)
                              ),
                          ),
                          ListTile(
                            title: Text('Job Description:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal)
                              ),
                            subtitle: Text('${item.description}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                bottom: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                          child: Text(
                            'See Job on site',
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          color: Colors.green,
                          onPressed: () {
                            launch('${item.url}');
                          }),
                      FlatButton(
                          child: Text(
                            'Apply',
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          color: Colors.indigo,
                          onPressed: () {
                            launch('${item.howToApply}');
                          }),
                    ],
                  ),
                ),
              ),
            ],
          );
          }),
        ),
    );
  }
}






// how Scoped model works


// class Details extends StatefulWidget {
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         iconTheme: IconThemeData(color: Colors.black, size: 20.0),
//         title: Text('Job Details',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold)),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: ScopedModelDescendant<JobController>(
//         builder: (context, child, JobController job){
//           return Container(
//           child: Column(
//             children: [
//               Flexible(
//                 child: ListView(
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height / 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage('${job.selectedJob.companyLogo}'),
//                                 fit: BoxFit.fill,
//                               ),
//                               shape: BoxShape.circle,
//                             ),
//                             height: 100.0,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text('Company Name: ${job.selectedJob.company}',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                           Align(
//                             alignment: Alignment.center,
//                             child: InkWell(
//                               child: Text('Company Site',
//                                   textAlign: TextAlign.end,
//                                   style: TextStyle(
//                                       color: Colors.indigo,
//                                       fontSize: 20.0,
//                                       fontWeight: FontWeight.bold)),
//                               onTap: () {
//                                 launch('${job.selectedJob.companyUrl}');
//                               }
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
//                       padding: EdgeInsets.all(5.0),
//                       child: ListView(
//                         scrollDirection: Axis.vertical,
//                         children: [
//                           ListTile(
//                             title: Text('Job Title:',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                             subtitle: Text('${job.selectedJob.title}',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                           ),
//                           ListTile(
//                             title: Text('Job Location:',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                             subtitle: Text('${job.selectedJob.location}',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                           ),
//                           ListTile(
//                             title: Text('Job Type:',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                             subtitle: Text('${job.selectedJob.type}',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                           ),
//                           ListTile(
//                             title: Text('Job Description:',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                             subtitle: Text('${job.selectedJob.description}',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.normal)
//                               ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SafeArea(
//                 bottom: true,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       FlatButton(
//                           child: Text(
//                             'See Job on site',
//                             style: TextStyle(color: Colors.white, fontSize: 15.0),
//                           ),
//                           color: Colors.green,
//                           onPressed: () {
//                             launch('${job.selectedJob.url}');
//                           }),
//                       FlatButton(
//                           child: Text(
//                             'Apply',
//                             style: TextStyle(color: Colors.white, fontSize: 15.0),
//                           ),
//                           color: Colors.indigo,
//                           onPressed: () {
//                             launch('${job.selectedJob.howToApply}');
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//         }
//       ),
//     );
//   }
// }
