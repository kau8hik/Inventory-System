<%@page import="com.Product.ProductEntry.credit_add"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Product.ProductEntry.billGetData"%>
<%@page import="java.sql.*" %>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "Bill");
    response.sendRedirect("take_login_admin.jsp");
  }
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta itemprop="image" content="dot.jpg"/>
        <title>	CANASPERA </title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta name="keywords"  />
        <link href="style1.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" language="javascript">
            function validateForm()
            {
                var x=document.input.id.value;
                var y=document.input.noofbottles.value;
                var digits = /^[0-9]{10}$/;
                var digit=/^[0-9]{1,3}$/;
                if(!x.match(digits)){
                    alert("Enter 10 digit no for barcode");return false;
                }
                if(!y.match(digit)){
                    alert("Enter 1-3 digits for quantity");return false;
                }
            }
            function validateForm1()
            {
                var x1=document.del.id1.value;
                var y1=document.del.noofbottles1.value;
                var digits1 = /^[0-9]{10}$/;
                var digit1=/^[0-9]{1,3}$/;
                if(!x1.match(digits1)){
                    alert("Enter 10 digit no for barcode");return false;
                }
                if(!y1.match(digit1)){
                    alert("Enter 1-3 digits for quantity");return false;
                }
            }
        </script>
        <link rel="shortcut icon" href="favicon.ico" />
        <link rel="icon" type="image/gif" href="animated_favicon1.gif" ></link>
    </head>

    <body onload="if(typeof(initPage)=='function')initPage();">

        <div id="divpass" class="passbg"></div>

	<div id="topNav" class="list">

             <ul>

                <li><a href="Bill.jsp">Billing </a>
                    <ul>
                        <li><a href="billdelete_admin.html"  class="headerLinks">Delete Bill</a></li>
                    </ul>
                </li>

                <li><a href="bringstock_admin.jsp">Stock</a>
                    <ul>
                        <li><a href="stockView_admin.html"  class="headerLinks">Stock View</a></li>
                        <li><a href="stock_update1_admin.jsp"  class="headerLinks"> Stock Update</a></li>
                        <li><a href="lowonstock1_admin.jsp"  class="headerLinks"> Lowonstock</a></li>
                        <li><a href="show_permitno_contents_admin.html"  class="headerLinks"> Show Permit no Contents</a></li>
                    </ul>
                </li>

                <li><a href="Report_admin.jsp"  >Reports</a>
                    <ul>
                        <li><a href="reportDaily_admin.html"  class="headerLinks"> Report Daily</a></li>
                        <li><a href="reportMonthly_admin.html"  class="headerLinks"> Report Monthly</a></li>
                    </ul>
                </li>

                <li><a href="#"  >Credits</a>
                    <ul>
                        <li><a href="credit_add_admin.html"  class="headerLinks"> Add to credit</a></li>
                        <li><a href="credit_show_admin.jsp"  class="headerLinks"> Show Credits</a></li>
                    </ul>
                </li>

                <li><a href="stockadd_admin.html"  >Add New Product</a>
                    <ul>
                        <li><a href="stockadd_admin.html"  class="headerLinks"> Add New Product</a></li>
                        <li><a href="product_update_admin.html"  class="headerLinks"> Product Update</a></li>
                    </ul>
                </li>

            </ul>
        </div>
		<pre>
        Logged in as : <%=uname%>                                                                                          <a href="../logout.jsp">Logout</a></pre>
        <br>
        <table>
            <tr>
                <td>

                    <%
                        String comp_name=request.getParameter("company");
                        String ph_no=request.getParameter("ph_no");
                        String email=request.getParameter("email_id");
                        try {Class.forName("com.mysql.jdbc.Driver");}
                        catch (Exception ex){}
                        try
                        {
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                            PreparedStatement psmt,psm,psmt3,psmt_ret_temp,psmt_total,psmt12,psmt1;
                            ResultSet res,res1,res3,res_ret_temp,res_total,res12;
                            String Query_total="SELECT sum( Price ) as t FROM temp";
                            psmt_total= con.prepareStatement(Query_total);
                            res_total = psmt_total.executeQuery();
                            int total=0;
                            while(res_total.next())total = res_total.getInt("t");
                            credit_add ca= new credit_add();

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
                            String bill_amt=String.valueOf(total);
                            String output=ca.creditadd(d, bill_amt, email, ph_no);
                            response.sendRedirect("billingSaveAndPrint_admin.jsp");

                        }
                        catch(Exception e){ out.println(e.getMessage());}

                    %>

                </td>
             </tr>
        </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
