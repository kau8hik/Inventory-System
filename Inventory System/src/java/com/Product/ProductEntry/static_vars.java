/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Product.ProductEntry;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Kaushikn
 */
public class static_vars {
    public static long billno;
    public void reset_billno(){
        int n=10;
         DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"+n);
       //get current date time with Date()
       Date date = new Date();
       String d=dateFormat.format(date);
       billno=Long.parseLong(d);
             
    }
    public void another_function(){billno++;System.out.println(billno);}
    public static void main(String args[]){
        static_vars sv=new static_vars();
        sv.reset_billno();
        sv.another_function();
       
    }

}
