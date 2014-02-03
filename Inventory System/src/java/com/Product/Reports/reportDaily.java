/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.Reports;

/**
 *
 * @author I067515
 */

import java.sql.*;
import java.util.*;
import com.Product.ProductEntry.*;

public class reportDaily {
    
    String Query, Category, Product, Brand;
    ArrayList A1;
    int Volume, NumberOfBottles;
    Float Price;
    Connection con;
    PreparedStatement psmt;
    databaseConnection db1;
    ResultSet res;
    
    public ArrayList generateReportDaily()
    {
        A1 = new ArrayList();
        con = db1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root"); 
        Query = "SELECT * from Stock, Daily WHERE Stock.barcode = Daily.Barcode";
        try
        {
            psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            while(res.next())
            {
                Category = res.getString("Stock.Category");
                Brand = res.getString("Stock.Brand");
                Product = res.getString("Stock.ProductName");
                Volume = res.getInt("Stock.Litres");
                NumberOfBottles = res.getInt("Daily.NumberOfBottles");
                Price = res.getFloat("Stock.Price");
                Price = Price * NumberOfBottles;
                A1.add(Category);
                A1.add(Brand);
                A1.add(Product);
                A1.add(Volume);
                A1.add(NumberOfBottles);
                A1.add(Price);
            }
            return A1;
        }
        catch(SQLException ex)
        {
            A1.add(ex.getMessage());
            return A1;
        }
    }
    
    public static void main(String args[])
    {
        reportDaily rD1 = new reportDaily();
        ArrayList A11 = new ArrayList();
        A11 = rD1.generateReportDaily();
        System.out.println(A11);
    }
}
