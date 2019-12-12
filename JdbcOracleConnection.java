package net.codejava.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * This program demonstrates how to make database connection with Oracle
 * database server.
 * @author www.codejava.net
 *
 */
public class JdbcOracleConnection {

    public static void main(String[] args) {

        Connection conn1 = null;
        Connection conn2 = null;
        Connection conn3 = null;

        try {
            // registers Oracle JDBC driver - though this is no longer required
            // since JDBC 4.0, but added here for backward compatibility
            Class.forName("oracle.jdbc.OracleDriver");

            // METHOD #1
            String dbURL1 = "jdbc:oracle:thin:SYSTEM/oracle@localhost:1521:productDB";
            conn1 = DriverManager.getConnection(dbURL1);
            if (conn1 != null) {
                System.out.println("Connected with connection #1");
            }

            // METHOD #2
            String dbURL2 = "jdbc:oracle:thin:@localhost:1521:productDB";
            String username = "SYSTEM";
            String password = "oracle";
            conn2 = DriverManager.getConnection(dbURL2, username, password);
            if (conn2 != null) {
                System.out.println("Connected with connection #2");
            }

            // METHOD #3
            String dbURL3 = "jdbc:oracle:oci:@ProductDB";
            Properties properties = new Properties();
            properties.put("user", "SYSTEM");
            properties.put("password", "oracle");
            properties.put("defaultRowPrefetch", "20");
            conn3 = DriverManager.getConnection(dbURL3, properties);

            if (conn3 != null) {
                System.out.println("Connected with connection #3");
            }
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn1 != null && !conn1.isClosed()) {
                    conn1.close();
                }
                if (conn2 != null && !conn2.isClosed()) {
                    conn2.close();
                }
                if (conn3 != null && !conn3.isClosed()) {
                    conn3.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}