package com.example.demo.object;

public class TimeslotsData {
	String docID;
	Timeslots timeslots;
	public String getDocID() {
		return docID;
	}
	public void setDocID(String docID) {
		this.docID = docID;
	}
	public Timeslots getTimeslots() {
		return timeslots;
	}
	public void setTimeslots(Timeslots timeslots) {
		this.timeslots = timeslots;
	}
	public TimeslotsData(String docID, Timeslots timeslots) {
		super();
		this.docID = docID;
		this.timeslots = timeslots;
	}
	public TimeslotsData() {
		super();
		
	}
}
