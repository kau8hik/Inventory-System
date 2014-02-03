/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Product.Reports;
import java.sql.*;
import java.util.ArrayList;
/**
 *
 * @author Kaushikn
 */
public class daily_reports_category {

Connection con;
    PreparedStatement psmt;
    ResultSet res;
    String Query, Query2, Items2;
    float credits2;
    ArrayList al=new ArrayList();
    public ArrayList view_sales()
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
            Query2 = "SELECT sum( daily.sales ) , stock.category FROM daily, stock WHERE daily.barcode = stock.barcode GROUP BY (stock.category)";
            System.out.print(Query2);
            psmt = con.prepareStatement(Query2);
            res=psmt.executeQuery();

            while(res.next())
            {
                al.add(res.getString("sum( daily.sales )"));
                al.add(res.getString("category"));

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
            daily_reports_category ca=new daily_reports_category();
            String ab="per123";

            ArrayList a=new ArrayList();
            a=ca.view_sales();
            System.out.print(a);
        }

}
