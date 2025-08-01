<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int a = Integer.parseInt(request.getParameter("a"));
for(int i=1; i<10; i++){
	out.println(a +"*"+i +"="+(a*i));

%>
<%=a*i %>
<br>
<%
}
%>

</body>
</html>