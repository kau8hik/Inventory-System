<%-- 
    Document   : logout
    Created on : 25 Mar, 2013, 3:55:13 PM
    Author     : Kaushikn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% session.removeAttribute("uname");
        session.removeAttribute("from_page");
        response.sendRedirect("../take_login.jsp");%>
    </body>
</html>
