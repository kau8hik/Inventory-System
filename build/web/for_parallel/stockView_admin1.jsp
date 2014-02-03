


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.Product.parallel.*"%>
<%@page import="java.util.Date"%>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "../for_parallel/stockView_admin1.jsp");
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

              

                <li><a href="#">Stock</a>
                    <ul>
                        <li><a href="stockView_admin.jsp"  class="headerLinks">Stock View</a></li>
                        <li><a href="stock_update1_admin.jsp"  class="headerLinks"> Stock Update</a></li>
                        <li><a href="lowonstock1_admin.jsp"  class="headerLinks"> Lowonstock</a></li>
                        <li><a href="show_permitno_contents_admin.jsp"  class="headerLinks"> Show Permit no Contents</a></li>
                    </ul>
                </li>

               

                <li><a href="#"  >Add New Product</a>
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
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br><br>
                       <%
                            String delimiter = "|";
                            String[] temp;
                            stockView sV1 = new stockView();
                            stockViewAll sVA1 = new stockViewAll();
                            stockViewBrand sVB1 = new stockViewBrand();
                            stockViewCategory sVC1 = new stockViewCategory();
                            ArrayList A1 = new ArrayList();
                            String Brand = request.getParameter("Brand");
                            String Category = request.getParameter("Category");
                            if((Category.equals("All")) && (Brand.equals("All")))
                            {
                                A1 = sVA1.getStockView();
                            }
                            else if(Category.equals("All") && (!Brand.equals("All")))
                            {
                                A1 = sVB1.getStockView(Brand);
                            }
                            else if(Brand.equals("All") && (!Category.equals("All")))
                            {
                                A1 = sVC1.getStockView(Category);
                            }
                            else
                            {
                                A1 = sV1.getStockView(Category, Brand);
                            }
                            if(A1.isEmpty())
                            {
                                out.println("No stock available");
                            }
                            else
                            {
                                int i=0;
                                int j=0;
                            //out.println(A1);
                                %>
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Barcode</th>
                                    <th>Category</th>
                                    <th>Brand</th>
                                    <th>Product</th>
                                    <th>Volume</th>
                                    <th>Number of Bottles</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                    <%
                        for(i=0;i<A1.size()/7;i++)
                        {
                    %>
                    <tbody>
                        <tr>
                            <td><% out.println(A1.get(j));
                                                    j++;%></td>
                            <td><% out.println(A1.get(j));
                                                    j++;%></td>
                            <td><% out.println(A1.get(j));
                                                    j++;%></td>
                            <td><% out.println(A1.get(j));
                                                    j++;%> </td>
                            <td><% out.println(A1.get(j));
                                                    j++;%> </td>
                            <td><% out.println(A1.get(j));
                                                    j++;%> </td>
                            <td><% out.println(A1.get(j));
                                                    j++;%> </td>
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
