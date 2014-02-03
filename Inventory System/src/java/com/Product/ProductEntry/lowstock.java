/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Product.ProductEntry;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Kaushikn
 */
public class lowstock {
    private String brand;
    private String category;
    public ArrayList lowstock1(String Brand, String Category, String no){

       Connection con;
       String Query, Result, product;
       int numberOfBottles;
       float price;
       int volume;
       long barcode;
       PreparedStatement psmt;
       ResultSet res;
       ArrayList al=new ArrayList();

       databaseConnection dC1 = new databaseConnection();
       con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");

       if((Category.equals("All")) && (Brand.equals("All")))
        {
            Query = "SELECT * FROM stock where numberofbottles<"+no;

        }
        else if(Category.equals("All") && (!Brand.equals("All")))
        {
            Query = "SELECT * FROM stock WHERE Brand = '"+Brand+"' and numberofbottles<"+no;
        }
        else if(Brand.equals("All") && (!Category.equals("All")))
        {
            Query = "SELECT * FROM stock WHERE Category = '"+Category+"' and numberofbottles<"+no;
        }
        else
        {
            Query = "SELECT * FROM stock WHERE Category = '"+Category+"' AND Brand = '"+Brand+"' And numberofbottles<"+no;
        }
        System.out.println(Query);
       try
       {
            psmt = con.prepareStatement(Query);
            //psmt.setString(1, Category);
            res = psmt.executeQuery();
            while(res.next()){
            product = res.getString("ProductName");
                numberOfBottles = res.getInt("NumberOfBottles");
                volume = res.getInt("Litres");
                price = res.getFloat("Price") ;
                barcode = res.getLong("Barcode");
                brand = res.getString("Brand");
                category = res.getString("Category");
                al.add(barcode);
                al.add(category);
                al.add(brand);
                al.add(product);
                al.add(volume);
                al.add(numberOfBottles);
                al.add(price);
            }


           return al;

        }
       catch(Exception ex)
       {
           al = new ArrayList();
           al.add(ex.getMessage());
           return al;
       }


    }
/*    public static void main(String args[]){
        lowstock ls=new lowstock();
        ArrayList al=ls.lowstock1("All", "All", 1000);
        System.out.println(al);
    }*/

}
