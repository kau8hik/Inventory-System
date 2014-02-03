<%-- 
    Document   : stockupdate
    Created on : 15 Sep, 2012, 5:28:58 PM
    Author     : Anil
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.Product.parallel.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        ArrayList barcode_al=new ArrayList();
        ArrayList barcode_qu=new ArrayList();

        barcode_al.add(request.getParameter("bar1"));
        barcode_al.add(request.getParameter("bar2"));
        barcode_al.add(request.getParameter("bar3"));
        barcode_al.add(request.getParameter("bar4"));
        barcode_al.add(request.getParameter("bar5"));
        barcode_al.add(request.getParameter("bar6"));
        barcode_al.add(request.getParameter("bar7"));
        barcode_al.add(request.getParameter("bar8"));
        barcode_al.add(request.getParameter("bar9"));
        barcode_al.add(request.getParameter("bar10"));
        barcode_qu.add(request.getParameter("noofbot1"));
        barcode_qu.add(request.getParameter("noofbot2"));
        barcode_qu.add(request.getParameter("noofbot3"));
        barcode_qu.add(request.getParameter("noofbot4"));
        barcode_qu.add(request.getParameter("noofbot5"));
        barcode_qu.add(request.getParameter("noofbot6"));
        barcode_qu.add(request.getParameter("noofbot7"));
        barcode_qu.add(request.getParameter("noofbot8"));
        barcode_qu.add(request.getParameter("noofbot9"));
        barcode_qu.add(request.getParameter("noofbot10"));
        /*
ArrayList al=new ArrayList();
        String per_no=request.getParameter("per_no");
        out.println(per_no);
        for(int i1=0;i1<barcode_qu.size();i1++){
            if(barcode_qu.get(i1)==""){
            }else al.add(barcode_qu.get(i1));
        }
        out.println(al);
        out.println(barcode_al.size());
        out.println(barcode_qu);
        /*
       Long barcode=Long.valueOf(request.getParameter("barcode"));
       barcode_al.add(barcode);

       int noofbottles=Integer.valueOf(request.getParameter("noofbottles"));
       barcode_qu.add(noofbottles);*/
         String perno=request.getParameter("per_no");
       stockUpdate sU1 = new stockUpdate();      
       String result = sU1.updateStock(perno,barcode_al,barcode_qu);
       out.println(result);
       %>
    </body>
</html>
