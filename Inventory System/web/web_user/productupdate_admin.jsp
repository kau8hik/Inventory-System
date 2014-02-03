<%@page import="com.Product.ProductEntry.databaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "productupdate_admin.jsp");
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
        <br>
        <br>
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br><br>
                     <%
                    try{
                        String barcode=request.getParameter("Barcode");
                        //out.println(barcode);
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                        PreparedStatement psmt,psm,psmt3,psmt_ret_temp,psmt_total,psmt12,psmt1;
                        ResultSet res,res1,res3,res_ret_temp,res_total,res12;
                        String Query="select * from stock where barcode="+barcode;
                        //out.println(Query);
                        psmt = con.prepareStatement(Query);
                        res = psmt.executeQuery();

                        String category=new String();
                        String brand=new String();
                        String productname=new String();
                        String litres=new String();
                        String price=new String();
                        String min_stock=new String();
                        String max_stock=new String();

                        while(res.next()){
                            category=res.getString("category");
                            brand=res.getString("brand");
                            productname= res.getString("productname");
                            litres=res.getString("litres");
                            price=res.getString("price");
                            min_stock=res.getString("min_stock");
                            max_stock=res.getString("max_stock");

                        }

                    %>
                    <form action="pro_upd_post.jsp" method="post">
                        <table width="306" border="1" align="center">
                            <tr>
                                <input type="hidden" name="barcode" value="<%=barcode%>"/>
                                <td align="center" width="172">Barcode</td>
                                <td align="left" width="118"> <%=barcode%></td>
                            </tr>

                              <tr>
                                <td align="center" width="172">Category</td>
                                <td align="center" width="118"><input name="category" type="text" value="<%=category%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center">Brand</td>
                                <td align="center"><input name="brand" type="text" value="<%=brand%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center">productName</td>
                                <td align="center"><input name="productname" type="text" value="<%=productname%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center"> quantity(litres)</td>
                                <td align="center"><input name="litres" type="text" value="<%=litres%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center">price</td>
                                <td align="center"><input name="price" type="text" value="<%=price%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center">min Stock</td>
                                <td align="center"><input name="min_stock" type="text" value="<%=min_stock%>" size="20" /></td>
                              </tr>
                              <tr>
                                <td align="center">max Stock</td>
                                <td align="center"><input name="max_stock" type="text" value="<%=max_stock%>" size="20" /></td>
                              </tr>
                        </table>
                        <pre>
<input name="Submit" type="submit" value="Submit" />
                        </pre>

                    </form>
                    <%
                    }catch(Exception e){ out.println(e.getMessage());}
                    %>

                     </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
