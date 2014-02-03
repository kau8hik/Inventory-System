/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Product.ProductEntry;
import java.sql.*;
/**
 *
 * @author Kaushikn
 */
public class credit_del {
   String Query;
    Connection con;
    databaseConnection dC1;
    PreparedStatement psmt;

    public String creditdel(String bill_id)
    {
        dC1 = new databaseConnection();
        con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        Query = "update credit set cleared=1, cleared_date=now() where bill_no='"+bill_id+"'";
        System.out.print(Query);
        try
        {
            psmt = con.prepareStatement(Query);
            psmt.executeUpdate();
            return "Success";
        }
        catch(Exception ex)
        {
            return ex.getMessage();
        }


}
    public static void main(String args[])
    {
            credit_del ca=new credit_del();
            String ab="152adadf";

            String res=ca.creditdel(ab);
            System.out.print(res);
        }
}
