<%-- 
    Document   : bookForm-popup
    Created on : May 12, 2025, 9:12:22 AM
    Author     : Farriz
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String mode = request.getParameter("mode"); // add / edit / delete
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String year = request.getParameter("year");
    String stock = request.getParameter("stock");
%>


<div class="modal">
  <div class="modal-content">

    <a href="admin-page.jsp" class="close-button">&times;</a>

    <% if ("delete".equals(mode)) { %>
      <h3>Konfirmasi Hapus</h3>
      <p>Apakah Anda yakin ingin menghapus data ini?</p>
      <form action="deleteBook" method="post" class="form-del">
        <input type="hidden" name="id" value="<%= id %>"/>
        <div class="form-actions">
          <button type="submit" class="btn-delete">Ya, Hapus</button>
        </div>
      </form>

    <% } else { %>
      <h3><%= ("edit".equals(mode)) ? "Edit Book" : "Add Book" %></h3>
      <form action="<%= ("edit".equals(mode)) ? "updateBook" : "addBook" %>" method="post" class="form">
          <div class="input-form">
            <input type="number" name="id" placeholder="Book Id" value="<%= id != null ? id : "" %>" required />
            <input type="text" name="title" placeholder="Title" value="<%= title != null ? title : "" %>" required />
            <input type="text" name="author" placeholder="Author" value="<%= author != null ? author : "" %>" required />
            <input type="number" name="year" placeholder="Year" value="<%= year != null ? year : "" %>" required />
            <input type="number" name="stock" placeholder="Stock" value="<%= stock != null ? stock : "" %>" required />
          </div>
        <div class="form-actions">
          <button type="submit" class="btn-form-save">Save</button>
        </div>
      </form>
    <% } %>

  </div>
</div>