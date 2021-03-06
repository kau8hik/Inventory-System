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

public class stockView {
    
    
   Connection con;
   String Query, Result, product, brand, category;
   int numberOfBottles;
   float price;
   int volume;
   long barcode;
   PreparedStatement psmt;
   ResultSet res;
   ArrayList A1;

   
   public ArrayList getStockView(String Category, String Brand)
   {
       databaseConnection dC1 = new databaseConnection();
       con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
       Query = "SELECT * FROM stock WHERE Category = ? AND Brand = ?";
       A1 = new ArrayList();
       try
       {
            psmt = con.prepareStatement(Query);
            psmt.setString(1, Category);
            psmt.setString(2, Brand);
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
                A1.add(Category);
                A1.add(Brand);
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
   
   /*public static void main(String args[])
   {
       stockView sv1 = new stockView();
       String result = sv1.getStockView("Kingfisher", "Beer");
       System.out.println(result);
       
   }*/
    
}