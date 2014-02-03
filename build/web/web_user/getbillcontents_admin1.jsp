<%@page import="com.Product.ProductEntry.databaseConnection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Product.ProductEntry.billGetData"%>
<%@page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>
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

                <li><a href="Bill_admin.jsp">Billing </a>
                    <ul>
                        <li><a href="billdelete_admin.html"  class="headerLinks">Delete Bill</a></li>
                        <li><a href="getbillcontents_admin.html"  class="headerLinks">Bill Contents</a></li>
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
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br><br>
                        <%
                        try {
                            String billno = request.getParameter("billid");
                            String delimiter = "|";
                            String[] temp;
                            ArrayList A1 = new ArrayList();
                            databaseConnection dC1 = new databaseConnection();
                            Connection con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
                            String Query = "SELECT * FROM billingtable WHERE billid='" + billno + "'";
                            //out.println(Query);
                            A1 = new ArrayList();
                            PreparedStatement psmt = con.prepareStatement(Query);
                            ResultSet res = psmt.executeQuery();
                            String contents = new String();
                            float total = 0.0f;
                            Date date = new Date();
                            while (res.next()) {
                                contents = res.getString("Contents");
                                //out.println("contents:"+contents);
                                total = res.getFloat("TotalCost");
                                date = res.getDate("date");
                            }

                            // out.println("contents:"+contents);
                            // getting contents
                            String[] s = new String[100];
                            int start = 1;
                            int end;
                            int s_len = 0;
                            for (int i = 1; i < contents.length(); i++) {
                                if (contents.charAt(i) == '|') {
                                    end = i;
                                    s[s_len] = contents.substring(start, end);
                                    // out.println(s[s_len]);
                                    s_len++;
                                    start = i + 1;
                                }
                            }
                            //for(int i=0;i<s_len;i++)
                            //out.println(s[i]);
                            String barcode = new String();
                            String category = new String();
                            String brand = new String();
                            String productname = new String();
                            String price = new String();
                            String quantity = new String();
                        %>
                        <table align="center" border="1" width="75%">
                            <tr>
                                <th>Barcode</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Product Name</th>
                                <th>Price</th>
                                <th>quantity</th>
                            </tr>

                            <%

                               int noofbottles;
                               int bar = 0;
                               int noofbot = 5;
                               for (int i = 0; i < s_len; i++) {
                                   barcode = s[i];i++;
                                   quantity = s[i];
                                   //out.println(barcode);
                                   String quer="select * from stock where barcode ="+barcode;
                                   PreparedStatement p= con.prepareStatement(quer);
                                   //out.println(quer);
                                   ResultSet res1=p.executeQuery();
                                   while(res1.next()){
                                       category=res1.getString("category");
                                       //out.println(category);
                                       brand=res1.getString("brand");
                                       productname=res1.getString("productname");
                                       price=res1.getString("price");
                                   

                                   /*category = s[i];
                                   i++;
                                   brand = s[i];
                                   i++;
                                   productname = s[i];
                                   i++;
                                   price = s[i];
                                   i++;*/
                                   
                                   //out.println(barcode);
                            %>

                                <tr>
                                    <td align="center"><%=barcode%></td>
                                    <td align="center"><%=category%></td>
                                    <td align="center"><%=brand%></td>
                                    <td align="center"><%=productname%></td>
                                    <td align="center"><%=price%></td>
                                    <td align="center"><%=quantity%></td>
                                </tr>

                            <%
                                    }
                                }
                            %>
                        </table>
                            <%
                               //out.println(contents+total+date);
                                } catch (Exception e) {
                                    out.println(e.getMessage());
                                }

                            %>
                    </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
