<%-- 
    Document   : billingSave.jsp
    Created on : Oct 13, 2012, 4:58:37 PM
    Author     : I067515
--%>

<%@page import="com.Product.ProductEntry.credit_add"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Redirect"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        //String email=request.getParameter("email");
        
        //String ph_no=request.getParameter("email");
        
        //cvalue=Integer.parseInt(request.getParameter("sel"));
        //out.println(email);
       
        Connection con;
        PreparedStatement psmt, psmt2,psmt1;
        ResultSet res,res1;
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
            ArrayList A1 = new ArrayList(); 
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt = con.prepareStatement("SELECT * FROM temp");
            res = psmt.executeQuery();
            while(res.next())
                                              {
                A1.add(res.getInt("barcode"));
                A1.add(res.getString("Category"));
                A1.add(res.getString("Brand"));
                A1.add(res.getString("Product"));
                A1.add(res.getInt("Litres"));
                A1.add(res.getInt("Noofbottles"));
                sum += res.getFloat("Price");
                psmt2 = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
                psmt2.setInt(1, res.getInt("Noofbottles"));
                psmt2.setInt(2, res.getInt("barcode"));
                psmt2.execute();   
            }
            psmt = con.prepareStatement("DELETE FROM temp");
            psmt.execute();

            DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
            Date date1=new Date();
               String d1=dateFormat1.format(date1);
               String qu="SELECT count( * ) as no FROM `billingtable` WHERE billid LIKE '"+d1+"%'";
               //System.out.println("qu="+qu);
               psmt1 = con.prepareStatement(qu);
            res1 = psmt1.executeQuery();
            int n=0;
            while(res1.next()) n=res1.getInt("no");
            n++;
            Long billno;
            //System.out.println("n="+n);
            //System.out.println("yyyyMMdd"+n);
            DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"+n);
         //get current date time with Date()
            Date date=new Date();
               String d=dateFormat.format(date);
               //out.println("d="+d);

              billno=Long.parseLong(d);
             // out.println("billno="+billno);
            /*  if(cvalue!=0){
                  credit_add ca=new credit_add();
                  String bill_no=billno.toString();
                  String sum1=String.valueOf(sum );
                  //out.println(bill_no+sum1+email+ph_no);
                  ca.creditadd(bill_no, sum1, email, ph_no);

            }*/String content= new String();
            for(int i=0;i<A1.size();i++){
                content =content+"|" + A1.get(i);
                }content =content+"|";
            
            //psmt = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
            String quer="INSERT INTO billingtable(Contents, TotalCost, Date, Billid) VALUES('"+content+"',"+sum+",now(),"+billno+")";
              psmt = con.prepareStatement(quer);
            //out.println(quer);
            //out.println(content+sum+billno);
            //System.out.println(content+sum);
            out.write("<script type='text/javascript'>\n");
                out.write("alert(' Successfully saved');\n");
                out.write("setTimeout(function(){window.location.href='Bill_admin.jsp'},100);");
                out.write("</script>\n");
            
            

        
              //response.sendRedirect("Bill.jsp");
       }
        catch(Exception ex)
                       {

                out.write("<script type='text/javascript'>\n");
                out.write("alert('"+ex.getMessage()+"');\n");
                out.write("setTimeout(function(){window.location.href='Bill_admin.jsp'},1000);");
                out.write("</script>\n");
                }
        
        %>
    </body>
</html>
