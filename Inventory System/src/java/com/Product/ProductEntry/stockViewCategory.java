/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.ProductEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author I067515
 */
public class stockViewCategory {
    
           
    
   Connection con;
   String Query, Result, product, brand, category;
   int numberOfBottles;
   float price;
   int volume;
   long barcode;
   PreparedStatement psmt;
   ResultSet res;
   ArrayList A1;

   
   public ArrayList getStockView(String Category)
   {
       databaseConnection dC1 = new databaseConnection();
       con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
       Query = "SELECT * FROM stock WHERE Category = ?";
       A1 = new ArrayList();
       try
       {
            psmt = con.prepareStatement(Query);
            //psmt.setString(1, Category);
            psmt.setString(1, Category);
            res = psmt.executeQuery();
            while(res.next())
            {
                product = res.getString("ProductName");
                numberOfBottles = res.getInt("NumberOfBottles");
                volume = res.getInt("Litres");
                price = res.getFloat("Price") ;
                barcode = res.getLong("Barcode");
                brand = res.getString("Brand");
                category = res.getString("Category");
                A1.add(barcode);
                A1.add(category);
                A1.add(brand);
                A1.add(product);
                A1.add(volume);
                A1.add(numberOfBottles);
                A1.add(price);
            }
            
            return A1;
       }
       catch(Exception ex)
       {
           A1 = new ArrayList();
           A1.add(ex.getMessage());
           return A1;
       }
   }
    
}
