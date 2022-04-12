package com.example.demo.object;
import java.util.ArrayList;

public class ParkingLotData {
	public String getDocID() {
		return docID;
	}
	public void setLotID(String docID) {
		this.docID = docID;
	}

	public ParkingLotData() {
		
	}
	public ParkingLotData(String docID, ParkingLot pl, boolean occupied) {
		super();
		this.docID=docID;
		this.parkingLot=pl;
		this.occupied=occupied;
	}
	String docID;
	ParkingLot parkingLot;
	boolean occupied;
	int totalcost=0;
	
	public int getTotalcost() {
		return totalcost;
	}
	public void setTotalcost(int totalcost) {
		this.totalcost = totalcost;
	}
	public void setDocID(String docID) {
		this.docID = docID;
	}
	public boolean getOccupied() {
		return occupied;
	}
	public void setOccupied(boolean occupied) {
		this.occupied = occupied;
	}
	public ParkingLot getParkingLot() {
		return parkingLot;
	}
	public void setParkingLot(ParkingLot parkingLot) {
		this.parkingLot = parkingLot;
	}
}
	

