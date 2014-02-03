/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
*/
package com.Product.ProductEntry;

/**
*
* @author I067515
*/
import java.sql.*;
import java.util.*;

public class billGetData {

Connection con;
databaseConnection dC1;
String Query;
PreparedStatement psmt;
ResultSet res;
String Brand;
String Product;
int volume;
float price;
ArrayList A1;

public ArrayList getData(long Barcode)
{
A1 = new ArrayList();
dC1 = new databaseConnection();
con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
Query = "SELECT * FROM stock WHERE barcode = ?";
try
{
psmt = con.prepareStatement(Query);
psmt.setLong(1, Barcode);
res = psmt.executeQuery();
while(res.next())
{
Brand = res.getString("Brand");
Product = res.getString("ProductName");
volume = res.getInt("Litres");
price = res.getFloat("Price");
A1.add(Barcode);
A1.add(Brand);
A1.add(Product);
A1.add(volume);
A1.add(price);
}
return A1;
}
catch(SQLException ex)
{
A1.add(ex.getMessage());
return A1;
}
}

/*public static void main(String args[])
{
billGetData bGD1 = new billGetData();
ArrayList bgd1 = bGD1.getData(1234567890L);
System.out.println(bgd1);
}*/
}
