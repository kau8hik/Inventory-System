/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package test;

/**
 *
 * @author Kaushikn
 */

 import java.awt.Color;
import java.awt.Font;
import java.util.Date;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Line2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class printing implements Printable {
    static int a=0;
  public static void main(String[] args) throws PrinterException {

    printing example1 = new printing();

  }

  //--- Private instances declarations
  private final double INCH = 72;

  /**
   * Constructor: Example1
   * <p>
   *
   */
  public printing() throws PrinterException {

    //--- Create a printerJob object
    PrinterJob printJob = PrinterJob.getPrinterJob();

    //--- Set the printable class to this one since we
    //--- are implementing the Printable interface
    printJob.setPrintable(this);

    //--- Show a print dialog to the user. If the user
    //--- click the print button, then print otherwise
    //--- cancel the print job
    printJob.print();
            


  }

  /**
   * Method: print
   * <p>
   *
   * This class is responsible for rendering a page using the provided
   * parameters. The result will be a grid where each cell will be half an
   * inch by half an inch.
   *
   * @param g
   *            a value of type Graphics
   * @param pageFormat
   *            a value of type PageFormat
   * @param page
   *            a value of type int
   * @return a value of type int
   */
  public int print(Graphics g, PageFormat pageFormat, int page) {


   

    //--- Validate the page number, we only print the first page
    if (page == 0) {  //--- Create a graphic2D object a set the default parameters
      
      
      
      int price=0;
       try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            
            
                ArrayList al=new ArrayList();
             Graphics2D g2d;
            Line2D.Double line = new Line2D.Double();
            g2d = (Graphics2D) g;
            g2d.setColor(Color.black);

            String query1="select min(billid)from temp2";
            PreparedStatement psmt1 = con.prepareStatement(query1);
            ResultSet res1=psmt1.executeQuery();
            Long billid=0l;
            while(res1.next()) billid=res1.getLong(1);
            System.out.println(billid);
            String Query2 = "SELECT * FROM temp2, stock WHERE temp2.barcode=stock.barcode and billid='"+billid+"'";
            System.out.print(Query2);
            PreparedStatement psmt = con.prepareStatement(Query2);
            ResultSet res=psmt.executeQuery();
            int disc=0;
            while(res.next())
            {
                String category=new String();
                category=res.getString("category");
                disc=res.getInt("discount");
                //System.out.println("disc"+disc);
                String brand=res.getString("brand");
                //System.out.println(brand);
                String product_name=res.getString("productname");
                //System.out.println(product_name);
                String net_qu=res.getString("net_qu");
                //System.out.println(net_qu);
                String particular=brand.substring(0,4)+product_name.substring(0,4)+net_qu;
                //System.out.println(particular);
                al.add(particular);
                al.add(res.getString("noofbottles"));
                float price1=res.getFloat("price");
                //  if(category.equals("soft drinks")) price1*=1.14;

                al.add(Float.toString(price1));
                //System.out.println(al);
                int amt=(int) (res.getInt("noofbottles") * price1);
                String a=Integer.toString(amt);

                
                al.add(a);
                price+=amt;
                System.out.println(price);
            }
            int aftdisprice=(100-disc)*price/100;
            int discount=price-aftdisprice;
            //System.out.println("discount="+disc);
        


      //--- Translate the origin to be (0,0)
      g2d.translate(pageFormat.getImageableX(), pageFormat
          .getImageableY());
      //line.setLine(100, 100, 200, 200);
      Font font = new Font("Brush Script MT", Font.ITALIC, 18);
      Font font1 = new Font("Arial", Font.PLAIN, 8);
      Font font2 = new Font("Arial", Font.PLAIN, 6);
      
      g2d.setFont(font2);
      g2d.drawString("Since 1946", 70, 80);
      g2d.drawString("CASH BILL", 200, 80);
      g2d.drawString("Phone:22214945", 320, 80);
      g2d.setFont(font);
        g2d.drawString("Dewars Wine Stores", 160, 100);
        g2d.setFont(font1);
        g2d.drawString("#25, St. Mark's Road, Bangalore-560001", 150, 115);
        g2d.drawString("", 200, 130);
        g2d.drawLine(70, 150, 370, 150);
        g2d.drawString("Particulars", 70, 165);
        g2d.drawString("Qty", 160, 165);
        g2d.drawString("Rate", 250, 165);
        g2d.drawString("Amount", 340, 165);
        g2d.drawLine(70, 175, 370, 175);
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            Date date=new Date();
               String d=dateFormat.format(date);
        //System.out.print(d);
        g2d.drawString("Date:"+d, 70, 145);


        
            g2d.drawString("Billno:"+billid, 300, 145);
            


        int y=180;int x1=70,x2=160,x3=250,x4=340;
        int j=0;
        for(int i=0;i<al.size()/4;i++){
            y+=15;
            g2d.drawString((String) al.get(j), x1, y);j++;
            g2d.drawString((String) al.get(j), x2, y);j++;
            g2d.drawString((String) al.get(j), x3, y);j++;
            g2d.drawString((String) al.get(j), x4, y);j++;
        }
        g2d.drawLine(70, y=y+10, 370, y);
        g2d.drawString("Sum", x3, y+15);
        g2d.drawString( String.valueOf(price), x4, y+15);
        System.out.println(price);
        g2d.drawString("Discount", x3, y+25);
        g2d.drawString( String.valueOf(discount), x4, y+25);
        g2d.drawString("Total", x3, y+35);
        g2d.drawString( String.valueOf(aftdisprice), x4, y+35);
        g2d.drawLine(70, y+45, 370, y+45);
        
        g2d.setFont(font2);
        g2d.drawString("TIN 29670465098", x1, y+55);
        g2d.drawString("Prices inclusive of all taxes", x1, y+65);
        g2d.drawString("Goods once sold cannot be taken back", x1, y+75);
        g2d.drawString("We have no branches", x1, y+85);
        g2d.drawLine(70, y+95, 370, y+95);
          //g2d.draw(line);
    /*  //--- Print the vertical lines
      for (i = 0; i < pageFormat.getWidth(); i += INCH / 2) {
        line.setLine(i, 0, i, pageFormat.getHeight());
        g2d.draw(line);
      }

      //--- Print the horizontal lines
      for (i = 0; i < pageFormat.getHeight(); i += INCH / 2) {
        line.setLine(0, i, pageFormat.getWidth(), i);
        g2d.draw(line);
      }*/

            
}catch(Exception e){}
      return (PAGE_EXISTS);
    } else
      return (NO_SUCH_PAGE);
  }


}
