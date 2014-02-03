<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Product.ProductEntry.billGetData"%>
<%@page import="java.sql.*" %>
<%
session.setMaxInactiveInterval(15*60);
int bill_id=(Integer) session.getAttribute("bill_id");
//out.println(bill_id);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "Bill_admin.jsp");
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
        </div><pre>
        Logged in as : <%=uname%>                                       Bill<%=bill_id%>                                              <a href="../logout.jsp">Logout</a></pre>
        <table width="100%"  border=1>
            <tr>           


                <td rowspan=2 width="56%" valign="top">
                <%

                try {
                    String table=new String();
                    switch(bill_id){
                        case 1: table="temp";break;
                        case 2: table="temp_bill2";break;
                        case 3: table="temp_bill3";break;
                        case 4: table="temp_bill4";break;
                        case 5: table="temp_bill5";break;
                    }
                     String discount=request.getParameter("discount");
                     session.setAttribute("discount", discount);
                     int dis=Integer.parseInt(discount);
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                        PreparedStatement psmt, psm, psmt1, psmt3, psmt_ret_temp, psmt_total, psmt12;
                        ResultSet res, res1, res3, res_ret_temp, res_total, res12;
                        int total = 0;
                        
                String Query2 = "Select * from "+table;
                psmt3 = con.prepareStatement(Query2);
                res3 = psmt3.executeQuery();
                String Query_total = "SELECT sum( Price ) as t FROM "+table;
                psmt_total = con.prepareStatement(Query_total);
                res_total = psmt_total.executeQuery();
                while (res_total.next()) {
                    total = res_total.getInt("t");
                }
            %>


                <table id="mytable" border="1" width=95% align="center"  >



                    <tr>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Product</th>
                         <th>Liters</th>
                        <th width="40">No Of Bottles</th>

                        <th>Price</th>
                        <th>Price*noofbottles</th>
                    </tr>

                    <%                   
                          while (res3.next()) {
                    %>

                    <tr>
                        <form action="bill_update_admin.jsp">
                            <input type="hidden" name="barcode_update" value=" <%= res3.getString(1)%>"/>

                            <td align="center"><%= res3.getString(2)%> </td>
                            <td align="center"><%= res3.getString(3)%> </td>
                            <td align="center"><%= res3.getString(4)%> </td>
                            <td align="center"><%= res3.getString(8)%> </td>
                            <td align="center" width="40"><%= res3.getString(6)%></td>

                            <td align="center"><%= res3.getString(9)%> </td>
                            <td align="center"><%= res3.getString(7)%> </td>
                        </form>

                    </tr>

                    <%
                           }
                    %>
                    <tr>
                        <td colspan="5"></td>
                        <td align="center"> Total </td>
                        <td align="center"> <%=total%> </td>
                    </tr>


                    <tr>
                        <td colspan="5"></td>
                        <td align="center"> Discount amount </td>
                        <td align="center"> <%=total-total*(100-dis)/100%>
                        </td>

                    </tr>
                        <tr>
                        <td colspan="5"></td>
                        <td align="center"> Total after discount</td>
                        <td align="center"> <%=total*(100-dis)/100%>
                        </td>

                    </tr>





                </table>

            <%
                }
                catch(Exception ex){
                    out.println(ex.getMessage());
                }
            %>

                </td>
                <td width="14%" height="222px">
                    <div align="center">Credit  :
                        <select onchange="javascript:credit(this)">
                            <option value="1" selected>No</option>
                            <option value="credit_add_admin">Yes</option>
                        </select>
                        <script type="text/javascript">
                        function credit(page)
                        {
                             window.location = page.value+".jsp";
                         }
                       </script>
                    </div>
                </td>
            </tr>

            <tr align="center" >



                <td height="222px">
                    
                    <br></br>
                    <form action="billingSaveAndPrint_admin.jsp" method="POST">
                        <input style="width:165px" type="submit" value="Save & Print"/>
                    </form>
                    <br></br>
                    <form action="billingDiscard_admin.jsp" method="POST">
                        <input style="width:165px" type="submit" value="Discard"/>
                    </form>&nbsp;
                </td>

          </tr>
  </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
