package com.example.demo.service;

import java.io.FileInputStream;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;

@CrossOrigin
@Service
public class FirebaseInitialize {
@PostConstruct
	public void initialize() {
	try {
		FileInputStream serviceAccount =
				  new FileInputStream("./serviceAccount.json");

				FirebaseOptions options = new FirebaseOptions.Builder()
				  .setCredentials(GoogleCredentials.fromStream(serviceAccount))
				  .setDatabaseUrl("https://carparkingsolutions-979a3.firebaseio.com")
				  .build();

				FirebaseApp.initializeApp(options);
		        Firestore db = FirestoreClient.getFirestore();
	} catch (Exception e) {
		e.printStackTrace();
	}
}

}