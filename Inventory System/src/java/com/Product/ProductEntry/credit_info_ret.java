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
public class credit_info_ret {

 Connection con;
    PreparedStatement psmt;
    ResultSet res;
    String Query, Query2, Items2;
    float credits2;
    ArrayList al=new ArrayList();
    public ArrayList Credit_ret()
    {

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception ex)
        {
             al.add(ex.getMessage());
             return al;
        }
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            Query2 = "SELECT * from credit where cleared = 0";
            psmt = con.prepareStatement(Query2);
            res=psmt.executeQuery();
            while(res.next())
            {
                
                al.add(res.getString("bill_no"));
                al.add(res.getString("amount"));
                al.add(res.getString("cleared"));
                al.add(res.getString("cleared_date"));
                //System.out.println(res.getString("cleared_date"));
                al.add(res.getString("email_id"));
                al.add(res.getString("ph_no"));
            }
            return al;
        }
        catch(SQLException ex)
        {
           al.add(ex.getMessage());
             return al;
        }


    }
      public static void main(String args[])
    {
            credit_info_ret ca=new credit_info_ret();
            String ab="152adadf";

            ArrayList a=new ArrayList();
            a=ca.Credit_ret();
            System.out.print(a);
        }

}