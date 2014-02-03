/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.ProductEntry;

import java.sql.*;

/**
 *
 * @author I067515
 */


public class creditsAddition {
    
    Connection con;
    PreparedStatement psmt;
    ResultSet res;
    String Query, Query2, Items2;
    float credits2;
    
    public String addCredit(String Name, long phoneNumber, float credits, String Items)
    {
        credits2 = 0.0f;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception ex)
        {
            return ex.getMessage();
        }
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            Query2 = "SELECT credits, Items FROM Credits WHERE phoneNumber = ?";
            psmt = con.prepareStatement(Query2);
            while(res.next())
            {
                credits2 = res.getFloat("credits");
                Items2 = res.getString("Items");
            }
            if(credits2!=0.0f)
            {
                credits2 +=credits;
                Query = "UPDATE credits SET credits+=?, Items = ? WHERE phoneNumber = ?";
                Items2 = Items + Items2;
                psmt = con.prepareStatement(Query);
                psmt.setFloat(1, credits2);
                psmt.setString(2, Items2);
                psmt.setLong(3, phoneNumber);
                psmt.executeUpdate();
                return "Successfully Updated and total credits are " +credits2;
            }
            else
            {
                Query = "INSERT INTO credits(Name, PhoneNumber, Credits, Items, Date) VALUES (?,?,?,?,now())";
                psmt = con.prepareStatement(Query);
                psmt.setString(1, Name);
                psmt.setLong(2, phoneNumber);
                psmt.setFloat(3, credits);
                psmt.setString(4, Items);
                psmt.execute();
                return "Credits Table Added";
            }
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
            
    }
    
    
}
