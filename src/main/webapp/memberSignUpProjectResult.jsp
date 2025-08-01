<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 완료</title>
<style type="text/css">
	table, th, td {
		border: 1px solid #ccc;
		border-collapse: collapse;
	}
	th, td {padding: 10px 20px;}
</style>
</head>
<body>

<%
//form 태그와 get방식 사용 , 회원 양식 만들기
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

String kname="";
int age=0;
int memberId=0;
String phoneNum="";
String email="";

Date now = new Date();
try{
	kname = request.getParameter("kname");
	age= Integer.parseInt(request.getParameter("age"));
	phoneNum= request.getParameter("phone_num");
	email= request.getParameter("email");
}catch(Exception e){
	out.println("값을 입력해주세요");
}


/* memberId= Integer.parseInt(request.getParameter("member_id"));  */

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/membersignup", "root", "1234");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM member");
    String sql = "select count(*) from member";
    rs = stmt.executeQuery(sql);
    
    while (rs.next()) {
    	memberId=rs.getInt("count(*)")+1;
    }
    try{

    	String insert = String.format("insert into member(member_id,name,age,phone_num,email) values (%d,'%s',%d,'%s','%s')",memberId,kname,age,phoneNum,email);
        stmt.execute(insert);	
        
    }catch(Exception e1){
    	out.println("insert 오류");
    }
    
} catch (SQLException e) {
    out.println("데이터베이스 오류: " + e.getMessage());
} catch (ClassNotFoundException e) {
    out.println("드라이버를 찾을 수 없습니다: " + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("리소스를 닫는 도중 오류 발생: " + e.getMessage());
    }
}
%>
<h1>등록이 완료되었습니다.</h1>
</body>
</html>