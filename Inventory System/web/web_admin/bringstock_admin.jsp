<%@page import="com.Product.ProductEntry.databaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "bringstock_admin.jsp");
    response.sendRedirect("../take_login.jsp");
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
                        <li><a href="billdelete_admin.jsp"  class="headerLinks">Delete Bill</a></li>
                        <li><a href="getbillcontents_admin.jsp"  class="headerLinks">Bill Contents</a></li>
                    </ul>
                </li>

                <li><a href="bringstock_admin.jsp">Stock</a>
                    <ul>
                        <li><a href="stockView_admin.jsp"  class="headerLinks">Stock View</a></li>
                        <li><a href="stock_update1_admin.jsp"  class="headerLinks"> Stock Update</a></li>
                        <li><a href="lowonstock1_admin.jsp"  class="headerLinks"> Lowonstock</a></li>
                        <li><a href="show_permitno_contents_admin.jsp"  class="headerLinks"> Show Permit no Contents</a></li>
                    </ul>
                </li>

                <li><a href="Report_admin.jsp"  >Reports</a>
                    <ul>
                        <li><a href="reportDaily_admin.jsp"  class="headerLinks"> Report Daily</a></li>
                        <li><a href="reportMonthly_admin.jsp"  class="headerLinks"> Report Monthly</a></li>
                    </ul>
                </li>

                <li><a href="#"  >Credits</a>
                    <ul>
                        
                        <li><a href="credit_show_admin.jsp"  class="headerLinks"> Show Credits</a></li>
                    </ul>
                </li>

                <li><a href="stockadd_admin.jsp"  >Add New Product</a>
                    <ul>
                        <li><a href="stockadd_admin.jsp"  class="headerLinks"> Add New Product</a></li>
                        <li><a href="product_update_admin.jsp"  class="headerLinks"> Product Update</a></li>
                    </ul>
                </li>

            </ul>
        </div>
		<pre>
        Logged in as : <%=uname%>                                                                                          <a href="../logout.jsp">Logout</a></pre>
        
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br><br>
                         <%
                         try
                         {
                            Connection con;
                            String Query, Result, product,brand,category;
                            int numberOfBottles;
                            float price,cost,totalcost=0;
                            int volume,bring;
                            long barcode;
                            PreparedStatement psmt;
                            ResultSet res;
                            ArrayList al=new ArrayList();

                            databaseConnection dC1 = new databaseConnection();
                            con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
                            Query = "SELECT min_stock-numberofbottles as bring,Price*(min_stock-numberofbottles) as cost, Category, Brand,price, ProductName, Litres FROM stock where numberofbottles<min_stock";

                            psmt = con.prepareStatement(Query);
                            //psmt.setString(1, Category);
                            res = psmt.executeQuery();
                            while(res.next()){
                                product = res.getString("ProductName");
                                cost = res.getFloat("cost") ;
                                volume = res.getInt("Litres");
                                price = res.getFloat("Price") ;
                                bring = res.getInt("bring");
                                brand = res.getString("Brand");
                                category = res.getString("Category");
                                totalcost+=cost;
                                al.add(category);

                                al.add(brand);
                                al.add(product);
                                al.add(volume);
                                al.add(price);
                                al.add(bring);
                                al.add(cost);
                            }

                        %>
                         <table border="1" align="center" width="60%">
                              <tr>
                                    <th>Category</th>
                                    <th>Brand</th>
                                    <th>Product</th>
                                    <th>Volume</th>
                                    <th>Price</th>
                                    <th>Bring</th>
                                    <th>Cost</th>
                               </tr>

                        <%
                        if(al.isEmpty())
                        {
                        %>
                        <script type="" >
                            alert("no data available");
                        </script>
                        <%

                 /*  try {
                         Thread.sleep(5000);
                    } catch(InterruptedException ex) {
                          Thread.currentThread().interrupt();
                    }*/
                //out.println("No stock available");
               // response.sendRedirect("Lowonstock.jsp");
                        }
                        else
                        {
                            int i=0;
                            int j=0;
                            for(i=0;i<al.size()/7;i++)
                            {
                        %>

                                <tr>
                                <td align="center"><% out.println(al.get(j)); j++; %></td>
                                <td align="center"><% out.println(al.get(j)); j++; %></td>
                                <td align="center"><% out.println(al.get(j)); j++; %></td>
                                <td align="center"><% out.println(al.get(j)); j++; %> </td>
                                <td align="center"><% out.println(al.get(j)); j++; %> </td>
                                <td align="center"><% out.println(al.get(j)); j++; %> </td>
                                <td align="center"><% out.println(al.get(j)); j++; %> </td>
                                </tr>

                        <%
                            }
                        %>
                                <tr>
                                    <td colspan="4"></td>
                                    <td align="center" colspan="2">Total Cost</td>
                                    <td align="center" colspan="2"><%=totalcost%></td>
                                </tr>
                         
                   <%
                        }
                   %>
                   </table>
                   <%
                    }
                   catch(Exception ex)
                   {
                       out.println(ex.getMessage());
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
