
package com.example.demo.service;

import java.security.PublicKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.example.demo.object.Creds;
import com.example.demo.object.ParkingLot;
import com.example.demo.object.ParkingLotData;
import com.example.demo.object.Timeslots;
import com.example.demo.object.TimeslotsData;
import com.example.demo.object.User;
import com.example.demo.object.Worker;
import com.example.demo.object.WorkerData;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.Query.Direction;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.errorprone.annotations.Var;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.database.core.Path;

@Service
public class FirebaseServices {
	
	public String saveUserDetails(User message , String docID) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future = db.collection("users").document(docID).set(message);
        Creds creds = new Creds(message.getEmail());
        ApiFuture<WriteResult> future2 = db.collection("credentials").document(message.getUsername()).set(creds);
        return future.get().getUpdateTime().toString();
    }
	
	public String getCreds(String username) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference docRef = db.collection("credentials").document(username);
		// asynchronously retrieve the document
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// block on response
		DocumentSnapshot document = future.get();
		Creds creds=document.toObject(Creds.class);
        return creds.getEmail();
    }
	

	public User getUserDetails(String uid) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("users").document(uid);
		// asynchronously retrieve the document
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// block on response
		DocumentSnapshot document = future.get();
		User person = null;
		if (document.exists()) {
		  // convert document to POJO
		  person = document.toObject(User.class);
		  System.out.println(person);
		  return person;
		} else {
		  System.out.println("No such document!");
		  return null;
		}
	}
	public boolean checkUserDetails(String uid) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("users").document(uid);
		// asynchronously retrieve the document
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// block on response
		DocumentSnapshot document = future.get();
		return document.exists();
	}
	
	public String deleteUser(String name) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection("users").document(name).delete();
		return writeResult.get().getUpdateTime().toString();
	}
	
	//parkinglots
	public int saveParkingLotDetails(ParkingLot message) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future1 =
    		    db.collection("parkinglots").whereEqualTo("location", message.getLocation()).get();
        
        int number;
        for(number=1;true;number++) {
        	if(db.collection("parkinglots").whereEqualTo("location", message.getLocation()).whereEqualTo("lotID", number).get().get().getDocuments().isEmpty()) {
        		break;
        	}
        }
        message.setLotID(number);
        ApiFuture<WriteResult> future = db.collection("parkinglots").document().set(message);
        return number;
    }
	public List<ParkingLotData> getPLDetails(String location, long checkintime, long checkouttime, int size) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<QuerySnapshot> future1 =
		    db.collection("parkinglots").whereEqualTo("location", location).get();
		// future.get() blocks on response
		List<QueryDocumentSnapshot> locdocuments = future1.get().getDocuments();
		List<ParkingLotData> pllist= new ArrayList<ParkingLotData>();
		for (DocumentSnapshot document : locdocuments) {
			ParkingLot pl=document.toObject(ParkingLot.class);
			ParkingLotData plData= new ParkingLotData(document.getId(), pl, false);
			plData.setTotalcost(pl.gettotalcost(checkintime, checkouttime));
			System.out.println(plData.getTotalcost());
			System.out.println(pl.gettotalcost(checkintime, checkouttime));
			ApiFuture<QuerySnapshot> future2 =
				    db.collection("timeslots").whereEqualTo("lotID", document.getId()).get();
			List<QueryDocumentSnapshot> lotdocuments = future2.get().getDocuments();
			
			Boolean flag=true;
			for(DocumentSnapshot i : lotdocuments) {
				Timeslots ts=i.toObject(Timeslots.class);
				if((ts.getCheckin()<checkintime+1&&ts.getCheckout()>checkintime+1)||(
						ts.getCheckin()<checkouttime-1&&ts.getCheckout()>checkouttime-1)) {
					flag=false;
				}
			}
			if(flag) {
				pllist.add(plData);
			}
		  System.out.println(document.getId() + " => " + document.toObject(ParkingLot.class));
		  
		}
		return pllist;
	}
	public List<ParkingLotData> getPLDetails(String location, long time) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<QuerySnapshot> future1 =
		    db.collection("parkinglots").whereEqualTo("location", location).orderBy("lotID",Direction.ASCENDING).get();
		// future.get() blocks on response
		List<QueryDocumentSnapshot> locdocuments = future1.get().getDocuments();
		List<ParkingLotData> pldlist= new ArrayList<ParkingLotData>();
		for (DocumentSnapshot document : locdocuments) {
			
			ParkingLot pl=document.toObject(ParkingLot.class);
			boolean boolean1=false;
			ApiFuture<QuerySnapshot> future2 = db.collection("timeslots").whereEqualTo("lotID", document.getId()).get();
			List<QueryDocumentSnapshot> tsdocuments = future2.get().getDocuments();
			Timeslots timeslots=new Timeslots();
			for(DocumentSnapshot e:tsdocuments) {
				timeslots=e.toObject(Timeslots.class);
				System.out.println(time);
				if(timeslots.getCheckin()<=time&&time<=timeslots.getCheckout()) {
					System.out.println("true");
					boolean1=true;
					System.out.println(boolean1);
					break;
				}
			}
			System.out.print(boolean1);
			ParkingLotData parkingLotData= new ParkingLotData(document.getId(), pl, boolean1);
			System.out.println(parkingLotData.getOccupied());
		  System.out.println(document.getId() + " => " + document.toObject(ParkingLot.class));
		  pldlist.add(parkingLotData);
		}
		return pldlist;
	}
	public Timeslots getOccupant(String lotdocid, Long time)throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<QuerySnapshot> future1 =
			    db.collection("timeslots").whereEqualTo("lotID", lotdocid).get();
		List<QueryDocumentSnapshot> locdocuments = future1.get().getDocuments();
		Timeslots timeslots=new Timeslots();
		for(DocumentSnapshot e:locdocuments) {
			timeslots=e.toObject(Timeslots.class);
			if(timeslots.getCheckin()<=time&&time<=timeslots.getCheckout()) {
				break;
			}
		}
		
		return timeslots;
		}
	public ParkingLotData getPLDetailsbyid(String docID) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("parkinglots").document(docID);
		// asynchronously retrieve the document
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// block on response
		DocumentSnapshot document = future.get();
		ParkingLotData pl = null;
		if (document.exists()) {
		  // convert document to POJO
		  pl = document.toObject(ParkingLotData.class);
		  System.out.println(pl);
		  return pl;
		} else {
		  System.out.println("No such document!");
		  return null;
		}
	}
	
	public String deletepl(String lotID) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection("parkinglots").document(lotID).delete();
		return writeResult.get().getUpdateTime().toString();
	}
	
	public String cancelBooking(String timeslotID, long t) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("timeslots").document(timeslotID);
		ApiFuture<DocumentSnapshot> future = docRef.get();
		// block on response
		DocumentSnapshot document = future.get();
		Timeslots ts=null;
		ts=document.toObject(Timeslots.class);
		if(t<ts.getCheckout()) {
			ApiFuture<WriteResult> writeResult = docRef.delete();
			return writeResult.get().getUpdateTime().toString();
		}
		else {
			return "failed";
		}
	}
	//Worker 
	
	public String saveWorkerDetails(Worker message) throws InterruptedException, ExecutionException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future = db.collection("workers").document(message.getUsername()).set(message);
        return future.get().getUpdateTime().toString();
    }

	public Worker getWorkerDetails(String workername) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<DocumentSnapshot> future1 =
		    db.collection("workers").document(workername).get();
		DocumentSnapshot w=future1.get();
		Worker worker= w.toObject(Worker.class);
		return worker;
		
	}
	
	public List<WorkerData> getWorkerDetailsAtLocation(String location) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<QuerySnapshot> future1 =
		    db.collection("workers").whereEqualTo("location", location).get();
		// future.get() blocks on response
		List<QueryDocumentSnapshot> locdocuments = future1.get().getDocuments();
		List<WorkerData> workerlist= new ArrayList<WorkerData>();
		for (DocumentSnapshot document : locdocuments) {
			Worker w=document.toObject(Worker.class);
			WorkerData wd=new WorkerData(w,document.getId());
		  System.out.println(document.getId() + " => " + document.toObject(Worker.class));
		  workerlist.add(wd);
		}
		return workerlist;
		
	}
	
	
	public String deleteWorker(String workername) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		ApiFuture<WriteResult> writeResult = db.collection("workers").document(workername).delete();
		return writeResult.get().getUpdateTime().toString();
	}
	public void updaterating(String docid, int vote) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("workers").document(docid);
		ApiFuture<DocumentSnapshot> future = docRef.get();
		DocumentSnapshot document = future.get();
		Worker worker = document.toObject(Worker.class);
		worker.updaterating(vote);
		Map<String,Object> map = new HashMap<>();
		map.put("rating", worker.getRating() );
		docRef.update(map);
	}
	
	public void updatevote(String docid, int vote) throws InterruptedException, ExecutionException {
		Firestore db = FirestoreClient.getFirestore();
		DocumentReference docRef = db.collection("timeslots").document(docid);
		ApiFuture<DocumentSnapshot> future = docRef.get();
		DocumentSnapshot document = future.get();
		Timeslots ts = document.toObject(Timeslots.class);
		ts.setVote(vote);
		Map<String,Object> map = new HashMap<>();
		map.put("vote", ts.getVote() );
		docRef.update(map);
	}
	
	//booking
	public String saveTimeslotDetails(Timeslots t) throws InterruptedException, ExecutionException{
		 Firestore db = FirestoreClient.getFirestore();
	        ApiFuture<WriteResult> future = db.collection("timeslots").document().set(t);
	        DocumentReference docRef = db.collection("users").document(t.getUser());
			ApiFuture<DocumentSnapshot> future1 = docRef.get();
			DocumentSnapshot document = future1.get();
			User user = document.toObject(User.class);
			user.transaction(-t.getCost());
			docRef.update("wallet", user.getWallet());
			
	        return future.get().getUpdateTime().toString();
	}
	public List<TimeslotsData> fetchUserBookings(String uid) throws InterruptedException, ExecutionException{
		Firestore db = FirestoreClient.getFirestore();
		//asynchronously retrieve multiple documents
		ApiFuture<QuerySnapshot> future1 =
		    db.collection("timeslots").whereEqualTo("user", uid).orderBy("timestamp",Direction.DESCENDING).get();
		// future.get() blocks on response
		List<QueryDocumentSnapshot> tsdocuments = future1.get().getDocuments();
		Timeslots timeslots;
		List<TimeslotsData> timeslotslist=new ArrayList<TimeslotsData>();
		for(DocumentSnapshot i :tsdocuments) {
			timeslots=i.toObject(Timeslots.class);
			TimeslotsData timeslotsData =new TimeslotsData(i.getId(), timeslots);
			timeslotslist.add(timeslotsData);
		}
		return timeslotslist;
	}
	
		
}