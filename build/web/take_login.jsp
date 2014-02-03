<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta itemprop="image" content="dot.jpg"/>
        <title>	CANASPERA </title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta name="keywords"  />
        <link href="style1.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" language="javascript">

        </script>
        <link rel="shortcut icon" href="favicon.ico" />
        <link rel="icon" type="image/gif" href="animated_favicon1.gif" ></link>
    </head>

    <body onload="if(typeof(initPage)=='function')initPage();">

        <div id="divpass" class="passbg"></div>

	<div id="topNav" class="list">

             
        </div>
        <div align="center" >
         <%
            
                //String page_name="index.jsp";
                String from_page =  (String)session.getAttribute("from_page");
                String uname =  (String)session.getAttribute("uname");
                //out.println(uname);

                //session.setAttribute("from_page", page_name);
                //out.println("from_page"+(String)session.getAttribute("from_page"));
                if(uname!=null){ response.sendRedirect(from_page);}
                else{
            %>
            <br>
            <form   action="check_login_redirect.jsp">
            Username:<input type="text" name="uname" />
            <br><br>
            Password:<input type="text" name="password" />
            <br><br>
            <input type="Submit" value="Submit"/>
        </form>
            <%}%>
        </div>
    </body>
</html>
