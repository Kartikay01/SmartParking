package com.example.demo.object;

public class WorkerData {
	public WorkerData(Worker worker, String docID) {
		super();
		this.worker = worker;
		this.docID = docID;
	}
	public WorkerData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Worker getWorker() {
		return worker;
	}
	public void setWorker(Worker worker) {
		this.worker = worker;
	}
	public String getDocID() {
		return docID;
	}
	public void setDocID(String docID) {
		this.docID = docID;
	}
	private Worker worker;
	private String docID;
	
}
