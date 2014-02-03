<%-- 
    Document   : billingDiscard
    Created on : Oct 13, 2012, 5:21:53 PM
    Author     : I067515
--%>


<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Connection con;
        PreparedStatement psmt;
        ResultSet res;
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
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt = con.prepareStatement("DELETE FROM temp");
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
