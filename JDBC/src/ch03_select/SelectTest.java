package ch03_select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

class Select {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "dbtest";
	private String password = "1234";

	public Select() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			System.out.println("로딩 성공");
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
			System.out.println("로딩 실패");
			System.out.println(e.getMessage());
		}
	}

	public Connection getConnection() {
		Connection connection = null;
		try {
			// Driver 로 부터 DB 연결 객체 생성
			connection = DriverManager.getConnection(url, user, password);

			System.out.println("연결 성공");

		} catch (Exception e) {
			// TODO: handle exception';
			System.out.println("연결 실패");
			System.out.println(e.getMessage());
		}
		return connection;
	}

	public void selectArticle() {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {

			String sql = "select * from member";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);

			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				String name = resultSet.getString("name");
				int age = resultSet.getInt("age");
				double height = resultSet.getDouble("height");
				String logTime = resultSet.getString("logtime");
				
				System.out.println("name : " + name + ", age : " + age + ", height : " + height + ", logTime :" + logTime);
			}

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("DB 조회 실패");
			System.out.println(e);
		} finally {
			try {

				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}

	}
}

public class SelectTest {

	public static void main(String[] args) {
		Select select = new Select();
		
		select.selectArticle();
	}
}
