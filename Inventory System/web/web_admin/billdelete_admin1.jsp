<%-- 
    Document   : billdelete
    Created on : 16 Feb, 2013, 6:00:08 PM
    Author     : Kaushikn
	Edited 	   : Chethan :P
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<%
session.setMaxInactiveInterval(15*60);
  String uname= (String) session.getAttribute("uname");
  if(uname==null){
    session.setAttribute("from_page", "billdelete_admin1.jsp");
    response.sendRedirect("../take_login.jsp");
  }
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception ex) {}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>
	CANASPERA
</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="keywords"  />

 <link href="style1.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript">
                    function validateForm()
        {
            var x=document.input.billno.value;
            var digits = /^[0-9]*$/;
            if(!x.match(digits)){
              alert("Enter digits for billno");return false;
              }

        }
		</script>
</head>
    <body onload="if(typeof(initPage)=='function')initPage();">
        <div id="frame" class="backframe">
            <div id="MainHeader">
			<div id="divpass" class="passbg">
				 
				   
					</div>
                  
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
                   <li><a href="Report.jsp"  >Reports</a>
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
                
    <div align="center" style="width:100%; height:500px">
    
      <%
		 try
{
Class.forName("com.mysql.jdbc.Driver");
}
catch (Exception ex)
{

}
        try{
            String billid=request.getParameter("billno");
            //String billid="201302163";
            String str=new String();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            PreparedStatement psmt,psmt1,psmt3,psmt_ret_temp,psmt_total,psmt12;
            ResultSet res,res1,res3,res_ret_temp,res_total,res12;
            String Query1="Select * from billingtable where billid ="+billid;
             psmt1 = con.prepareStatement(Query1);
            res1 = psmt1.executeQuery();
            if(!res1.next())
            {
                %>
                <script type="text/javascript">
                    alert("bill no doesnot exists");
                </script>
          <%
                
            }
            else{

            String Query="Select contents from billingtable, is_parallel where billid ="+billid;
            psmt = con.prepareStatement(Query);
            res = psmt.executeQuery();
            int is_parallel=0;
            while(res.next()) {
                str=res.getString("contents");
                is_parallel=res.getInt("is_parallel");
            }
            String[] s=new String[100];int start=1;int end;int s_len=0;
            for(int i=1;i<str.length();i++){
                if(str.charAt(i)=='|'){
                    end=i;
                    s[s_len]=str.substring(start, end);s_len++;
                    start=i+1;
                 }
            }
            String barcode=new String();int noofbottles;
            int bar=0;int noofbot=1;
            for(int i=0;i<s_len/2;i++){
                barcode=s[bar];bar+=2;
                noofbottles=Integer.parseInt(s[noofbot]);noofbot+=2;
                String quer = new String();
                if(is_parallel==1) quer="update p_stock set numberofbottles=numberofbottles+"+noofbottles+" where barcode="+barcode;
                else quer="update stock set numberofbottles=numberofbottles+"+noofbottles+" where barcode="+barcode;
                //out.println(quer);
                psmt = con.prepareStatement(quer);
                psmt.executeUpdate();

            }
            String Query12="delete from billingtable where billid ="+billid;
            psmt = con.prepareStatement(Query12);
            psmt.executeUpdate();
            //response.sendRedirect("billdelete_admin.jsp");
        }
            

    }catch(Exception e){out.println(e.getMessage());}
        %>
    <form name="input" action="billdelete_admin1.jsp" method="post" onsubmit="return validateForm();">
    Bill Number:<input name="billno" type="text" size="12" />
    <input name="submit" type="submit" value="submit" />
    </form>
    </div>

<div id="footer" align="center">
  <p>Copyright (c) 2013 canaspera.com All rights reserved</p>
    </div>
   
    </body>
</html>
