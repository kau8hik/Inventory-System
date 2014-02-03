<%--
    Document   : reportDaily
    Created on : Sep 16, 2012, 3:52:58 PM
    Author     : I067515
--%>

<%@page import="com.Product.Reports.reportMonthly"%>
<%@page import="com.Product.ProductEntry.reportDaily"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "reportMonthly_admin1.jsp");
    response.sendRedirect("../take_login.jsp");
  }
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>
<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>
	CANASPERA
</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="keywords"  />

 <link href="style1.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript">
		</script>
</head>
    <body onload="if(typeof(initPage)=='function')initPage();">
        <div id="frame" class="backframe">
            <div id="MainHeader">
			<div id="divpass" class="passbg">


					</div>

		<div id="topNav" class="list">
                <ul>
                    <li><a href="billing1_admin.jsp">Billing </a>
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
                         <li><a href="stockadd.jsp"  class="headerLinks"> Add New Product</a></li>
                         <li><a href="product_update.jsp"  class="headerLinks"> Product Update</a></li>
                        </ul>

                    </li>

                        </ul>
        </div>

            </div>
			<pre>
        Logged in as : <%=uname%>                                                                                          <a href="../logout.jsp">Logout</a></pre>

    <div id="divBanner" style="padding: 0 15px 0 30px;">
        <div style=" background-repeat: no-repeat; height: 230px; width: 997px;">

        <%
            reportMonthly rD1 = new reportMonthly();
            String result = rD1.getData();
            //out.println(result);
            String filepath = "C:\\Reports_Monthly\\";
            if(result.equals("Success"))
            {
                out.println("Report generated for today under path "+ filepath);
            }
            else
            {
                out.println(result);
            }
        %>
      </div>
    </div>
    <br />
    <div style="height: 20px">&nbsp;
    </div>
    <table id="divTestis" style=" center top; background-repeat: no-repeat; height: 206px; overflow: hidden; width: 100%;"
           cellspacing="5">
        <tr>

        </tr>
    </table>
    <div style="height: 10px">
    </div>
            <div style="height: 10px">
            </div>
            <div id="divMainFooter" class="divFooter">
                <div style="height: 60px">
                </div>

            </div>
        </div>


    </body>
</html>


