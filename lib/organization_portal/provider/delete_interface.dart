
import '../model/truck_load_model.dart';

abstract class DeletePostInf {

  void deleteOwnPost(int postId,int index);

  void rePost(TruckLoad truckLoad,bool isCityInterchange);

}