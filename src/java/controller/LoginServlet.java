/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author fgmrr
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login_servlet"})
public class LoginServlet extends HttpServlet {

     private static final long serialVersionUID = 1L;

    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        response.sendRedirect("/http_session/jsp/login.jsp");
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        
        try{
            ConnectionBD conexion = new ConnectionBD();
            conn = conexion.getConnectionBD();
            
            String sql = "SELECT password FROM autenticacion WHERE matricula = ?  " ;
            ps = conn.prepareStatement(sql);
            ps.setString(1, matricula);
            rs = ps.executeQuery();
            
            if(rs.next()){
                String hashPassword = rs.getString("password");
                if(BCrypt.checkpw(password, hashPassword)){
                    HttpSession session = request.getSession();
                    session.setAttribute("matricula",matricula);
                    response.sendRedirect("/http_session/jsp/usuario.jsp");
                }else{
                    request.setAttribute("error", "Credenciales incorrectas");
                    request.getRequestDispatcher("/http_session/jsp/login.jsp").forward(request, response);
                }
            }else{
                request.setAttribute("error", "Usuario no encontrado");
                request.getRequestDispatcher("/http_session/jsp/login.jsp").forward(request, response);
            }
            rs.close();
            ps.close();
            conn.close();
                   
        }catch(Exception e){
            System.out.println("Error "+e);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
