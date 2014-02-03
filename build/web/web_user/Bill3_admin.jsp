<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Product.ProductEntry.billGetData"%>
<%@page import="java.sql.*" %>
<%
session.setMaxInactiveInterval(15*60);
session.setAttribute("bill_id", 3);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "Bill3_admin.jsp");
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
        Logged in as : <%=uname%>                                       Bill3                                              <a href="../logout.jsp">Logout</a></pre>
        <table width="100%"  border=1>
            <tr>
                <td rowspan="1" width="10%" height="222px"><pre><br>
                <form name="input" action="Bill3_admin.jsp" method="post" onsubmit="return validateForm();">
          Add contents to bill    <br>
         Barcode
        <input type="text" autofocus size="10" name ="id"/>

               <input type="submit" value="submit"/>
            </form>
            </pre>

                </td>


                <td rowspan=2 width="90%" valign="top">
                 <%
                try {

                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                        PreparedStatement psmt, psm, psmt1, psmt3, psmt_ret_temp, psmt_total, psmt12;
                        ResultSet res, res1, res3, res_ret_temp, res_total, res12;
                        int total = 0;
                        String a = "null1";
                        a = request.getParameter("id");
                        //out.println(a);

                        if (a == null) {
                            //out.println("entered to wooo");
                        } else {
                            // out.println("entered");
                            String id = request.getParameter("id");
                            int noofbottles = 1;
                            //out.println(id);
                            String Query = "Select * from stock where barcode =" + id;
                            //out.println(Query);
                            //out.println(Query);
                            psmt = con.prepareStatement(Query);
                            res = psmt.executeQuery();

                            String Category = "kau", category_ret_temp = null;
                            String litres = new String();
                            String Brand = null, Product = null;
                            int Volume = 0, noofbottles1 = 0;
                            float Price = 0;float ind_price=0f;
                            int ind_volume=0;

                            while (res.next()) {
                                Category = res.getString("Category");
                                Brand = res.getString("Brand");
                                Product = res.getString("ProductName");
                                Volume = res.getInt("Litres");
                                ind_volume=Volume;
                                //out.println(Volume);
                                Volume = Volume * noofbottles;
                                //out.println("no of bottles"+noofbottles);
                                //.println(Volume);
                                noofbottles1 = res.getInt("NumberOfBottles");
                                Price = res.getFloat("Price");
                                if(Category.equals("soft drinks")) Price*=1.14;
                                ind_price=Price;
                                Price *= noofbottles;
                            }

                            String query12 = "SELECT SUM( Litres ) AS t FROM temp_bill3";
                            psmt12 = con.prepareStatement(query12);
                            res12 = psmt12.executeQuery();
                            int vol = 0;
                            while (res12.next()) {
                                vol = res12.getInt("t");
                            }
                            //out.println(vol);out.println(Volume);
                            vol = vol + Volume;

                            if (Category.equals("kau")) {
                    %>
                    <script type="text/javascript">
                        alert("Barcode Doesnot Exists");
                    </script>
                    <%
                        } else if (noofbottles > noofbottles1) {
                    %>
                    <script type="text/javascript">
                        alert("We have only "+<%=noofbottles1%>+" bottles" );
                    </script>
                    <%
                        }  else {

                            String Query_ret_temp = "Select * from temp_bill3 where barcode =" + id;
                            psmt_ret_temp = con.prepareStatement(Query_ret_temp);
                            res_ret_temp = psmt_ret_temp.executeQuery();
                            while (res_ret_temp.next()) {
                                litres = res_ret_temp.getString("litres");
                                category_ret_temp = res_ret_temp.getString("Category");
                            }

                            //out.println("category_ret_temp="+category_ret_temp);
                            if (Category.equals("soft drinks")) {
                                //out.println(Category);
                                //Price *= 1.145;
                                //out.println(Price);
                            }//out.println(Category);

                            if (category_ret_temp == null) {
                                String Query1 = "insert into temp_bill3 values(" + id + ",'" + Category + "','" + Brand + "','" + Product + "'," + Volume + "," + noofbottles + "," + Price + ","+ind_volume+","+ind_price+")";
                                psmt = con.prepareStatement(Query1);
                                psmt.execute();
                            }
                            else {
                                String Query1_update_tmp = "update temp_bill3 set price=price+" + ind_price + ",litres=litres+" + ind_volume + ",noofbottles=noofbottles+" + noofbottles + " where barcode=" + id;
                                //out.println(Query1_update_tmp);
                                psmt = con.prepareStatement(Query1_update_tmp);
                                psmt.execute();
                            }
                        }
                    }
                //out.println(Query1);
                //out.println(res1);
                String Query2 = "Select * from temp_bill3 ";
                //out.println(Query);
                //out.println(Query2);
                psmt3 = con.prepareStatement(Query2);
                res3 = psmt3.executeQuery();

                String Query_total = "SELECT sum( Price ) as t FROM temp_bill3";
                psmt_total = con.prepareStatement(Query_total);
                res_total = psmt_total.executeQuery();
                while (res_total.next()) {
                    total = res_total.getInt("t");
                }
                //out.println(total);


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
                            <td align="center" width="40"><input size="4" name="noofbottles_update" value="<%= res3.getString(6)%>"/> </td>

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
                        <td align="center"> Discount </td>
                        <td align="center"> <form action="final_bill_admin.jsp">
                                <select name="discount">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            

                                </select>
                                <input type="Submit" value="Submit"></input>

                            </form>
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
                
            </tr>

            <tr align="center">

                <td><br>
                    <a href="Bill_admin.jsp">Bill1 </a><br><br>
                    <a href="Bill2_admin.jsp">Bill2 </a><br><br>
                    <a href="Bill3_admin.jsp">Bill3 </a><br><br>
                    <a href="Bill4_admin.jsp">Bill4 </a><br><br>
                    <a href="Bill5_admin.jsp">Bill5 </a><br><br>
                </td>

                

          </tr>
  </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
