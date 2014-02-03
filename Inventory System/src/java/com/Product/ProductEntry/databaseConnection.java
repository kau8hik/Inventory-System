/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Product.ProductEntry;

/**
 *
 * @author I067515
 */
import java.sql.*;

public class databaseConnection {
    
    Connection con;
    
    public Connection connectDatabase(String databaseUrl, String userName, String password)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception ex)
                {
                    
                }
        try
        {
            Connection con = DriverManager.getConnection(databaseUrl, userName, password);
            return con;
        }
        catch(Exception ex)
        {
            return con;
        }
    }
    
}
