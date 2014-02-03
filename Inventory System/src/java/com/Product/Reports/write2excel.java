/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.Reports;
import java.io.File;
import java.io.IOException;
	import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
	import jxl.Workbook;
	import jxl.write.Label;
	import jxl.write.WritableSheet;
	import jxl.write.WritableWorkbook;



/**
 *
 * @author Anil
 */
public class write2excel {
    public String writeExcel(ArrayList result, String filename)
    {
        try{
                //System.out.println(result);
                Calendar currentDate = Calendar.getInstance();
                SimpleDateFormat formatter=
                new SimpleDateFormat("yyyy-MMM-dd_HH-mm-ss");
                String dateNow = formatter.format(currentDate.getTime());
                WritableWorkbook workbook = Workbook.createWorkbook(new File(filename+dateNow+".xls"));
                WritableSheet sheet = workbook.createSheet("First Sheet", 0);
                Label label1 = new Label(0, 0, "category");
                //Label label2 = new Label(1, 0, "brand");
                //Label label3 = new Label(2, 0, "product");
                //Label label4 = new Label(3, 0, "volume");
                Label label2 = new Label(1, 0, "opening");
                Label label3 = new Label(2, 0, "closing");
                Label label4 = new Label(3, 0, "Incoming");
                Label label5 = new Label(4, 0, "noofbottles sold");
                Label label6 = new Label(5, 0, "Total");
                //Label label9 = new Label(8, 0, "price");

                sheet.addCell(label1);sheet.addCell(label2);sheet.addCell(label3);
                sheet.addCell(label4);sheet.addCell(label5);sheet.addCell(label6);
                //sheet.addCell(label7);
                //sheet.addCell(label8);
                        int k=0;
                        int j=0;
                for(int i=0;i<result.size()/6;i++)
                {
                    k++;
                    jxl.write.Label number1 = new jxl.write.Label(0,k,(String) result.get(j));j++;
                    jxl.write.Label number2 = new jxl.write.Label(1,k,(String) result.get(j));j++;
                    jxl.write.Label number3 = new jxl.write.Label(2,k,(String) result.get(j));j++;
                    jxl.write.Label number4 = new jxl.write.Label(3,k,(String) result.get(j));j++;
                    jxl.write.Label number5 = new jxl.write.Label(4,k,(String) result.get(j));j++;
                    jxl.write.Label number6 = new jxl.write.Label(5,k,(String) result.get(j));j++;
                    //jxl.write.Label number7 = new jxl.write.Label(6,k,(String) result.get(j));j++;
                    //jxl.write.Label number8 = new jxl.write.Label(7,k,(String) result.get(j));j++;
                    //jxl.write.Label number9 = new jxl.write.Label(8,k,(String) result.get(j));j++;
                    sheet.addCell(number1);sheet.addCell(number2);sheet.addCell(number3);
                    sheet.addCell(number4);sheet.addCell(number5);sheet.addCell(number6);
                    //sheet.addCell(number7);sheet.addCell(number8);sheet.addCell(number9);                  
                    
                }
                
                        k++;
                Label label_t = new Label(4, k, "Grand total");
                sheet.addCell(label_t);
                System.out.println("j="+j);
                 
                jxl.write.Label number_h = new jxl.write.Label(5,k,(String) result.get(j));j++;
                sheet.addCell(number_h);
                k++;
                Label label_dis = new Label(4, k, "Discount");
                sheet.addCell(label_dis);
               
                //System.out.println("j="+j);
                jxl.write.Label number_dis_val = new jxl.write.Label(5,k,(String) result.get(j));j++;
                sheet.addCell(number_dis_val);
                k++;
                Label label_fi = new Label(4, k, "Final total");
                sheet.addCell(label_fi);

                jxl.write.Label number_fin = new jxl.write.Label(5,k, (String) result.get(j));
                sheet.addCell(number_fin);

                workbook.write();
                workbook.close();
                return "Success";
        }
        catch(Exception ex){
            return ex.getMessage();
        
        }

    }
    
    /*public static void main(String args[])
    {
        write2excel w2E1 = new write2excel();
        ArrayList A1 = new ArrayList();
        
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        A1.add("Pavan");
        
        String result = w2E1.writeExcel(A1, "C:\\Reports_Monthly\\");
        System.out.println(result);
        
                
    }*/
}