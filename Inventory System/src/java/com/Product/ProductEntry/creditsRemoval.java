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

public class creditsRemoval {
    
    Connection con;
    PreparedStatement psmt;
    ResultSet res;
    String query1, query2;
    float totalCredits, remainingCredits;
    
    public String removeCredits(Long phoneNumber, float credits)
    {
        totalCredits = 0.0f;
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
            query1 = "SELECT credits from Credits WHERE phoneNumber = ?";
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt = con.prepareStatement(query1);
            psmt.setLong(1, phoneNumber);
            res = psmt.executeQuery();
            while(res.next())
            {
                totalCredits += res.getFloat("credits");
            }
            if(credits == totalCredits)
            {
                query2 = "DELETE * FROM Credits WHERE phoneNumber = ?";
                psmt = con.prepareStatement(query2);
                psmt.setLong(1, phoneNumber);
                psmt.execute();
                return "Successfully deleted";
            }
            else
            {
                remainingCredits = totalCredits - credits;
                query2 = "UPDATE Credits SET credits = credits - ? WHERE phoneNumber = ?";
                psmt = con.prepareStatement(query2);
                psmt.setFloat(1, remainingCredits);
                psmt.setLong(2, phoneNumber);
                psmt.executeUpdate();
                return "Still remaining credits is " + remainingCredits;
            }
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
    }
    
    
}
