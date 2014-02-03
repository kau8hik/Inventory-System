
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "show_permitno_contents_admin1.jsp");
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
                        try
                        {
                            Class.forName("com.mysql.jdbc.Driver");
                        }
                        catch (Exception ex){}

                        try{
                            String perno= request.getParameter("per_no");
                            //out.println(perno);
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                            PreparedStatement psmt,psmt1,psmt3,psmt_ret_temp,psmt_total,psmt12;
                            ResultSet res,res1,res3,res_ret_temp,res_total,res12;
                            String Query="SELECT incoming_stock.barcode, category, brand, productname, no_of_bottles, no_of_bottles*price as cost, date, litres,  price FROM `incoming_stock`, stock WHERE incoming_stock.barcode=stock.barcode and permit_no='"+perno+"'";
                            //out.println(Query);
                            psmt = con.prepareStatement(Query);
                            res = psmt.executeQuery();
                            ArrayList al=new ArrayList();
                            while(res.next()){
                                al.add(res.getString("Barcode"));
                                al.add(res.getString("Category"));
                                al.add(res.getString("Brand"));
                                al.add(res.getString("ProductName"));
                                al.add(res.getString("no_of_bottles"));
                                al.add(res.getString("price"));                                
                                al.add(res.getString("litres"));
                                al.add(res.getString("cost"));
                                
                            }
                            String Query1="SELECT sum(no_of_bottles*price) as totalcost, date FROM `incoming_stock`, stock WHERE incoming_stock.barcode=stock.barcode and permit_no='"+perno+"'";

                            psmt1 = con.prepareStatement(Query1);
                            res1 = psmt1.executeQuery();
                            Float totalcost=0.0f;
                            Date d=new Date();
                            while(res1.next()){
                                totalcost=res1.getFloat("totalcost");
                                d=res1.getDate("date");
                            }
                            %>
                            Permit no : <%=perno%><br></br>
                            Date     : <%=d%><br></br>
                             <table border="1" align="center" width="60%">
                              <tr>
                                    <th>Barcode</th>
                                    <th>Category</th>
                                    <th>Brand</th>
                                    <th>Product</th>
                                    <th>No of bottles</th>
                                    <th>Price</th>
                                    <th>Liters</th>
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
               // response.sendRedirect("Lowonstock_admin.jsp");
                        }
                        else
                        {
                            int i=0;
                            int j=0;
                            for(i=0;i<al.size()/8;i++)
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
                                <td align="center"><% out.println(al.get(j)); j++; %> </td>
                                </tr>

                        <%
                            }
                        %>
                         <tr>
                                    <td colspan="5"></td>
                                    <td align="center" colspan="2">Total Cost</td>
                                    <td align="center" colspan="1"><%=totalcost%></td>
                                </tr>

                   <%
                        }
                   %>
                   </table>



                            <%

                        }catch(Exception e){
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
