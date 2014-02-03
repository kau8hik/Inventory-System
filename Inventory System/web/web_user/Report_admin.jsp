
<%@page import="com.Product.ProductEntry.databaseConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>

<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "Report_admin.jsp");
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
                var x=document.input.per_no.value;

                var digits = /^[0-9]{9,12}$/;
                var digit=/^[0-9a-zA-Z]*$/;
                if(!x.match(digit)){
                  alert("Enter vaild permit no");return false;
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

                <li><a href="Report_admin_admin.jsp"  >Reports</a>
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
                       
                        PreparedStatement psmt_sales, psmt;
                        ResultSet res;
                        ArrayList al = new ArrayList();
                        databaseConnection dC1 = new databaseConnection();
                        Connection con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
                        String Query_sales = "update daily,stock set daily.sales=daily.numberofbottles-daily.closing where stock.Barcode=daily.barcode";
                        psmt_sales = con.prepareStatement(Query_sales);
                        psmt_sales.executeUpdate();

                        String Query = "SELECT sum(price*sales) as price_sales, sum(sales) as sales, daily.numberofbottles as opening, daily.closing, stock.category FROM daily, stock where stock.barcode=daily.barcode group by stock.category";
                        psmt = con.prepareStatement(Query);
                        res = psmt.executeQuery();
                        while (res.next()) {
                            //out.println(res.getString("category"));
                            String category = res.getString("category");
                            al.add(category);
                            String opening = res.getString("opening");
                            al.add(opening);
                            String closing = res.getString("closing");
                            al.add(closing);
                            Double price_sales = res.getDouble("price_sales");
                            al.add(res.getInt("sales"));
                            if (category.equals("softdrinks")) {
                                price_sales *= 1.145;
                            }
                            al.add(price_sales);

                            // out.println(res.getInt("price_sales"));

                            //out.println(res.getInt("sales"));

                        }

                    %>
                 <table border="1" align="center">
                        <thead>
                        <tr>
                        <th>Category</th>
                        
                        <th>Opening</th>
                        <th>Closing</th>
                        <th>Sales</th>
                        <th>Price</th>
                        </tr>
                        </thead>
                <%
                if(al.isEmpty())
                    {
                %>
                <script type="" >
                   alert("no stock available");
                </script>
               <%

                 /*  try {
                         Thread.sleep(5000);
                    } catch(InterruptedException ex) {
                          Thread.currentThread().interrupt();
                    }*/
                //out.println("No stock available");
               // response.sendRedirect("Lowonstock_admin.jsp");
                }
                    else
                    {
                        int i=0;
                        int j=0;
                        for(i=0;i<al.size()/5;i++)
                        {
                %>
                <tbody>
                <tr>
                <td align="center"><% out.println(al.get(j)); j++; %></td>
                <td align="center"><% out.println(al.get(j)); j++; %></td>
                <td align="center"><% out.println(al.get(j)); j++; %></td>
                <td align="center"><% out.println(al.get(j)); j++; %></td>
                <td align="center"><% out.println(al.get(j)); j++; %></td>
                </tr>
                </tbody>
                <%
                        }
                    }

                %>

            </table>

                     </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
