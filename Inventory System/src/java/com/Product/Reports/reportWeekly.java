/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.Reports;

/**
 *
 * @author I067515
 */

import com.Product.ProductEntry.databaseConnection;
import java.sql.*;
import java.util.*;


public class reportWeekly {
    
    String Query, Query5, Category, Product, Brand;
    ArrayList A1;
    int Volume, NumberOfBottles, Opening, Closing, Sold, Incoming;
    Float Price;
    Connection con;
    long Barcode;
    PreparedStatement psmt, psmt5;
    databaseConnection db1;
    ResultSet res;
    write2excel w2E;
    
    public String getData()
    {
        w2E = new write2excel();
        A1 = new ArrayList();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception ex)
        {
            return ex.getMessage();
        }
        
        Query = "SELECT * from Weekly, Stock  WHERE Stock.Barcode = Weekly.Barcode";
        
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            ArrayList A1 = new ArrayList();
            psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            while(res.next())
            {
                Barcode = res.getLong("Stock.Barcode");
                Category = res.getString("Stock.Category");
                Brand = res.getString("Stock.Brand");
                Product = res.getString("Stock.ProductName");
                Volume = res.getInt("Stock.Litres");
                Opening = res.getInt("Weekly.NumberOfBottles");
                Closing = res.getInt("Weekly.Closing");
                Incoming = res.getInt("Weekly.Incoming");
                Price = res.getFloat("Stock.Price");
                //System.out.println("Category: " + Category + "\nBrand: " + Brand + "\nProduct: "+ Product + "\n:Volume: "+ Volume + "\nNumberOfBottles: "+ NumberOfBottles + "\nClosing" + Closing + "\nPrice: " + Price);
                Sold = Opening + Incoming - Closing;
                Price = Price * Sold;
            
                A1.add(Category);
                A1.add(Brand);
                A1.add(Product);
                A1.add(String.valueOf(Volume));
                A1.add(String.valueOf(Opening));
                A1.add(String.valueOf(Closing));
                A1.add(String.valueOf(Incoming));
                A1.add(String.valueOf(Sold));
                A1.add(String.valueOf(Price));
                
                Query5 = "UPDATE daily SET Sales = 0, NumberOfBottles = ?, Closing = 0, Incoming = 0 WHERE Barcode = ?";
                psmt5 = con.prepareStatement(Query5);
                psmt5.setInt(1, Closing);
                psmt5.setLong(2, Barcode);
                psmt5.executeUpdate();
            }
            
            return w2E.writeExcel(A1, "C:\\Reports_Weekly\\");
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
    }
    
    public static void main(String args[])
    {
        reportWeekly rW1 = new reportWeekly();
        System.out.println(rW1.getData());
    }
    
}
