<%-- 
    Document   : summaryreport
    Created on : 14 Feb, 2013, 10:46:09 PM
    Author     : Kaushikn
--%>

<%@page import="java.sql.*"%>
<%@page import="com.Product.ProductEntry.databaseConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "summaryreport_admin.jsp");
    response.sendRedirect("../take_login.jsp");
  }
  %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
            String Brand = request.getParameter("Brand");
            String Category = request.getParameter("Category");
            String no=request.getParameter("no");
            PreparedStatement psmt_sales, psmt;
            ResultSet res;
            ArrayList al=new ArrayList();
             databaseConnection dC1 = new databaseConnection();
            Connection con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
            String Query_sales="update daily,stock set daily.sales=daily.numberofbottles-daily.closing where stock.Barcode=daily.barcode";
             psmt_sales = con.prepareStatement(Query_sales);
                psmt_sales.executeUpdate();
            
            String Query = "SELECT sum(price*sales) as price_sales, sum(sales) as sales, daily.numberofbottles as opening, daily.closing, stock.category FROM daily, stock where stock.barcode=daily.barcode group by stock.category";
            psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            while(res.next()){
                //out.println(res.getString("category"));
                al.add(res.getString("category"));
                al.add(res.getString("opening"));
                al.add(res.getString("closing"));
                al.add(res.getInt("sales"));
               
               // out.println(res.getInt("price_sales"));
                al.add(res.getInt("price_sales"));
                //out.println(res.getInt("sales"));
                
            }

     %>
         <table border="1">
                <thead>
                <tr>
                <th>Category</th>
                <th>Opening</th>
                <th>Closing</th>
                <th>Number of Bottles</th>
                
                <th>Price</th>
                </tr>
                </thead>
        <%
        if(al.isEmpty())
            {
        %>
            <script type="" >
                   alert("no stock available");
                    </script>
               <%

                 /*  try {
                         Thread.sleep(5000);
                    } catch(InterruptedException ex) {
                          Thread.currentThread().interrupt();
                    }*/
                //out.println("No stock available");
               // response.sendRedirect("Lowonstock_admin.html");
        }
            else
            {
                int i=0;
                int j=0;
                for(i=0;i<al.size()/5;i++)
                {
                %>
                <tbody>
                <tr>
                <td><% out.println(al.get(j)); j++; %></td>
                <td><% out.println(al.get(j)); j++; %></td>
                <td><% out.println(al.get(j)); j++; %></td>
                <td><% out.println(al.get(j)); j++; %></td>                
                <td><% out.println(al.get(j)); j++; %></td>
                </tr>
                </tbody>
        <%
                }
            }

        %>

</table>
    </body>
</html>
