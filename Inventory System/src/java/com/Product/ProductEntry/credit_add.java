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
public class credit_add {
    String Query;
    Connection con;
    databaseConnection dC1;
    PreparedStatement psmt;

    public String creditadd(String bill_no, String amount,String email_id,String ph_no)
    {
        dC1 = new databaseConnection();
        con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        Query = "insert into credit (bill_no, amount,email_id,ph_no) values('"+bill_no+"','"+amount+"','"+email_id+"','"+ph_no+"')";
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
            credit_add ca=new credit_add();
            String ab="152adadf";

            String res=ca.creditadd(ab, "10","abc.def@gmail.com","7895641232");
            System.out.print(res);
        }
}
