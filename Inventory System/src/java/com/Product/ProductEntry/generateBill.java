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
import java.text.*;

public class generateBill {

    String Query, Query2;
    Connection con;
    PreparedStatement psmt;
    databaseConnection dC1;
    ResultSet res;
    int billID;
    
    public String generateBillID(String Contents, float totalCost)
    {
        dC1 = new databaseConnection();
        con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        Query = "INSERT INTO billingtable(Date, BillID, Contents, TotalCost) VALUES ( now(), ?,?,?)";
        Query2 = "SELECT BillID FROM billingtable ORDER BY BillID desc limit 1";
        try
        {
            psmt = con.prepareStatement(Query2);
            res = psmt.executeQuery();
            while(res.next())
            {
                billID = res.getInt("BillID");
            }
            billID ++;
            psmt = con.prepareStatement(Query);
            psmt.setInt(1, billID);
            psmt.setString(2, Contents);
            psmt.setFloat(3, totalCost);
            psmt.execute();
            return "Success";
        }
        catch(Exception ex)
        {
            return ex.getMessage();       
        }
        
    }
    
    
}
