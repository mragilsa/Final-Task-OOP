<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String mode = request.getParameter("mode"); // add / edit
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String year = request.getParameter("year");
    String stock = request.getParameter("stock");
%>

<div class="modal">
    <div class="modal-content">

        <a href="books" class="close-button">&times;</a>

        <h3><%= ("edit".equals(mode)) ? "Edit Book" : "Add Book"%></h3>
        <form action="books" method="post" class="form">
            <input type="hidden" name="mode" value="<%= mode%>" />

            <% if ("edit".equals(mode)) {%>
            <input type="hidden" name="oldId" value="<%= id != null ? id : ""%>" />
            <% }%>

            <div class="input-form">
                <input type="text" name="id" placeholder="Book Id" value="<%= id != null ? id : ""%>" required />
                <input type="text" name="title" placeholder="Title" value="<%= title != null ? title : ""%>" required />
                <input type="text" name="author" placeholder="Author" value="<%= author != null ? author : ""%>" required />
                <input type="number" name="year" placeholder="Year" value="<%= year != null ? year : ""%>" required />
                <input type="number" name="stock" placeholder="Stock" value="<%= stock != null ? stock : ""%>" required />
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-form-save">Save</button>
            </div>
        </form>


    </div>
</div>
