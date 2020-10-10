import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Job{

  String id;
  String type;
  String url;
  String company;
  String companyUrl;
  String location;
  String title;
  String description;
  String howToApply;
  String companyLogo;

  Job({this.id, this.type, this.url, this.company, this.companyUrl, this.location, this.title, this.description, this.howToApply, this.companyLogo});
}




class JobController extends Model{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Job> _allJobs = [];
  List<Job> get allJobs => _allJobs;


  String _selectedJobId;
  String get selectedJobId => _selectedJobId;

  Job get selectedJob {
    return _allJobs.firstWhere((Job job){
      return job.id == _selectedJobId;
    });
  }


  getSeelctedJob(String id){
    return _selectedJobId = id;
  }


  getJobs(String search) async {

    _isLoading = true;
    notifyListeners();

    http.Response _response = await http.get(
      'https://jobs.github.com/positions.json?search=$search',
      headers: {
        'content-type' : 'application/json; charset=utf-8',
      },
    );

    var _convert = json.decode(_response.body);
    _convert.forEach((i) {
      if(_response.statusCode == 200){
        final Job _newJob = Job(
          id: i['id'],
          type: i['type'],
          url: i['url'],
          company: i['company'],
          companyUrl: i['company_url'],
          location: i['location'],
          title: i['title'],
          description: i['description'],
          howToApply: i['how_to_apply'],
          companyLogo: i['company_logo']
        );
        _allJobs.add(_newJob);
        _isLoading = false;
        notifyListeners();
      }else{
        _isLoading = false;
        notifyListeners();
      }
    });
  }


}