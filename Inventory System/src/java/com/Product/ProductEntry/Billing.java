/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.ProductEntry;

/**
 *
 * @author I067515
 */
import java.util.*;
import java.sql.*;
import java.sql.PreparedStatement;

public class Billing {

    String Query, ProductName, Brand;
    Connection con;
    float price;
    int volume, NumberOfBottles;
    databaseConnection dC1;
    ArrayList A1;
    PreparedStatement psmt;
    ResultSet res;

    public ArrayList generateBill(Long Barcode) {
        dC1 = new databaseConnection();
        con = dC1.connectDatabase("jdbc:mysql://localhost:3306/barshop", "root", "root");
        Query = "SELECT * FROM Stock WHERE Barcode = ?";

        try {
            psmt = con.prepareStatement(Query);
            psmt.setLong(1, Barcode);
            res = psmt.executeQuery();
            while (res.next()) {
                price = res.getFloat("Price");
                Brand = res.getString("Brand");
                ProductName = res.getString("ProductName");
                NumberOfBottles = res.getInt("NumberOfBottles");
                volume = res.getInt("Volume");
                A1.add(Barcode);
                A1.add(Brand);
                A1.add(ProductName);
                //A1.add(NumberOfBottles);
                A1.add(volume);
                A1.add(price);

            }
            return A1;
        } catch (SQLException ex) {
            A1.add(ex.getMessage());
            return A1;
        }
    }
}
