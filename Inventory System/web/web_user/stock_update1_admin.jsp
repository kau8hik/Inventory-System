<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "stock_update1_admin.jsp");
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
                                <form action="stockupdate_admin.jsp" method="post">
                                    <table width="250" border="1">
                                        <tr>
                                            <td>Permit no: </td>
                                            <td align="center"><input name="per_no" type="text" /></td>
                                        </tr>
                                    </table>

                                    <table width="200" border="1">
                                        <tr>
                                            <th> Barcode</th>
                                            <th> No of bottles</th>
                                        </tr>
                                        <tr>
                                            <td><input name="bar1" type="text" /></td>
                                            <td><input name="noofbot1" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar2" type="text" /></td>
                                            <td><input name="noofbot2" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td align="center" ><input name="bar3" type="text" /></td>
                                            <td><input name="noofbot3" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar4" type="text" /></td>
                                            <td><input name="noofbot4" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar5" type="text" /></td>
                                            <td><input name="noofbot5" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar6" type="text" /></td>
                                            <td><input name="noofbot6" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar7" type="text" /></td>
                                            <td><input name="noofbot7" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar8" type="text" /></td>
                                            <td><input name="noofbot8" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar9" type="text" /></td>
                                            <td><input name="noofbot9" type="text" /></td>
                                        </tr>
                                        <tr>
                                            <td><input name="bar10" type="text" /></td>
                                            <td><input name="noofbot10" type="text" /></td>
                                        </tr>

                                    </table>

                                    <input name="submit" type="submit" value="submit" />
                                </form>
                     </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
