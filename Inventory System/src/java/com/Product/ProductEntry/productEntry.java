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

public class productEntry {
    
    String  Query1, Query2, Query3, Query4, Query5;
    
    databaseConnection db1;
    Connection con;
    PreparedStatement psmt1,psmt2,psmt3,psmt4,psmt5;
    
    public void productEnty()
    {
        
        db1 = new databaseConnection();
        
    }
    
    public String addProduct(long barcode, int volume, int numberOfBottles,String category, String brand, float price, String productName, int min_stock, int max_stock)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception ex)
        {
            return ex.getMessage();
        }
        
        //con = db1.connectDatabase();
        Query1 = "INSERT INTO stock(Barcode, Brand, Litres, NumberOfBottles, Price, Category, ProductName, Min_Stock, Max_stock)"
                + "VALUES (?,?,?,?,?,?,?,?,?)";
        
        Query2 = "INSERT INTO daily(Barcode, opening, closing, sales, Incoming)"
                + "VALUES (?,0,0,0,?)";
        
        //Query3 = "INSERT INTO p_daily(Barcode, opening, closing, sales, Incoming)"
               // + "VALUES (?,0,0,0,?)";
        
        Query4 = "INSERT INTO monthly(Barcode, opening, closing, sales, Incoming)"
                + "VALUES (?,0,0,0,?)";

        //Query5 = "INSERT INTO p_monthly(Barcode, opening, closing, sales, Incoming)"
               // + "VALUES (?,0,0,0,?)";
        
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt1 = con.prepareStatement(Query1);
            psmt1.setLong(1, barcode);
            psmt1.setString(2, brand);
            psmt1.setInt(3, volume);
            psmt1.setInt(4, numberOfBottles );
            psmt1.setFloat(5, price);
            psmt1.setString(6, category);
            psmt1.setString(7, productName);
            psmt1.setInt(8, min_stock);
            psmt1.setInt(9, max_stock);
            psmt1.execute();

            psmt2 = con.prepareStatement(Query2);
            psmt2.setLong(1, barcode);
            psmt2.setInt(2, numberOfBottles);
            psmt2.execute();

         /*   psmt3 = con.prepareStatement(Query3);
            psmt3.setLong(1, barcode);
            psmt3.setInt(2, numberOfBottles);
            psmt3.execute();*/

            psmt4 = con.prepareStatement(Query4);
            psmt4.setLong(1, barcode);
            psmt4.setInt(2, numberOfBottles);
            psmt4.execute();

           /* psmt5 = con.prepareStatement(Query5);
            psmt5.setLong(1, barcode);
            psmt5.setInt(2, numberOfBottles);
            psmt5.execute();*/

            return "Success";
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
       
    }
    
    /*public static void main(String args[])
    {
        productEntry p1 = new productEntry();
        long n1 = 1234567890L;
        String result = p1.addProduct( n1, 450, 450, "Kingfisher", "Beer", 450, "weak");
        System.out.println(result);
    }*/
    
}
