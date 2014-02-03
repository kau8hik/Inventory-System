<%@page import="java.util.ArrayList"%>
<%@page import="com.Product.ProductEntry.credit_info_ret"%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "credit_show_admin.jsp");
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
                var x=document.input.billid.value;
                var digits = /^[0-9]{9,12}$/;
                var digit=/^[0-9]{1,3}$/;
                if(!x.match(digits)){
                    alert("Enter 9 to 12 digits");return false;
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
        
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <%
                            credit_info_ret cir=new credit_info_ret();
                            ArrayList al=cir.Credit_ret();
                            //out.println(al);
                        %>
                        <br>
                        <table id="mytable" border="1" width=80% align="center" >

                            <tr>
                                <th>billno</th>
                                <th>amount</th>
                                <th>cleared</th>
                                <th>cleared_date</th>
                                <th>email_id</th>
                                <th>ph_no</th>
                            </tr>

                            <%
                                for(int i=0;i<al.size();i++) {
                            %>
                            <tr>
                                <td align="center" > <%=al.get(i++)%> </td>
                                <td align="center" > <%=al.get(i++)%> </td>
                                <td align="center" > <%=al.get(i++)%> </td>
                                <td align="center" > <%=al.get(i++)%> </td>
                                <td align="center" > <%=al.get(i++)%> </td>
                                <td align="center" > <%=al.get(i)%>   </td>
                            </tr>
                            <%
                                }
                            %>

                        </table>
                    </td>
                    <td valign="top" align="center">
                        <br> <br>
                        <form name="input" action="credit_del_admin.jsp" method="post" onsubmit="return validateForm();">
                            Bill_id:<input name="billid" type="text"/><br><br>
                            <input name="submit" type="submit" value="Clear Credit" />
                        </form>
                    </td>
                </tr>
            </table>


        <div id="footer" align="center">
          <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
        </div>

    </body>
</html>
