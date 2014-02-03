<%-- 
    Document   : stockadd
    Created on : Sep 15, 2012, 1:29:03 PM
    Author     : I067515
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.Product.ProductEntry.*" %>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "stockadd_user1.jsp");
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

                <li><a href="Bill_user.jsp">Billing </a>
                    <ul>
                        <li><a href="billdelete_user.jsp"  class="headerLinks">Delete Bill</a></li>
                        <li><a href="getbillcontents_user.jsp"  class="headerLinks">Bill Contents</a></li>
                    </ul>
                </li>

                <li><a href="bringstock_user.jsp">Stock</a>
                    <ul>
                        <li><a href="stockView_user.jsp"  class="headerLinks">Stock View</a></li>
                        <li><a href="stock_update1_user.jsp"  class="headerLinks"> Stock Update</a></li>
                        <li><a href="lowonstock1_user.jsp"  class="headerLinks"> Lowonstock</a></li>
                        <li><a href="show_permitno_contents_user.jsp"  class="headerLinks"> Show Permit no Contents</a></li>
                    </ul>
                </li>

                <li><a href="Report.jsp"  >Reports</a>
                    <ul>
                        <li><a href="reportDaily_user.jsp"  class="headerLinks"> Report Daily</a></li>
                        <li><a href="reportMonthly_user.jsp"  class="headerLinks"> Report Monthly</a></li>
                    </ul>
                </li>

                <li><a href="#"  >Credits</a>
                    <ul>
                        <li><a href="credit_add_user.jsp"  class="headerLinks"> Add to credit</a></li>
                        <li><a href="credit_show_user.jsp"  class="headerLinks"> Show Credits</a></li>
                    </ul>
                </li>

                <li><a href="stockadd_user.jsp"  >Add New Product</a>
                    <ul>
                        <li><a href="stockadd_user.jsp"  class="headerLinks"> Add New Product</a></li>
                        <li><a href="product_update_user.jsp"  class="headerLinks"> Product Update</a></li>
                    </ul>
                </li>

            </ul>
        </div>
		<pre>
        Logged in as : <%=uname%>                                                                                          <a href="../logout.jsp">Logout</a></pre>
        <br>
        <table width="100%"  border=1>

            <%
                productEntry p1 = new productEntry();
                // , ;
                long barcode = Long.valueOf(request.getParameter("Barcode"));
                int volume = Integer.valueOf(request.getParameter("Volume"));
                int numberOfBottles = Integer.valueOf(request.getParameter("NumberOfBottles"));
                String category = request.getParameter("Category");
                String brand = request.getParameter("Brand");
                Float price = Float.valueOf(request.getParameter("Price"));
                String productName = request.getParameter("ProductName");
                int min_stock=Integer.valueOf(request.getParameter("min_stock"));
                int max_stock=Integer.valueOf(request.getParameter("max_stock"));
                String value = p1.addProduct(barcode, volume, numberOfBottles, category, brand, price, productName, min_stock, max_stock);
                out.write("<script type='text/javascript'>\n");
                out.write("alert('"+value+"');\n");
                out.write("setTimeout(function(){window.location.href='stockadd_user.jsp'},1000);");
                out.write("</script>\n");
                //response.sendRedirect("stockadd_user.jsp");
            %>
            <script>
                alert("Result:"+<%=value%>);
            </script>
        </table>
    </body>
</html>
