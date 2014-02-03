<%-- 
    Document   : reportMonthly
    Created on : Sep 16, 2012, 3:56:30 PM
    Author     : I067515
--%>

<%@page import="com.Product.ProductEntry.reportMonthly"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            reportMonthly rD1 = new reportMonthly();
            String result = rD1.getData();
            //out.println(result);
            String filepath = "C:\\Reports_Monthly\\";
            if(result.equals("Success"))
            {
                out.println("Report generated for today under path "+ filepath);
            }
            else
            {
                out.println(result);
            }
        %>
    </body>
</html>
