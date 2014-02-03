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
public class stockUpdateOnBill {
    
    String Query;
    Connection con;
    databaseConnection dC1;
    PreparedStatement psmt;
    
    public String stockUpdate(Long Barcode, int NumberOfBottles)
    {
        dC1 = new databaseConnection();
        con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        Query = "UPDATE stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?";
        try
        {
            psmt = con.prepareStatement(Query);
            psmt.setInt(1, NumberOfBottles);
            psmt.setLong(2, Barcode);
            psmt.executeUpdate();
            return "Success";
        }
        catch(Exception ex)
        {
            return ex.getMessage();
        }
    }
        
        
        
        
    }
    
