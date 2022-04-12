package com.example.demo.object;

import java.util.ArrayList;

public class Worker extends Location {
	
	private String workername;
	private int rating=0;
	private long dateofjoining;
	private int jobscompleted=0;
	private String username="";
	private String passwordString="";
	
	
	

	public Worker( String workername, String location, String username, String password,
			long dateofjoining) {
		super();
		this.workername = workername;
		this.location = location;
		this.dateofjoining=dateofjoining;
		this.username=username;
		this.passwordString=password;
	}

	
	
	public int getJobscompleted() {
		return jobscompleted;
	}



	public void setJobscompleted(int jobscompleted) {
		this.jobscompleted = jobscompleted;
	}



	public Worker() {
		super(); 
	}

	

	public String getWorkername() {
		return workername;
	}

	public void setWorkername(String workername) {
		this.workername = workername;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}


	public long getDateofjoining() {
		return dateofjoining;
	}

	public void setDateofjoining(long dateofjoining) {
		this.dateofjoining = dateofjoining;
	}
	public void updaterating(int vote)
	{
		this.rating+=vote;
	}
	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getPasswordString() {
		return passwordString;
	}



	public void setPasswordString(String passwordString) {
		this.passwordString = passwordString;
	}


}
