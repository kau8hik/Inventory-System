<%-- 
    Document   : bill_update
    Created on : 11 Mar, 2013, 3:00:57 PM
    Author     : Kaushikn
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
         String noofbottles1= request.getParameter("noofbottles_update");
         int noofbottles=Integer.parseInt(noofbottles1);
         String barcode =request.getParameter("barcode_update");


         //out.println(noofbottles+barcode);
         try {
            int flag=0;
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            PreparedStatement psmt, psmt3, psmt1, psmt2, psmt_ret_temp, psmt_total, psmt12;
            ResultSet res, res1, res2, res3, res_total, res12;
            int total = 0;
            String a=new String();
            
           
         
            if(noofbottles1.equals("0")){
               a  = "delete from temp where barcode='"+barcode+"'";
               psmt = con.prepareStatement(a);
               psmt.executeUpdate();
            }
            else{

                
                        a = "update temp set noofbottles="+noofbottles+", price=price_bot*noofbottles, litres=net_qu*noofbottles where barcode ='"+barcode+"'" ;

                    }
                  
                     
                    psmt = con.prepareStatement(a);
                    psmt.executeUpdate();
                    
             

                        //


              

                 
            

            //out.println(a);
            
            response.sendRedirect("Bill_user.jsp");;
            }catch(Exception e){
                out.println(e.getMessage());
            }

        %>
    </body>
</html>
