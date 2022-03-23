package ch02_insert;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

class Insert {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "dbtest";
	private String password = "1234";

	public Insert() {
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

	public void insertArticle() {
		Scanner sc = new Scanner(System.in);
		System.out.println("이름 입력 >");
		String name = sc.nextLine();
		System.out.println("나이 입력 >");
		int age = sc.nextInt();
		System.out.println("키 입력 >");
		double height = sc.nextDouble();

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int res = 0;

		try {

			// 질의 문자열
			String sql = "insert into member values(?,?,?,sysdate)";
			connection = getConnection(); // connection 객체 생성
			preparedStatement = connection.prepareStatement(sql); // 쿼리문 실행 객체 생성

			preparedStatement.setString(1, name); // 쿼리문 완성
			preparedStatement.setInt(2, age);
			preparedStatement.setDouble(3, height);

			res = preparedStatement.executeUpdate(); // 쿼리문 실행

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("DB 저장 실패");
			System.out.println(e.getStackTrace());
		} finally {
			try {
				// 사용한 자원 반환
				if (sc != null)
					sc.close();
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		System.out.println(res + "개의 행이 추가 되었습니다...");

	}
}

public class InsertTest {

	public static void main(String[] args) {
		Insert insert = new Insert();
		insert.insertArticle();
	}
}
