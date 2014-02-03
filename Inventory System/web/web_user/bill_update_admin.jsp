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
        <h1></h1>
        <%
         String noofbottles1= request.getParameter("noofbottles_update");
         int noofbottles=Integer.parseInt(noofbottles1);
         String barcode =request.getParameter("barcode_update");
         int bill_id=(Integer)session.getAttribute("bill_id");


         //out.println(noofbottles+barcode);
         try {
            int flag=0;
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            PreparedStatement psmt, psmt3, psmt1, psmt2, psmt_ret_temp, psmt_total, psmt12;
            ResultSet res, res1, res2, res3, res_total, res12;
            int total = 0;
            String a=new String();
            String table=new String();
            switch(bill_id){
                case 1: table="temp";break;
                case 2: table="temp_bill2";break;
                case 3: table="temp_bill3";break;
                case 4: table="temp_bill4";break;
                case 5: table="temp_bill5";break;
            }
           
         String redir=new String();
         switch(bill_id){
                case 1: redir="Bill_admin.jsp";break;
                case 2: redir="Bill2_admin.jsp";break;
                case 3: redir="Bill3_admin.jsp";break;
                case 4: redir="Bill4_admin.jsp";break;
                case 5: redir="Bill5_admin.jsp";break;
            }
            if(noofbottles1.equals("0")){
               a  = "delete from "+table+" where barcode='"+barcode+"'";
               psmt = con.prepareStatement(a);
               psmt.executeUpdate();

               switch(bill_id){
                    case 1: response.sendRedirect(redir);
                    case 2: response.sendRedirect(redir);
                    case 3: response.sendRedirect(redir);
                    case 4: response.sendRedirect(redir);
                    case 5: response.sendRedirect(redir);
                }
            }
            else{
                    String Query = "Select * from stock where barcode =" + barcode;
                    psmt = con.prepareStatement(Query);
                    res = psmt.executeQuery();
                    int no_of_bot=0;
                    while(res.next())
                         no_of_bot=res.getInt("numberofbottles");
                    //out.println(no_of_bot);

                    
                    if(noofbottles<=no_of_bot){
                        a = "update "+table+" set noofbottles="+noofbottles+", price=price_bot*noofbottles, litres=net_qu*noofbottles where barcode ='"+barcode+"'" ;
                        psmt = con.prepareStatement(a);
                        psmt.executeUpdate();
                        switch(bill_id){
                            case 1: response.sendRedirect(redir);
                            case 2: response.sendRedirect(redir);
                            case 3: response.sendRedirect(redir);
                            case 4: response.sendRedirect(redir);
                            case 5: response.sendRedirect(redir);
                        }
                    }
                    else {
                        out.write("<script type='text/javascript'>\n");
                        out.write("alert(' we have only "+no_of_bot+" bottle/s');\n");
                        out.write("setTimeout(function(){window.location.href='"+redir+"'},100);");
                        out.write("</script>\n");}
             }
          
            //out.println(a);
            
            //response.sendRedirect("Bill_admin.jsp");
            }catch(Exception e){
                out.println(e.getMessage());
            }

        %>
    </body>
</html>
