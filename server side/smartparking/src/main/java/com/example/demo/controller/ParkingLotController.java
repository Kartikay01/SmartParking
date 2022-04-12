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
import com.example.demo.object.User;
import com.example.demo.service.FirebaseServices;

@CrossOrigin(origins = "*")
@RestController
public class ParkingLotController {
	
	@Autowired
	private FirebaseServices firebaseServices;
	

	
	@PostMapping("/createParkingLot")
	public int createNewParkingLot(@RequestBody ParkingLot pl) throws InterruptedException, ExecutionException {
		return firebaseServices.saveParkingLotDetails(pl);
	}
	
	@GetMapping("/fetchParkingLots")
	public List<ParkingLotData> fetchParkingLots(@RequestHeader String location, @RequestHeader String checkin, @RequestHeader String checkout, @RequestHeader int size) throws InterruptedException, ExecutionException{
		long cin=Long.valueOf(checkin).longValue();
		long cout=Long.valueOf(checkout).longValue();
		return firebaseServices.getPLDetails(location, cin, cout, size);
	}
	@GetMapping("/fetchParkingLotsloc")
	public List<ParkingLotData> fetchParkingLots(@RequestHeader String location, @RequestHeader String time ) throws InterruptedException, ExecutionException{
		long t=Long.valueOf(time).longValue();
		return firebaseServices.getPLDetails(location,t);
	}
	
	@GetMapping("/getOccupant")
	public Timeslots getOccupant(@RequestHeader String lotdocid, @RequestHeader String time) throws InterruptedException, ExecutionException{
		long timelong=Long.valueOf(time).longValue();
		return firebaseServices.getOccupant(lotdocid,timelong);
	}
	
	@GetMapping("/fetchParkingLotbyid")
	public ParkingLotData fetchParkingLotbyid(@RequestHeader String docID) throws InterruptedException, ExecutionException{
		return firebaseServices.getPLDetailsbyid(docID);
	}
	@DeleteMapping("/deleteParkingLot")
	public String deletepl(@RequestHeader String docid) throws InterruptedException, ExecutionException {
		return firebaseServices.deletepl(docid);
	}

}