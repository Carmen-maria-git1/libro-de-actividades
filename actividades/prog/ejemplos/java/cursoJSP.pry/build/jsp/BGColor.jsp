<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Curso JSP (Java Server Pages)</title>
</head>


<%
String bgColor = request.getParameter("bgColor");
boolean hasExplicitColor;
if (bgColor != null) {
  hasExplicitColor = true;
} else {
  hasExplicitColor = false;
  bgColor = "WHITE";
}
%>

<BODY BGCOLOR="<%= bgColor %>">
<table border="0">
<tr>
<td align=center>
<img src="../images/java_logo.gif">
</td>
<td>
<h1>JSP: Pruebas de color</h1>
</td>
</tr>
</table>



<%
if (hasExplicitColor) 
{ out.println("Se ha pasado el valor <b>" + bgColor + "</b> para el color del fondo.");} 
else 
{
  out.println("Se usar� el color de fondo por defecto (WHITE).<br>");
  out.println("Se puede indicar otro color pasando el par�metro <b>bgColor</b><br>");
  out.println("Indicar el color en el formato RRGGBB");
}
%>

</BODY>
</HTML>