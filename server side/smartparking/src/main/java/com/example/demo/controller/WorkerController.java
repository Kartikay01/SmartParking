package com.example.demo.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.object.User;
import com.example.demo.object.Worker;
import com.example.demo.object.WorkerData;
import com.example.demo.service.FirebaseServices;
import com.google.cloud.firestore.QuerySnapshot;

@CrossOrigin(origins = "*")
@RestController
public class WorkerController {
	
	@Autowired
	private FirebaseServices firebaseServices;
	
	@GetMapping("/getWorkerDetails")
	public Worker getWorkerDetails(@RequestHeader String workername) throws InterruptedException, ExecutionException {
		return firebaseServices.getWorkerDetails(workername);
	}
	
	@GetMapping("/getWorkerAtLocation")
	public List<WorkerData> getWorkersAtLocation(@RequestHeader String location) throws InterruptedException, ExecutionException {
		return firebaseServices.getWorkerDetailsAtLocation(location);
	}
	
	@PostMapping("/createWorker")
	public String createNewWorker(@RequestBody Worker person) throws InterruptedException, ExecutionException {
		return firebaseServices.saveWorkerDetails(person);
	}
	
	@PutMapping("/updateWorker")
	public void updateWorker(@RequestHeader String docid, @RequestHeader int vote)  throws InterruptedException, ExecutionException {
		firebaseServices.updaterating(docid, vote);
	}
	
	@DeleteMapping("/deleteWorker")
	public String deleteWorker(@RequestHeader String docid) throws InterruptedException, ExecutionException {
		return firebaseServices.deleteWorker(docid);
	}

}