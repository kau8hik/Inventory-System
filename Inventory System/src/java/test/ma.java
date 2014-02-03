/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package test;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Kaushikn
 */
public class ma {
    public static void main(String args[]) throws SQLException{
        try
    {
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
    PreparedStatement psmt,psmt1;
    ResultSet res,res1;
   // String id = request.getParameter("id");
    int total=0;
    //int noofbottles=Integer.parseInt(request.getParameter("noofbottles"));
    //out.println(id);
    String Query="select category, sum(sales) as t from daily, stock where daily.barcode=stock.barcode group by stock.category";
    //out.println(Query);
    //out.println(Query);
    psmt = con.prepareStatement(Query);
    res = psmt.executeQuery();
    ArrayList al=new ArrayList();
    while(res.next())
    {
        al.add(res.getString("Category"));
        al.add(res.getInt("t"));
    }
    System.out.println(al);
  }
catch(Exception ex){}
    }

}
