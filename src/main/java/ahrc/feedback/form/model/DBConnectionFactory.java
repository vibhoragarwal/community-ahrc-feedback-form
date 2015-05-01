package ahrc.feedback.form.model;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;




public class DBConnectionFactory {

	private static String jdbcDriverClassName;
	private static String jdbcUrl;
	private static String username;
	private static String password;

	private static Properties prop = null;

	public static Connection getConnection() {
		Connection c = null;
		if (prop == null) {
			//loadJDBCProperties();

			try {
				Class.forName("com.mysql.jdbc.Driver", true, Thread.currentThread()
						.getContextClassLoader());
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}

		try {
			c = DriverManager.getConnection("jdbc:mysql://localhost:2306/nimbus_dev", "nimbus", "password");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}

	private static void loadJDBCProperties() {

		prop = new Properties();
		InputStream input = null;

		try {

			input = Thread.currentThread().getContextClassLoader()
					.getResourceAsStream("jdbc.properties");
			// load a properties file
			prop.load(input);

			jdbcDriverClassName = prop.getProperty("jdbc.driverClassName");
			jdbcUrl = prop.getProperty("jdbc.url");
			username = prop.getProperty("jdbc.username");
			password = prop.getProperty("jdbc.password");

		} catch (IOException ex) {
			ex.printStackTrace();
		}

	}
  
  
  /**
	 * DB insert logic for account details
	 * 
	 * @param con
	 * @param details
	 * @return
	 * @throws SQLException
	 */
	public static int createFeedback(
			Feedback feedback) throws SQLException {
		int insertID = 0;
		String insertDML = "INSERT INTO AHRC_FEEDBACK ( QUESTION_1, QUESTION_2, QUESTION_3, QUESTION_4, QUESTION_5, QUESTION_6, OTHER_1) "
				+ "	VALUES (?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement accountDetailsStatement = null;
		ResultSet accountDetailsResultSet = null;
		try {
			Connection con = DBConnectionFactory.getConnection();
			accountDetailsStatement = con.prepareStatement(insertDML,
					Statement.RETURN_GENERATED_KEYS);

			accountDetailsStatement.setString(1, feedback.getQuestion1());
			accountDetailsStatement.setString(2, feedback.getQuestion2());
			accountDetailsStatement.setString(3, feedback.getQuestion3());
			accountDetailsStatement.setString(4, feedback.getQuestion4());
			accountDetailsStatement.setString(5, feedback.getQuestion5());
			accountDetailsStatement.setString(6, feedback.getQuestion6());
			accountDetailsStatement.setString(7, feedback.getOther1());

			accountDetailsStatement.executeUpdate();

			accountDetailsResultSet = accountDetailsStatement
					.getGeneratedKeys();
			accountDetailsResultSet.next();
			insertID = accountDetailsResultSet.getInt(1);
		} finally {
			releaseResources(null, accountDetailsStatement,
					accountDetailsResultSet);
		}

		return insertID;
	}

  
  /**
	 * Release DB Resources
	 * 
	 * @param dbConnection
	 * @param stmnt
	 * @param rs
	 */
	private static void releaseResources(Connection dbConnection,
			Statement stmnt, ResultSet rs) {

		try {
			if (stmnt != null) {
				stmnt.close();
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		try {

			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		try {
			if (dbConnection != null) {
				dbConnection.close();
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}
  

}
