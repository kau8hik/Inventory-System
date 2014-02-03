
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "stockadd_user.jsp");
    response.sendRedirect("../take_login.jsp");
  }
  %>
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
                var x=document.input.Barcode.value;
                var y=document.input.Category.value;
                var a=document.input.Brand.value;
                var b=document.input.ProductName.value;
                var c=document.input.Volume.value;
                var d=document.input.Price.value;
                var e=document.input.NumberOfBottles.value;

                var digits = /^[0-9]{10}$/;
                var alpha=/^[A-Z a-z \s]*$/
                var digit=/^[0-9]*$/;
                if(!x.match(digits)){
                    alert("Enter 10 digit no for barcode");return false;
                }
                if(!y.match(alpha)){
                    alert("Enter alphabets for category");return false;
                }
                if(!a.match(alpha)){
                    alert("Enter alphabets for brand");return false;
                }
                if(!b.match(alpha)){
                    alert("Enter alphabets for productname");return false;
                }
                if(!c.match(digit)){
                    alert("Enter alphabets for volume");return false;
                }
                if(!d.match(digit)){
                    alert("Enter alphabets for price");return false;
                }
                if(!e.match(digit)){
                    alert("Enter alphabets for numberofbottles");return false;
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

                <li><a href="Report_user.jsp"  >Reports</a>
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
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br><br>
                            <table style="text-align: justify;">
                                <tr>
                                    <td style="width: 90%;">
                                        <form name="input" action="stockadd_user1.jsp" method="post" onsubmit="return validateForm();">

                                            <pre>
            Barcode             : <input  type="text" name="Barcode" placeholder="Enter 10 Digits"/><br/>
            Category            : <input  type="text" name="Category" placeholder="Enter only alphabets"/><br/>
            Brand               : <input  type="text" name="Brand" placeholder="Enter only alphabets"/><br/>
            ProductName         : <input  type="text" name="ProductName" placeholder="Enter only alphabets"/><br/>
            Volume              : <input  type="text" name="Volume" placeholder="Enter Digits"/><br/>
            Price               : <input  type="text" name="Price" placeholder="Enter Digits"/><br/>
            Number of Bottles   : <input  type="text" name="NumberOfBottles" placeholder="Enter Digits"/><br/>

            Minimum Stock       : <input  type="text" name="min_stock" placeholder="Enter Digits"/><br/>
            Maximum Stock       : <input  type="text" name="max_stock" placeholder="Enter Digits"/><br/>
                            <input type="submit" value="Add to Stock"/><br/>
                                            </pre>
                                        </form>
                                    </td>
                                </tr>
                            </table>

                     </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
