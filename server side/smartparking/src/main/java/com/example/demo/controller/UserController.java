package com.example.demo.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.example.demo.service.FirebaseServices;
import com.google.cloud.firestore.DocumentSnapshot;

@CrossOrigin(origins = "*")
@RestController
public class UserController {
	
	@Autowired
	private FirebaseServices firebaseServices;
	
	@GetMapping("/getUserDetails")
	public User getUserDetails(@RequestHeader String uid) throws InterruptedException, ExecutionException {
		return firebaseServices.getUserDetails(uid);
	}
	@GetMapping("/getCreds")
	public String getCreds(@RequestHeader String username) throws InterruptedException, ExecutionException {
		return firebaseServices.getCreds(username);
	}
	@GetMapping("/checkUserDetails")
	public boolean checkUserDetails(@RequestHeader String uid) throws InterruptedException, ExecutionException {
		return firebaseServices.checkUserDetails(uid);
	}
	
	@PostMapping("/createUser")
	public String createNewUser(@RequestBody User person, @RequestHeader String docID) throws InterruptedException, ExecutionException {
		return firebaseServices.saveUserDetails(person, docID);
	}
	
	@PutMapping("/updateUser")
	public String updateUser(@RequestBody User person) {
		return "Updated user "+person.getFirstname();
	}
	
	@DeleteMapping("/deleteUser")
	public String deleteUser(@RequestHeader String name) throws InterruptedException, ExecutionException {
		return firebaseServices.deleteUser(name);
	}

}