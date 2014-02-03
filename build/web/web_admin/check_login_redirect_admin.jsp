<%-- 
    Document   : check_login_redirect
    Created on : 25 Mar, 2013, 3:31:36 PM
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
         <%
            String from_page =  (String)session.getAttribute("from_page");
            //out.println("from page"+from_page);
            String uname=request.getParameter("uname");
            //out.println(uname);
            String password=request.getParameter("password");
            String uname_db=new String();String password_db=new String();
                int admin_db=0;
            //out.println(password);

            try {
                Class.forName("com.mysql.jdbc.Driver");            
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                PreparedStatement psmt,psmt_n,psmt_n1, psm, psmt1, psmt3,psmt7, psmt_ret_temp, psmt_total, psmt12;
                ResultSet res, res_n,res_n1, res1, res3, res7, res_ret_temp, res_total, res12;
                String query="select * from login where username='"+uname+"'";
                //out.println(query);
                psmt = con.prepareStatement(query);
                res = psmt.executeQuery(); 
                
                while (res.next()) {
                    uname_db = res.getString("username");
                    password_db = res.getString("password");
                    admin_db=res.getInt("admin");                    
                }
                out.println(uname_db+password_db);

            } catch(Exception e){out.println(e.getMessage());}

            if(uname.equals(uname_db) && password.equals(password_db)){
                session.setAttribute("uname", uname);
               if(from_page==null){
                   if(admin_db==1)   response.sendRedirect("Bill_admin.jsp");
                   else response.sendRedirect("Bill_user.jsp");
                   }
                else{
                    if(admin_db==1) response.sendRedirect(from_page+"_admin.jsp");
                    else response.sendRedirect(from_page+".jsp");
                    }
            }
            else{
                %>
                <script>
                    alert("incorrect username or password");

                    window.location = "take_login_admin.jsp";
                </script>
            <%}

        %>
    </body>
</html>
