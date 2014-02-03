<%-- 
    Document   : billingSaveAndPrint
    Created on : Oct 13, 2012, 5:27:22 PM
    Author     : I067515
--%>

<%@page import="test.printing"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
        
        Connection con;
        PreparedStatement psmt, psmt2,psmt1;
        ResultSet res,res1;
        float sum = 0f;
        try
                               {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception ex)
                               {
            out.println(ex.getMessage());
        }
        try
                               {
            ArrayList A1 = new ArrayList(); 
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt = con.prepareStatement("SELECT * FROM temp");
            res = psmt.executeQuery();
            while(res.next())
                                              {
                A1.add(res.getInt("barcode"));
                A1.add(res.getString("Category"));
                A1.add(res.getString("Brand"));
                A1.add(res.getString("Product"));
                A1.add(res.getInt("Litres"));
                A1.add(res.getInt("Noofbottles"));
                sum += res.getFloat("Price");
                psmt2 = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
                psmt2.setInt(1, res.getInt("Noofbottles"));
                psmt2.setInt(2, res.getInt("barcode"));
                psmt2.execute();   
            }

            printing example1 = new printing();
            psmt = con.prepareStatement("DELETE FROM temp");
            psmt.execute();



             DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
            Date date1=new Date();
               String d1=dateFormat1.format(date1);
               String qu="SELECT count( * ) as no FROM `billingtable` WHERE billid LIKE '"+d1+"%'";
               System.out.println("qu="+qu);
               psmt1 = con.prepareStatement(qu);
            res1 = psmt1.executeQuery();
            int n=0;
            out.println(n);
            while(res1.next()) n=res1.getInt("no");
            n+=1;
            out.println(n);

            Long billno;
            System.out.println("n="+n);
            System.out.println("yyyyMMdd"+n);

            DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"+n);
         //get current date time with Date()
            Date date=new Date();
               String d=dateFormat.format(date);
               out.println("d="+d);

              billno=Long.parseLong(d);
              out.println("billno="+billno);

            //psmt = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
            psmt = con.prepareStatement("INSERT INTO billingtable(Contents, TotalCost, Date, Billid) VALUES(?,?,now(),?)");
            String content= new String();
            for(int i=0;i<A1.size();i++){
                content += A1.get(i);
                }
            //System.out.println(content+sum);
            psmt.setString(1, content );
            psmt.setFloat(2, sum);
            psmt.setLong(3, billno);
            psmt.execute();
            response.sendRedirect("Bill_user.jsp");
        }
       
        catch(Exception ex)
                       {
            out.println(ex.getMessage());
        }
        
        %>
    </body>
</html>
