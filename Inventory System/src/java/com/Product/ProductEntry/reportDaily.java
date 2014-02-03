/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.ProductEntry;
/**
 *
 * @author I067515
 */
import com.Product.Reports.write2excel;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class reportDaily {
    
    String Query, Query2, Query3, Query4, Query5, Query6, Category, Product, Brand,Query_sales, Query_sal;
    ArrayList A1;
    long Barcode;
    int Volume, NumberOfBottles, Opening, Closing, Sold, Incoming, sales=0;
    Float total=0f,gr_total=0f;
    Double Price;
    Connection con;
    PreparedStatement psmt, psmt3, psmt4, psmt5, psmt_sal, psmt_clo, psmt_sales;
    databaseConnection db1;
    ResultSet res;
    write2excel w2E;
    private String Query7;
    
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
        
        Query = "SELECT category, sum(opening) as opening, sum(closing) as closing, sum(incoming) as incoming, sum(sales) as sales, sum(price*sales) as total from Daily, Stock  WHERE Stock.Barcode = Daily.Barcode group by category" ;
        
        try
        {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            ArrayList A1 = new ArrayList();
           
            Query7 = "update daily set daily.opening=daily.closing, daily.sales=0";
                psmt_clo = con.prepareStatement(Query7);
                
                psmt_clo.executeUpdate();


           Query_sal = "update daily, stock set daily.closing=stock.numberofbottles where stock.Barcode=daily.barcode";
                psmt_sal = con.prepareStatement(Query_sal);
                psmt_sal.executeUpdate();

            Query_sales="update daily set daily.sales=daily.opening-daily.closing+daily.incoming ";
                psmt_sales = con.prepareStatement(Query_sales);
                psmt_sales.executeUpdate();

                 psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            while(res.next())
            {
                //Barcode = res.getLong("Stock.Barcode");
                Category = res.getString("Category");
                //Brand = res.getString("Stock.Brand");
                //Product = res.getString("Stock.ProductName");
                //Volume = res.getInt("Stock.Litres");
                Opening = res.getInt("opening");
                Closing = res.getInt("closing");
                Incoming = res.getInt("Incoming");
                //Price = res.getDouble("Stock.Price");
                //if(Category.equals("softdrinks")){
                  //  Price*=1.145;
                sales= res.getInt("sales");
                total=res.getFloat("total");
                gr_total+=total;
                //}
                
                //System.out.println("Category: " + Category + "\nBrand: " + Brand + "\nProduct: "+ Product + "\n:Volume: "+ Volume + "\nNumberOfBottles: "+ NumberOfBottles + "\nClosing" + Closing + "\nPrice: " + Price);
                //Sold = Opening + Incoming - Closing;
                //Price = Price * Sold;
                
                /* Daily Closing Update */
                

                /*FILE SENDING */
                A1.add(Category);
                //A1.add(Brand);
                //A1.add(Product);
                //A1.add(String.valueOf(Volume));
                A1.add(String.valueOf(Opening));
                A1.add(String.valueOf(Closing));
                A1.add(String.valueOf(Incoming));
                A1.add(String.valueOf(sales));
                A1.add(String.valueOf(total));
                //A1.add(String.valueOf(Price));
                
                /* Daily Closing Update */
                
                
               
                /* Weekly Update*/
                
              /*  Query3 = "UPDATE weekly SET Sales = Sales + ?,Closing = ? WHERE Barcode = ?";
                psmt3 = con.prepareStatement(Query3);
                psmt3.setInt(1, Sold);
                psmt3.setInt(2, Closing);
                
                psmt3.setLong(3, Barcode);
                psmt3.executeUpdate();
                
                /* Monthly Update*/
                
              /*  Query4 = "UPDATE monthly SET Sales = Sales + ?,Closing = ? WHERE Barcode = ?";
                psmt4 = con.prepareStatement(Query4);
                psmt4.setInt(1, Sold);
                psmt4.setInt(2, Closing);
                
                psmt4.setLong(3, Barcode);
                psmt4.executeUpdate();
                
                /* Daily table make 0*/
                
             /*   Query5 = "UPDATE daily SET Sales = 0, NumberOfBottles = ?, Closing = 0, Incoming = 0 WHERE Barcode = ?";
                psmt5 = con.prepareStatement(Query5);
                psmt5.setInt(1, Closing);
                psmt5.setLong(2, Barcode);
                psmt5.executeUpdate();*/
                //System.out.println(A1);
                
            }

            DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
            Date date1 = new Date();
            String d1 = dateFormat1.format(date1);
            d1+="%";
            //System.out.println("d1="+d1);
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

            System.out.println(A1);

            System.out.println(A1);
           String Query_set_incoming = "update daily set incoming=0 ";
                psmt_sal = con.prepareStatement(Query_set_incoming);
                psmt_sal.executeUpdate();
                
            return w2E.writeExcel(A1, "C:\\Reports_Daily\\");
            
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
    }
    
    public static void main(String args[])
    {
        reportDaily rD1 = new reportDaily();
     
        
        System.out.println(rD1.getData());
    }
  
}
