/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.Reports;

/**
 *
 * @author I067515
 */

import com.Product.ProductEntry.databaseConnection;

import com.Product.Reports.write2excel;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class reportMonthly {
    
    String Query, Query5, Category, Product, Brand;
    ArrayList A1;
    int Volume, NumberOfBottles, Opening, Closing,sales, Sold, Incoming;
    Long Barcode;
    Float Price, total, gr_total=0f;
    Connection con;
    PreparedStatement psmt, psmt5;
    databaseConnection db1;
    ResultSet res;
    write2excel w2E;
    
    public String getData()
    {
        w2E = new write2excel();
        A1 = new ArrayList();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception ex)
        {
            return ex.getMessage();
        }
        
        Query = "SELECT category, sum(opening) as opening, sum(closing) as closing, sum(incoming) as incoming, sum(sales) as sales, sum(price*sales) as total from Monthly, Stock  WHERE Stock.Barcode = Monthly.Barcode group by category";
        
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            ArrayList A1 = new ArrayList();

            String Query7 = "update Monthly set monthly.opening=monthly.closing, monthly.sales=0";
            PreparedStatement psmt_clo = con.prepareStatement(Query7);
            psmt_clo.executeUpdate();


           String Query_sal = "update monthly, stock set monthly.closing=stock.numberofbottles where stock.Barcode=monthly.barcode";
             PreparedStatement   psmt_sal = con.prepareStatement(Query_sal);
                psmt_sal.executeUpdate();

            String Query_sales="update monthly set monthly.sales=monthly.opening-monthly.closing+monthly.incoming ";
               PreparedStatement psmt_sales = con.prepareStatement(Query_sales);
                psmt_sales.executeUpdate();

                 psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            while(res.next())
            {
                Category = res.getString("Category");
                Opening = res.getInt("opening");
                Closing = res.getInt("closing");
                Incoming = res.getInt("Incoming");
                sales= res.getInt("sales");
                total=res.getFloat("total");
                gr_total+=total;
                A1.add(Category);
                A1.add(String.valueOf(Opening));
                A1.add(String.valueOf(Closing));
                A1.add(String.valueOf(Incoming));
                A1.add(String.valueOf(sales));
                A1.add(String.valueOf(total));
            }
            DateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
            Date date1 = new Date();
            String d1 = dateFormat1.format(date1);
            d1+="%";
            
            String Query_dis = "SELECT sum(discount) FROM `billingtable` WHERE billid like '"+d1+"'";
            System.out.println("d1="+Query_dis);
            psmt_sal = con.prepareStatement(Query_dis);
            res=psmt_sal.executeQuery();
            float discount=0;
            while(res.next()) discount=res.getFloat("sum(discount)");
            float final_total=gr_total-discount;
             A1.add(String.valueOf(gr_total));
            A1.add(String.valueOf(discount));
            A1.add(String.valueOf(final_total));

             String Query_set_incoming = "update monthly set incoming=0 ";
                psmt_sal = con.prepareStatement(Query_set_incoming);
                psmt_sal.executeUpdate();

            return w2E.writeExcel(A1, "C:\\Reports_Monthly\\");


        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
    }
    
    public static void main(String args[])
    {
        reportMonthly rM1 = new reportMonthly();
     
        
        System.out.println(rM1.getData());
    }
    
}
