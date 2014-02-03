/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.parallel;

/**
 *
 * @author I067515
 */
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class stockUpdate {
    
    Connection con;
    String query1, query2, query3, query4,query_inst;
    PreparedStatement psmt1, psmt2, psmt3, psmt4;
    databaseConnection db1;
    ResultSet res;
    int i;
    int presentQuantity, finalquantity, presentIncoming;
    
    
    /*public void stockUpdate()
    {
        tablename[0] = "stock";
        tablename[1] = "daily";
        tablename[2] = "weekly";
        tablename[3] = "monthly";
    }*/
    
    
 /*   public String updateStock(String permit_no,ArrayList Barcode, ArrayList Quantity) throws SQLException, SQLException, SQLException
    {
        String tablename[] = {"Stock", "Daily", "Monthly", "Weekly"};
        db1 = new databaseConnection();
        con = db1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        i=0;
        try
        {
           
             for(int i=0; i<4;i++)
            {
                if(i>=1)
                {
                    query3 = "SELECT Incoming FROM " + tablename[i] + " WHERE Barcode = ?";
                    query4 = "UPDATE " + tablename[i] + " SET Incoming = ? WHERE Barcode = ?";
                    psmt3 = con.prepareStatement(query3);
                    psmt3.setLong(1, Barcode);
                    res = psmt3.executeQuery();
                    while(res.next())
                    {
                        presentIncoming = res.getInt("Incoming");
                        //presentQuantity = res.getInt("NumberOfBottles");
                    }
                    System.out.println("From Incoming:" +presentIncoming);
                    System.out.println("From Present :" +presentQuantity);
                    //presentQuantity += Quantity;
                    presentIncoming += Quantity;
                    //System.out.println("Updated qunaitty:"+presentQuantity);
                    System.out.println("Updated incoming:"+presentIncoming);
                    psmt4 = con.prepareStatement(query4);
                    psmt4.setInt(1, presentIncoming);
                    //psmt4.setInt(2, presentQuantity);
                    psmt4.setLong(2, Barcode);
                    psmt4.execute();
                }
                else
                {
                    System.out.println(tablename[i]);
                    query1 = "SELECT NumberOfBottles FROM "+ tablename[i] + " WHERE Barcode = ?";
                    query2 = "UPDATE " + tablename[i] + " SET NumberOfBottles = ? WHERE Barcode = ?";
                    psmt1 = con.prepareStatement(query1);
                    psmt1.setLong(1, Barcode);
                    res = psmt1.executeQuery();
                    while(res.next())
                    {
                        presentQuantity = res.getInt("NumberOfBottles");
                    }
                    finalquantity = presentQuantity + Quantity;
                    psmt2 = con.prepareStatement(query2);
                    psmt2.setInt(1, finalquantity);
                    psmt2.setLong(2, Barcode);
                    psmt2.executeUpdate() ;
                    finalquantity = presentQuantity = 0;
                }
            }


            return "Successfully updated!";
        }
        catch(SQLException ex)
        {
            return ex.getMessage();
        }
    }*/

     public String updateStock(String permit_no,ArrayList Barcode, ArrayList Quantity){
     ArrayList al_bar=new ArrayList();
        for(int i1=0;i1<Barcode.size();i1++){
            if(Barcode.get(i1)==""){
            }else al_bar.add(Barcode.get(i1));

        }
      ArrayList al_qu=new ArrayList();
        for(int i1=0;i1<Quantity.size();i1++){
            if(Barcode.get(i1)==""){
            }else al_qu.add(Quantity.get(i1));

        }


         String tablename[] = {"p_stock", "p_daily", "p_monthly", "Weekly"};
        db1 = new databaseConnection();
        con = db1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        try {
         for(int i2=0;i2<al_qu.size();i2++){
            for(int k=0;k<3;k++){
                query4 = "UPDATE " + tablename[k] + " SET  NumberOfBottles = NumberOfBottles+? WHERE Barcode = ?";
                if(k==1|| k==2){query4 = "UPDATE " + tablename[k] + " SET  incoming = incoming+? WHERE Barcode = ?";}
                psmt3 = con.prepareStatement(query4);
                psmt3.setInt(1, Integer.parseInt((String) al_qu.get(i2)));
                psmt3.setString(2, (String) al_bar.get(i2));
                psmt3.executeUpdate();
            }

          /*  query_inst = "insert into incoming_stock values('"+permit_no+"',?,?,now());";
            psmt1 = con.prepareStatement(query_inst);
            psmt1.setString(1,(String) al_bar.get(i2));
            psmt1.setInt(2, Integer.parseInt((String) al_qu.get(i2)));
            psmt1.execute();*/
         }
        } catch (SQLException ex) {
                    Logger.getLogger(stockUpdate.class.getName()).log(Level.SEVERE, null, ex);
                }
        return "Successfully updated!";
        }



    public static void main(String args[])
    {
        ArrayList barcode =new ArrayList();
        barcode.add("1234567890");
        barcode.add("1345679232");
        ArrayList quantity = new ArrayList();
        quantity.add("200");
        quantity.add("200");

        stockUpdate sU1 = new stockUpdate();
        String result = sU1.updateStock("per123",barcode,quantity);
        System.out.println(result);
    }
}
    

