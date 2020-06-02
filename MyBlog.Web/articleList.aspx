<%@ Page Language="C#" AutoEventWireup="true" CodeFile="articleList.aspx.cs" Inherits="actileList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/articleList.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Repeater ID="rp" runat="server">
                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>
                <ItemTemplate>
                    <li class="it" onclick="window.location.href='article.aspx?blogId=<%# Eval("blogId") %> '">
                        <div class="tl">
                            <asp:Label ID="lblType" runat="server" CssClass="lblType"><%# Eval("typeName") %></asp:Label>
                            <asp:Label ID="lblTitle" runat="server"><%# Eval("blogTitle") %></asp:Label>
                        </div>
                        <div class="c"><%# Eval("blogContent") %> </div>
                        <div class="tm">
                            <%--点击博主的名字后，跳转到博主的个人主页--%>
                            <a href='homepage.aspx?userId=<%# Eval("userId") %>' class="lblName" target="_parent"><%# Eval("username") %></a>
                            <asp:Label ID="Label2" runat="server" CssClass="lblTime"><%# Eval("blogTime") %></asp:Label>
                            <div>
                                <%--点击阅读全文的链接后 传递blogId的值--%>
                                <%--<a href='index.aspx?blogid=<%# Eval("blogId") %>' class="readAll">阅读全文</a>--%>
                                <a href='article.aspx?blogId=<%# Eval("blogId") %>' class="readAll">阅读全文</a>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
            <%-- <%--<%--SqlDataSource绑定了user,blog,blogType三张表信息--%>
            <%--   <asp:SqlDataSource ID="sdsBlog" runat="server"
                ConnectionString="<%$ ConnectionStrings:MyBlogConnectionString %>" SelectCommand="SELECT [user].userId, [user].username, [user].password, [user].tel, [user].email, blog.blogId, blog.userId AS Expr1, blog.typeId, blog.blogTitle, blog.blogContent, blog.blogTime, blogType.typeId AS Expr2, blogType.typeName, blogType.typeInfo FROM [user] INNER JOIN blog ON [user].userId = blog.userId INNER JOIN blogType ON blog.typeId = blogType.typeId ORDER BY [blog].blogTime DESC"></asp:SqlDataSource>--%>
            <div class="page">
                当前页码为：<asp:Label ID="num" runat="server"></asp:Label><asp:Label ID="totalNum" runat="server"></asp:Label>
                <asp:Button ID="btnFirst" runat="server" OnClick="btnFirst_Click" Text="第一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnUp" runat="server" OnClick="btnUp_Click" Text="上一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnDown" runat="server" OnClick="btnDown_Click" Text="下一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnLast" runat="server" OnClick="btnLast_Click" Text="最后一页" BackColor="Transparent" CssClass="btnPage" />
            </div>

        </div>
    </form>
</body>
</html>
