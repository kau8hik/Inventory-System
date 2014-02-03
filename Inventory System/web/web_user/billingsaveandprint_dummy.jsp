<%--
    Document   : billingSaveAndPrint
    Created on : Oct 13, 2012, 5:27:22 PM
    Author     : I067515
--%>

<%@page import="test.printing"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
        session.setMaxInactiveInterval(15 * 60);
        int bill_id = (Integer) session.getAttribute("bill_id");
        String uname = (String) session.getAttribute("uname");
        String discount=(String) session.getAttribute("discount");
        int dis=Integer.parseInt(discount);
        //out.println(discount);
        if (uname == null) {
            session.setAttribute("from_page", "Bill_admin.jsp");
            response.sendRedirect("../take_login.jsp");
        }
        String table=new String();
        switch(bill_id){
            case 1: table="temp";break;
            case 2: table="temp_bill2";break;
            case 3: table="temp_bill3";break;
            case 4: table="temp_bill4";break;
            case 5: table="temp_bill5";break;
        }

        Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");


        PreparedStatement psmt,psmt2,psmt_n1, psm, psmt1, psmt3,psmt4, psmt_ret_temp, psmt_total, psmt12;
                ResultSet res, res2,res_n1, res1, res3, res4, res_ret_temp, res_total, res12;

        float sum = 0f;

        try
           {
             Long billno=0L;
                Long barcode=0l;
                int liters=0;
                int net_qu=0;float price=0.0f;int noofbottles=0;
                 long[] billid = new long[100];
                 Long billid1=0l;



                DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
                Date date1 = new Date();
                String d1 = dateFormat1.format(date1);
                String qu = "SELECT count( * ) as no FROM `billingtable` WHERE billid LIKE '" + d1 + "%'";
                out.println("qu=" + qu);
                psmt1 = con.prepareStatement(qu);
                res1 = psmt1.executeQuery();
                int n = 0;
                out.println(n);
                while (res1.next()) {
                    n = res1.getInt("no");
                }
                n += 1;
                out.println(n);
                out.println("n=" + n);
                out.println("yyyyMMdd" + n);
                DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd" + n);
                //get current date time with Date()
                Date date = new Date();
                String d = dateFormat.format(date);
                out.println("d=" + d);
                billno = Long.parseLong(d);
                out.println("billno=" + billno);
                billid1=billno;


                 int[] sum_lts=new int[100];
                 String query2="select sum(litres) as st from "+table;
                 psmt2 = con.prepareStatement(query2);
                 res2 = psmt2.executeQuery();
                 int tot_sumofliters=0;
                 while(res2.next())tot_sumofliters=res2.getInt(1);
                 out.println("totsumoflts"+tot_sumofliters+"\n");

                 int flag=tot_sumofliters/4501;flag++;
                 for(int j=0;j<flag;j++) {billid[j]=billid1;billid1++;}

                 String query1="select * from "+table+" order by net_qu desc";
                 psmt1 = con.prepareStatement(query1);
                 res1 = psmt1.executeQuery();
                 int j=0;int forj=0;
                 while(res1.next()){
                    barcode= res1.getLong(1);
                    liters=res1.getInt(5);
                    net_qu=res1.getInt(8);
                    price=res1.getFloat(9);
                    noofbottles=res1.getInt(6);
                    out.println("net_qu"+net_qu);
                    int noofbot=0;
                    for(int i=0;i<noofbottles;i++){
                      if(sum_lts[j]+net_qu<=4500){
                         out.println("sum_lts[j]"+sum_lts[j]+"net_qu"+net_qu);
                         String query3="select * from temp2 where billid='"+billid[j]+"' and barcode='"+barcode+"'";
                         //out.println(query3);
                         psmt3 = con.prepareStatement(query3);
                         res3 = psmt3.executeQuery();
                         String query4=new String();
                         int ins=0;
                         while(res3.next()){
                             ins=1;
                             out.println("this is into while");
                             query4="update temp2 set noofbottles=noofbottles+1,liters=noofbottles*net_qu where barcode='"+barcode+"' and billid='"+billid[j]+"'" ;
                             out.println(query4);
                         }
                         if(ins==0) query4="insert into temp2 values("+billid[j]+","+barcode+","+net_qu+","+net_qu+","+price+",1)" ;
                         out.println("query4-"+query4);
                         psmt4 = con.prepareStatement(query4);
                         psmt4.executeUpdate();
                         out.println("j in if="+j);
                         sum_lts[j]+=net_qu;
                      }
                      else{
                         j++;
                         String query5="insert into temp2 values("+billid[j]+","+barcode+","+net_qu+","+net_qu+","+price+",1)" ;
                         out.println("query5"+query5);
                         psmt4 = con.prepareStatement(query5);
                         psmt4.executeUpdate();
                         out.println("j in else ="+j);
                         sum_lts[j]+=net_qu;
                     }
                      out.println("for loop end");
                }
            }


            ArrayList A1 = new ArrayList();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");
            psmt = con.prepareStatement("SELECT * FROM temp2");
            res = psmt.executeQuery();
            while(res.next())
              {
                A1.add(res.getLong("billid"));
                A1.add(res.getLong("barcode"));

                A1.add(res.getInt("Litres"));
                A1.add(res.getInt("Noofbottles"));
                sum += res.getFloat("Price");
                psmt2 = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
                psmt2.setInt(1, res.getInt("Noofbottles"));
                psmt2.setInt(2, res.getInt("barcode"));
                psmt2.execute();
            }
            for(int i=0;i<flag;i++){
             printing example1 = new printing();
            }

            psmt = con.prepareStatement("DELETE FROM "+table);
            psmt.execute();



            String Query10="select billid from temp2 group by billid";
            PreparedStatement psmt10 = con.prepareStatement(Query10);
            ResultSet res10=psmt10.executeQuery();
            Long bill_id1=0l;
            while(res10.next())
            {
                bill_id1=res10.getLong("billid");

                ArrayList kau=new ArrayList();
            //psmt = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
            psmt = con.prepareStatement("INSERT INTO billingtable(Contents, TotalCost, Date, Billid) VALUES(?,?,now(),?)");
            String content= new String();
            String query11="select * from temp2 where billid='"+bill_id1+"'";
            PreparedStatement psmt11 = con.prepareStatement(query11);
            ResultSet res11=psmt11.executeQuery();
            while(res11.next())
            {
                kau.add(res11.getLong("barcode"));
                kau.add(res11.getLong("noofbottles"));
                kau.add(res11.getLong("price"));
                kau.add(res11.getLong("net_qu"));

            }
            for(int i=0;i<kau.size();i++){
                content += kau.get(i);
                }
            //out.println(content+sum);
            psmt.setString(1, content );
            psmt.setFloat(2, sum);
            psmt.setLong(3, bill_id1);
            psmt.execute();
            }
            response.sendRedirect("Bill_admin.jsp");
        }

        catch(Exception ex)
                       {
            out.println(ex.getMessage());
        }

        %>
    </body>
</html>
