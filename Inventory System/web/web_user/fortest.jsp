<%-- 
    Document   : fortest
    Created on : 23 Apr, 2013, 11:58:01 PM
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
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            PreparedStatement psmt,psmt1,psmt3,psmt_ret_temp,psmt_total,psmt12;
            ResultSet res,res1,res3,res_ret_temp,res_total,res12;
            String Query="Select contents from billingtable where billid = 2013042330";
            psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            String str=new String();
            while(res.next()) str=res.getString("contents");
            String[] s=new String[100];int start=1;int end;int s_len=0;
            for(int i=1;i<str.length();i++){
                if(str.charAt(i)=='|'){
                    end=i;
                    s[s_len]=str.substring(start, end);s_len++;
                    start=i+1;
                 }
            }
            for(int i=0;i<s_len;i++) out.println(s[i]);
            String barcode=new String();int noofbottles;
            int bar=0;int noofbot=1;
            for(int i=0;i<s_len/2;i++){
                barcode=s[bar];bar+=2;
                noofbottles=Integer.parseInt(s[noofbot]);noofbot+=2;
                out.println(barcode+":"+noofbottles);
                String quer="update stock set numberofbottles=numberofbottles+"+noofbottles+" where barcode="+barcode;
                out.println(quer);
                psmt = con.prepareStatement(quer);
                //psmt.executeUpdate();

            }
        %>
    </body>
</html>
