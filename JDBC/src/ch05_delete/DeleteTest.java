package ch05_delete;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

class Delete {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "dbtest";
	private String password = "1234";

	public Delete() {
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

	public void deleteArticle() {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int res = 0;

		Scanner sc = new Scanner(System.in);
		System.out.println("삭제 이름 입력 >");
		String name = sc.nextLine();

		try {
			String sql = "delete from member where name=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, name);

			res = preparedStatement.executeUpdate();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("DB 삭제 실패");
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
		System.out.println(res + "개의 행이 삭제 되었습니다...");
	}
}

public class DeleteTest {

	public static void main(String[] args) {
		Delete delete = new Delete();
		delete.deleteArticle();
	}
}
