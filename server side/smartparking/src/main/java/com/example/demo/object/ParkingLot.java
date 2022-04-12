package com.example.demo.object;

public class ParkingLot extends Location{
	public int getLotID() {
		return lotID;
	}
	public void setLotID(int lotID) {
		this.lotID = lotID;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}

	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	public ParkingLot(int price, String location, int size) {
		super();
		this.price = price;
		this.location=location;
		this.size = size;
	}
	public ParkingLot() {
		
	}
	int lotID;
	int price;
	int size;//0: 2 wheeler, 1: hatch back, 2: sedan, 3: SUV
	
	public int gettotalcost(long checkin, long checkout) {
		// TODO Auto-generated method stub
		return (int) (((checkout-checkin)*this.price)/3600000);
		
	}
	
}

