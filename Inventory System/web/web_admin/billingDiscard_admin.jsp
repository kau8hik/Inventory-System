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
        session.setMaxInactiveInterval(15 * 60);
        int bill_id = (Integer) session.getAttribute("bill_id");
        String uname = (String) session.getAttribute("uname");
        //String discount=(String) session.getAttribute("discount");
        //int dis=Integer.parseInt(discount);
        //out.println(discount);
        if (uname == null) {
            session.setAttribute("from_page", "billingDiscard_admin.jsp");
            response.sendRedirect("../take_login.jsp");
        }
        String table=new String();
        switch(bill_id){
            case 1: table="temp";break;
            case 2: table="temp_bill2";break;
            case 3: table="temp_bill3";break;
            case 4: table="temp_bill4";break;
            case 5: table="temp_bill5";break;
        }

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
            psmt = con.prepareStatement("delete from "+table);
            psmt.execute();
            response.sendRedirect("Bill_admin.jsp");
                   }
        catch(Exception ex)
                               {
            out.println(ex.getMessage());
        }
        %>
    </body>
</html>
