import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_property_response.dart';

const String propertyCollection = 'Property';

class FirebaseApi {
  /// [FirebaseFirestore] is a class provided by the Cloud Firestore SDK in Flutter.
  /// [instance] it singleton it provide the single shared intance throught the app
  final fireStore = FirebaseFirestore.instance;

  /// [CollectionReference] This is a class from Firestore that represents a collection in the Firestore database.
  /// It allows you to read, write, update, and delete documents in a specific collection.
  late CollectionReference propertyRef;
  FirebaseApi() {
    propertyRef = fireStore

        /// [collection(propertyCollection)] access the specific collection from firestore
        .collection(propertyCollection)

        /// in firestore stores the document in Json(Map<String, dynamic>)
        /// [withConverter] while reading it will covert json to dart object [PropertyData] and vice versa when writing.
        .withConverter<PropertyData>(

            /// [fromFirestore] Converting [Firestore Json] into [PropertyData]
            /// [snapshot] is a [DocumentSnapshot]
            fromFirestore: (snapshot, options) =>
                PropertyData.fromJson(snapshot.data()!, options),

            /// [toFirestore] converting [PropertyData] into [Firestore Json]
            /// [value] is an instance of [PropertyData].
            toFirestore: (value, options) => value.toJson());
  }

  /// it return's the real time stream data from firestore document
  Stream<QuerySnapshot> getPropertyDocument() {
    /// [propertyRef] is a reference to a Firestore collection
    /// [snapshots] return stream meaning automatically listen the changes in the firestore
    /// whenever the (update, add or delete) happens
    return propertyRef.snapshots();
  }

  /// [Future] will trigger only once and return the data and then future will go to idle state,
  /// it will not listen continuesly,
  /// if you need new data then you need to trigger the future event manually
  Future<QuerySnapshot> getdata() async {
    return propertyRef.get();
  }

  void addPropertyDocument(PropertyData propertyData) {
    propertyRef.add(propertyData);
  }
}
