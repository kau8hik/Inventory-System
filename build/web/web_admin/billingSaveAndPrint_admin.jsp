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
    String redir=new String();String table_in="stock";
    switch(bill_id){
        case 1: table="temp";redir="Bill_admin.jsp";break;
        case 2: table="temp_bill2";redir="Bill2_admin.jsp";break;
        case 3: table="temp_bill3";redir="Bill3_admin.jsp";break;
        case 4: table="temp_bill4";redir="Bill4_admin.jsp";table_in="p_stock";break;
        case 5: table="temp_bill5";redir="Bill5_admin.jsp";table_in="p_stock";break;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/barshop", "root", "root");

    PreparedStatement psmt,psmt2,psmt_n1, psm, psmt1, psmt3,psmt4, psmt_ret_temp, psmt_total, psmt12;
    ResultSet res, res2,res_n1, res1, res3, res4, res_ret_temp, res_total, res12;
    Long billno, billid1;
    long[] billid = new long[100];

    try{

        DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
        Date date1 = new Date();
        String d1 = dateFormat1.format(date1);
        String qu = "SELECT count( * ) as no FROM `billingtable` WHERE billid LIKE '" + d1 + "%'";
        //out.println("qu=" + qu);
        psmt1 = con.prepareStatement(qu);
        res1 = psmt1.executeQuery();
        int n = 0;
        //out.println(n);
        while (res1.next()) {
            n = res1.getInt("no");
        }
        n += 1;
        //out.println(n);
        //out.println("n=" + n);
        //out.println("yyyyMMdd" + n);
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd" + n);
        //get current date time with Date()
        Date date = new Date();
        String d = dateFormat.format(date);
        //out.println("d=" + d);
        billno = Long.parseLong(d);
        out.println("billno=" + billno);
        billid1=billno;

        int[] sum_lts=new int[100];
        String query2="select sum(litres) as st from "+table;
        psmt2 = con.prepareStatement(query2);
        res2 = psmt2.executeQuery();
        int tot_sumofliters=0;
        while(res2.next())
            tot_sumofliters=res2.getInt(1);
        //out.println("totsumoflts"+tot_sumofliters+"\n");
        int flag=tot_sumofliters/4501;flag++;
        out.println("flag="+flag);
        for(int j=0;j<flag+1;j++) {
            billid[j]=billid1;
            billid1++;
            out.println(billid[j]);
        }
        
        String query1="select * from "+table+" order by net_qu desc";
         psmt1 = con.prepareStatement(query1);
         res1 = psmt1.executeQuery();
         int j=0;int forj=0;
         while(res1.next()){
            Long barcode= res1.getLong(1);
            int liters=res1.getInt(5);
            int net_qu=res1.getInt(8);
            Float price=res1.getFloat(9);
            int noofbottles=res1.getInt(6);
            //out.println("net_qu"+net_qu);
            int noofbot=0;
            //out.println("barcode="+barcode+",liters="+liters+", net_qu"+net_qu+",price"+price+", noofbottles"+noofbottles);
            for(int i=0;i<noofbottles;i++){
              if(sum_lts[j]+net_qu<=4500){
                 //out.println("sum_lts[j]"+sum_lts[j]+"net_qu"+net_qu);
                 String query3="select * from temp2 where billid='"+billid[j]+"' and barcode='"+barcode+"'";
                 //out.println(query3);
                 psmt3 = con.prepareStatement(query3);
                 res3 = psmt3.executeQuery();
                 String query4=new String();
                 int ins=0;
                 while(res3.next()){
                     ins=1;
                     //out.println("this is into while");
                     query4="update temp2 set noofbottles=noofbottles+1,liters=noofbottles*net_qu where barcode='"+barcode+"' and billid='"+billid[j]+"'" ;
                     //out.println(query4);
                 }
                 if(ins==0) query4="insert into temp2 values("+billid[j]+","+barcode+","+net_qu+","+net_qu+","+price+",1,"+dis+")" ;
                 //out.println("query4-"+query4);
                 psmt4 = con.prepareStatement(query4);
                 psmt4.executeUpdate();
                 //out.println("j in if="+j);
                 sum_lts[j]+=net_qu;
              }

              else{
                 j++;
                 String query5="insert into temp2 values("+billid[j]+","+barcode+","+net_qu+","+net_qu+","+price+",1,"+dis+")" ;
                 //out.println("query5"+query5);
                 psmt4 = con.prepareStatement(query5);
                 psmt4.executeUpdate();
                 //out.println("j in else ="+j);
                 sum_lts[j]+=net_qu;
             }

            }

         }
         psmt1 = con.prepareStatement("delete from "+table);
         psmt1.execute();


        for(int ab=0;ab<100;ab++){
            if (billid[ab]!=0){
                ArrayList A1 = new ArrayList();
                float sum = 0f;
                psmt = con.prepareStatement("SELECT * FROM temp2 where billid='"+billid[ab]+"'");
                res = psmt.executeQuery();
                int chk=0;
                while(res.next())
                  {
                    chk=1;
                    out.println("into while");
                    A1.add(res.getLong("billid"));
                    A1.add(res.getLong("barcode"));
                    A1.add(res.getInt("liters"));
                    A1.add(res.getInt("Noofbottles"));
                    sum += res.getFloat("Price");
                    //out.println("noofbottles"+res.getInt("Noofbottles"));
                    psmt2 = con.prepareStatement("UPDATE "+table_in+" SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
                    psmt2.setInt(1, res.getInt("Noofbottles"));
                    //out.println("noofbottles"+res.getInt("Noofbottles"));
                    psmt2.setInt(2, res.getInt("barcode"));
                    //out.println("barcode"+res.getInt("barcode"));
                    psmt2.execute();
                }
                if(chk==1){
                    printing example1 = new printing();

                    

                    ArrayList kau=new ArrayList();
                    //psmt = con.prepareStatement("UPDATE Stock SET NumberOfBottles = NumberOfBottles - ? WHERE Barcode = ?");
                    String query_i_b=new String();
                    if(table_in=="p_stock")
                        query_i_b="INSERT INTO billingtable(Contents, TotalCost, Date, Billid, discount, after_discount,is_parallel) VALUES(?,?,now(),?,?,?,1)";
                    else query_i_b="INSERT INTO billingtable(Contents, TotalCost, Date, Billid, discount, after_discount,is_parallel) VALUES(?,?,now(),?,?,?,0)";
                    psmt = con.prepareStatement(query_i_b);
                    String content= new String();

                    String query11="select * from temp2 where billid='"+billid[ab]+"'";
                    out.println(query11);
                    PreparedStatement psmt11 = con.prepareStatement(query11);
                    ResultSet res11=psmt11.executeQuery();
                    float amt=0;
                    float sum1=0;
                    while(res11.next())
                    {
                        kau.add(res11.getLong("barcode"));
                        kau.add(res11.getLong("noofbottles"));
                        out.println(res11.getString("barcode")+res11.getString("noofbottles"));
                        amt=res11.getFloat("price")*res11.getInt("noofbottles");
                        sum1+=amt;
                    }
                    float aft_dis=(100-dis)*sum1/100;
                    float disc=sum1-aft_dis;
                    //kau.add(amt);kau.add(disc);kau.add(aft_dis);
                    for(int i=0;i<kau.size();i++){
                        content = content+"|"+ kau.get(i);
                        }
                    content+="|";
                    //out.println(content+sum);
                    psmt.setString(1, content );
                    psmt.setFloat(2, sum1);
                    psmt.setLong(3, billid[ab]);
                    psmt.setFloat(4, disc);
                    psmt.setFloat(5, aft_dis);
                    psmt.execute();

                    psmt = con.prepareStatement("DELETE FROM temp2 where billid='"+billid[ab]+"'");
                    psmt.execute();
                    response.sendRedirect(redir);

                }
            }
        }

    }
    catch( Exception e){}


%>