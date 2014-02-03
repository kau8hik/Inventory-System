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
public class Info_bill {
    ArrayList funt(String id,int noofbottles) throws SQLException{
        ArrayList a1l= new ArrayList();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
        PreparedStatement psmt,psm,psmt3,psmt_ret_temp,psmt_total;
        ResultSet res,res1,res3,res_ret_temp,res_total;
        //String id = request.getParameter("id");
        int total=0;
        //int noofbottles=Integer.parseInt(request.getParameter("noofbottles"));
        //out.println(id);
        String Query="Select * from stock where barcode ="+id;
        //out.println(Query);
        //out.println(Query);
        psmt = con.prepareStatement(Query);
        res = psmt.executeQuery();
        String Category="kau",category_ret_temp=null;
        String Brand=null,Product=null;
        int Volume=0,noofbottles1=0;
        float Price=0;
        while(res.next())
        {
            Category = res.getString("Category");
            Brand = res.getString("Brand");
            Product = res.getString("ProductName");
            Volume = res.getInt("Litres");
            Volume=Volume*noofbottles;
            noofbottles1 = res.getInt("NumberOfBottles");
            Price = res.getFloat("Price");
            Price*=noofbottles;
         }
        if(Category.equals("kau")){
            a1l.add(1);
            a1l.add("Barcode does not exist");}
        else if(noofbottles>noofbottles1){
            a1l.add(2);
            a1l.add("Dont have sufficient stock");
        }
        else if(Volume>4500){
            a1l.add(3);
            a1l.add("go to next bill volume exceeding 4.5L");
        }

        else{
            String Query_ret_temp="Select * from temp where barcode ="+id;
            psmt_ret_temp = con.prepareStatement(Query_ret_temp);
            res_ret_temp = psmt_ret_temp.executeQuery();
            while(res_ret_temp.next()){
                category_ret_temp = res_ret_temp.getString("Category");
            }
            //out.println("category_ret_temp="+category_ret_temp);
            if(category_ret_temp==null){
                String Query1="insert into temp values("+id+",'"+Category+"','"+Brand+"','"+Product+"',"+Volume+","+noofbottles+","+Price+")";
                psmt = con.prepareStatement(Query1);
                psmt.execute();
            }
            else{
                String Query1_update_tmp="update temp set price=price+"+Price+",noofbottles=noofbottles+"+noofbottles+" where barcode="+id;
                psmt = con.prepareStatement(Query1_update_tmp);
                psmt.execute();
            }
            //out.println(Query1);
            //out.println(res1);

            String Query2="Select * from temp ";
            //out.println(Query);
            //out.println(Query2);
            psmt3 = con.prepareStatement(Query2);
            res3 = psmt3.executeQuery();
            a1l.add(4);
            while(res3.next()){
                a1l.add(res3.getString("barcode"));
                a1l.add(res3.getString("category"));
                a1l.add(res3.getString("brand"));
                a1l.add(res3.getString("product"));
                a1l.add(res3.getString("liters"));
                a1l.add(res3.getString(6));
                a1l.add(res3.getString(7));
            }

          String Query_total="SELECT sum( Price ) as t FROM temp";
            psmt_total= con.prepareStatement(Query_total);
            res_total = psmt_total.executeQuery();
            while(res_total.next())total = res_total.getInt("t");

    }
    return a1l;
}
}
