
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "../for_parallel/product_update_admin.jsp");
    response.sendRedirect("../take_login.jsp");
  }%>

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

            var digits = /^[0-9]{10}$/;
	    var digit=/^[0-9]{1,3}$/;
            if(!x.match(digits)){
                alert("Enter 10 digit no for barcode");return false;
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
            <table width="100%" style="height:500px"   border="1">
                <tr>
                    <td width="70%" align="center" valign="top" >
                        <br>
                        <form name="input" action="productupdate_admin.jsp" method="post" onsubmit="return validateForm();" />
                            <pre></br></br>
    Barcode : <input name="Barcode" type="text" size="10" maxlength="10" />

    <input name="Submit" type="submit" value="submit" />
                            </pre>
                        </form>


                     </td>
                </tr>
            </table>

    <div id="footer" align="center">
      <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>

    </body>
</html>
