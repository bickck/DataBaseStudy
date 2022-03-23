package ch01_driver;

import java.sql.Connection;
import java.sql.DriverManager;

/*
 * JDBC ( Java DataBase Connectivity )
 * - Java 와 database 연동을 위한 프로그래밍 API
 * 
 * JDBC 드라이버
 * - DBMS 마다 별도의 드라이버가 필요합니다
 *   > .jar 파일 형태로 DBMS 마다 기본적으로 제공합니다
 * - 드라이버 위치  
 *   > C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib\ojdbc6.jar
 * - 프로젝트의 build path 를 사용해서 추가합니다
 *   > 프로젝트명 마우스 우측 클릭
 *     build path -> configure build path -> libraries 탭 -> Add External jars
 * 
 * JDBC 드라이버 클래스
 * - oracle.jdbc.OracleDriver
 * 
 * Oracle database URL
 * - jdbc:oracle:driver_type:@host_name:port:service_name
 *   jdbc:oracle:thin:@localhost:1521:xe
 * 
 * Connection : java.sql.Connection
 * - 연결 정보 가지는 객체를 생성
 *   java.sql.DriverManager 클래스의 getConnection() 메서드를 사용해서 생성
 */

public class DriverConnect {

	public static void main(String[] args) {

		// jdbc 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			System.out.println("로딩 성공");
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
			System.out.println("로딩 실패");
			System.out.println(e.getMessage());
		}

		// 연결 정보
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "dbtest";
		String password = "1234";
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
	}
}
