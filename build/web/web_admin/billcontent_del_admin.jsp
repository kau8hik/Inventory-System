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
    session.setAttribute("from_page", "billcontent_del_admin.jsp");
    response.sendRedirect("../take_login.jsp");
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

                <li><a href="Bill_admin.jsp">Billing </a>
                    <ul>
                        <li><a href="billdelete_admin.jsp"  class="headerLinks">Delete Bill</a></li>
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
        <table width="100%"  border=1>
            <tr>
                <td width="30%" height="222px"><pre><br>
                <form name="input" action="Bill_admin.jsp" method="post" onsubmit="return validateForm();">
          Add contents to bill    <br>
         Barcode      Quantity
        <input type="text" autofocus size="10" name ="id"/>  <input type="text" size="10" name="noofbottles"/>
                
               <input type="submit" value="submit"/>
            </form>
            </pre>

                </td>


                <td rowspan=2 width="56%" valign="top">
                <%
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
                    PreparedStatement psmt, psm,psmt1, psmt3, psmt_total, psmt_check, psmt_del;
                    ResultSet res, res1, res3, res_total, res_check, res_del;
                    int total = 0, no_in_bill = 0;
                    String id1 = request.getParameter("id1");

                    if (id1 == null) {
                        //out.println("entered to wooo");
                    }
                    else {
                        int noofbottles = Integer.parseInt(request.getParameter("noofbottles1"));
                        //out.println(id1);
                        String Query_check = "Select Noofbottles from temp where barcode=" + id1;
                        //out.println(Query);
                        //out.println(Query2);
                        psmt_check = con.prepareStatement(Query_check);
                        res_check = psmt_check.executeQuery();
                        while (res_check.next()) {
                            no_in_bill = res_check.getInt("Noofbottles");
                        }

                        //out.println(no_in_bill);
                        //out.println(noofbottles);
                        if (no_in_bill < noofbottles) {
                %>
                <script type="text/javascript">
                    alert("enter appropriate no for barcode or quantity");
                </script>
                <%
                        }
                        else{

                            if(no_in_bill==noofbottles){
                                String Query_del="delete from temp where barcode="+id1;
                                //out.println(Query);
                                //out.println(Query);
                                psmt_del = con.prepareStatement(Query_del);
                                psmt_del.executeUpdate();
                            }

                            else{
                                String Query_get="Select * from stock where barcode ="+id1;
                                psmt = con.prepareStatement(Query_get);
                                res = psmt.executeQuery();
                                String volume=new String();int p=0;
                                while(res.next()){volume=res.getString("litres");p=res.getInt("price");}

                                String Query="update temp set price=price-"+ p +"*"+noofbottles+" ,litres=litres-"+ volume +"*"+noofbottles+",Noofbottles=Noofbottles-"+noofbottles+" where barcode="+id1;
                                //out.println(Query);
                                //out.println(Query);
                                psmt = con.prepareStatement(Query);
                                psmt.executeUpdate();
                            }

                            String Category=null;
                            String Brand=null,Product=null;
                            int Volume=0;
                            float Price=0;
                        }
                    }

                    String Query_total="SELECT sum( Price ) as t FROM temp";
                    psmt_total= con.prepareStatement(Query_total);
                    res_total = psmt_total.executeQuery();
                    while(res_total.next())total = res_total.getInt("t");
                    //out.println("total"+total);
                    String Query2="Select * from temp ";
                    //out.println(Query);
                    //out.println(Query2);
                    psmt3 = con.prepareStatement(Query2);

                    res3 = psmt3.executeQuery();
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
                    billno=Long.parseLong(d);
                %>


                <table id="mytable" border="1" width=95% align="center"  >

                    <tr style=" height: 40px"  >
                        <th colspan="7" align="center">Billno : <%=billno%></th>
                    </tr>

                    <tr>
                        <th>barcode</th>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Product</th>
                        <th>Liters</th>
                        <th width="40">No Of Bottles</th>
                        <th>Price</th>
                    </tr>

                    <%
                          while (res3.next()) {
                    %>

                    <tr>
                        <td align="center"> <%= res3.getString(1)%> </td>
                        <td align="center"> <%= res3.getString(2)%> </td>
                        <td align="center"> <%= res3.getString(3)%> </td>
                        <td align="center"> <%= res3.getString(4)%> </td>
                        <td align="center"> <%= res3.getString(5)%> </td>
                        <td align="center"> <%= res3.getString(6)%> </td>
                        <td align="center"> <%= res3.getString(7)%> </td>
                    </tr>

                    <%
                           }
                    %>
                    <tr>
                        <td colspan="5"></td>
                        <td align="center"> Total </td>
                        <td align="center"> <%=total%> </td>
                    </tr>

                </table>

            <%
                }
                catch(Exception ex){}
            %>

                </td>
                <td width="14%" height="222px">
                    <div align="center">Credit  :
                        <select onchange="javascript:credit(this)">
                            <option value="1" selected>No</option>
                            <option value="credit_add">Yes</option>
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

            <tr>

                <td width="30%" height="222px">
                    <pre><br>
<form name="del" action="billcontent_del_admin.jsp" onsubmit="return validateForm1();" method="post">
       Delete contents from bill   <br>
         Barcode      Quantity
        <input type="text" size="10" name ="id1"/>  <input type="text" size="10" name="noofbottles1"/><br>
                <input type="submit" value="delete"/>
                        </form>
                    </pre>
                </td>

                <td height="222px">
                    <form action="billingSave_admin.jsp" method="POST">
                        <input style="width:165px" type="submit" value="Save" />
                    </form>
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
