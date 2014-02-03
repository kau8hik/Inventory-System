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
public class view_stock_permitno {

Connection con;
    PreparedStatement psmt;
    ResultSet res;
    String Query, Query2, Items2;
    float credits2;
    ArrayList al=new ArrayList();
    public ArrayList view_stock_per(String permit_no)
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
            Query2 = "SELECT * from incoming_stock where permit_no = '"+permit_no+"'";
            System.out.print(Query2);
            psmt = con.prepareStatement(Query2);
            res=psmt.executeQuery();
            String date=null;
            while(res.next())
            {
                al.add(res.getString("Barcode"));
                al.add(res.getString("no_of_bottles"));
                date= res.getString("date");
            }
            al.add(date);
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
            view_stock_permitno ca=new view_stock_permitno();
            String ab="per123";

            ArrayList a=new ArrayList();
            a=ca.view_stock_per(ab);
            System.out.print(a);
        }

}
