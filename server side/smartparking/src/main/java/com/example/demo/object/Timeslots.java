package com.example.demo.object;

import java.util.ArrayList;
import java.util.Arrays;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Dynamic;
import com.google.cloud.Timestamp;
import com.google.errorprone.annotations.Var;

public class Timeslots{
	public long getCheckin() {
		return checkin;
	}
	public void setCheckin(long checkin) {
		this.checkin = checkin;
	}
	public long getCheckout() {
		return checkout;
	}
	public void setCheckout(long checkout) {
		this.checkout = checkout;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public Timeslots(long checkin, long checkout, String lotID,  String user, ArrayList<Integer> servicesArrayList, int cost) {
		super();
		this.checkin = checkin;
		this.checkout = checkout;
		this.user = user;
		this.lotID=lotID;
		this.servicesArrayList=servicesArrayList;
		this.cost=cost;
	}
	public Timeslots() {
		
	}

	public String getLotID() {
		return lotID;
	}
	public void setLotID(String lotID) {
		this.lotID = lotID;
	}
	public String getWorker() {
		return worker;
	}
	public void setWorker(String worker) {
		this.worker = worker;
	}
	public ArrayList<Integer> getServicesArrayList() {
		return servicesArrayList;
	}
	public void setServicesArrayList(ArrayList<Integer> servicesArrayList) {
		this.servicesArrayList = servicesArrayList;
	}
	public long getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}

	int vote=0;
	long checkin;
	long checkout;
	long timestamp;
	int cost=0;
	String lotID="-";
	String user="-";
	String worker="-";
	ArrayList<Integer> servicesArrayList= new ArrayList<Integer>();
	
	public int getPrice(int price) {
		return (int) (((this.checkout-this.checkin)*price)/3600000);
	}
}
	
