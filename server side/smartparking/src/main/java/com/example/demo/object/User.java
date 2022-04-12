package com.example.demo.object;

public class User {
	private int type;//0: customer
	private  String phoneNumber;
	private String  email;
	private String  firstname ;
	private String  lastname ;
	private  String address;
	private  String carnumber ;
	private  String username ;
	private  int wallet=300 ;
	public User(int type,  String phoneNumber,  String email,  String firstname ,  String lastname ,
			 String address, String  carnumber ) {
		super();
		this.type = type;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.firstname  = firstname ;
		this.lastname  = lastname ;
		this.address = address;
		this.carnumber  = carnumber ;
	}
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String  getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber( String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String  getEmail() {
		return email;
	}
	public void setEmail( String email) {
		this.email = email;
	}
	public String  getFirstname () {
		return firstname ;
	}
	public void setFirstname ( String firstname ) {
		this.firstname  = firstname ;
	}
	public String  getLastname () {
		return lastname ;
	}
	public void setLastname ( String lastname ) {
		this.lastname  = lastname ;
	}
	public String  getAddress() {
		return address;
	}
	public void setAddress(String  address) {
		this.address = address;
	}
	public String  getCarnumber () {
		return carnumber ;
	}
	public void setCarnumber ( String carnumber ) {
		this.carnumber  = carnumber ;
	}
	public void transaction(int money) {
		this.wallet+=money;
	}

	public int getWallet() {
		return wallet;
	}

	public void setWallet(int wallet) {
		this.wallet = wallet;
	}
}
