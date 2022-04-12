package com.example.demo.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.LinkedHashMap;
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

import com.example.demo.object.ParkingLot;
import com.example.demo.object.ParkingLotData;
import com.example.demo.object.Timeslots;
import com.example.demo.object.TimeslotsData;
import com.example.demo.object.User;
import com.example.demo.service.FirebaseServices;

@CrossOrigin(origins = "*")
@RestController
public class TimeSlotController {
	
	@Autowired
	private FirebaseServices firebaseServices;
	

	
	@PostMapping("/bookTimeLot")
	public String bookTimeSlot(@RequestBody Timeslots t ) throws InterruptedException, ExecutionException {
		return firebaseServices.saveTimeslotDetails(t);
	}
	
	@GetMapping("/userBookings")
	public List<TimeslotsData> fetchUserBookings(@RequestHeader String uid ) throws InterruptedException, ExecutionException {
		return firebaseServices.fetchUserBookings(uid);
	}
	
	@DeleteMapping("/cancelBooking")
	public String cancelBooking(@RequestHeader String timeslotID, @RequestHeader String time ) throws InterruptedException, ExecutionException {
		long t=Long.valueOf(time).longValue();
		return firebaseServices.cancelBooking(timeslotID, t);
	}
	
	@PutMapping("/voteWorker")
	public void updateWorker(@RequestHeader String docid, @RequestHeader int vote)  throws InterruptedException, ExecutionException {
		firebaseServices.updatevote(docid, vote);
	}

}