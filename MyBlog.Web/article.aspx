<%@ Page Language="C#" AutoEventWireup="true" CodeFile="article.aspx.cs" Inherits="actile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        .cc {
            width: 100%;
            height: 100%;
        }

        .con {
            width: 95%;
            margin: 0 auto;
            background-color: #fff;
        }

        .return{         
            height: 20px;
            padding-left: 30px;
        }
        .link_return{
            text-decoration: none;
            color: rgb(82, 98, 160);
            font-size: 16px;
        }

        .title {
            width: 100%;
            height: 50px;
            line-height: 50px;
            text-align:center;
            font-size: 18px;
            font-weight: bold;
            border-bottom: 1px dotted rgb(88, 157, 198);
        }

        

        .note {
            width: 100%;
            height: 30px;
            line-height: 30px;
            border-bottom: 1px dotted rgb(88, 157, 198);
            color: rgb(88, 157, 198);
        }
        .note .pubTime{
            padding-left: 160px;
        }
        .note .author {
            padding-left: 180px;
        }

        .bcontent {
            line-height: 1.5;
            width: 95%;
            margin: 0 auto;
            margin-top: 30px;
            color: #333;
            line-height: 1.8;
        }

        .comment {
            width: 90%;
            height: 207px;
            margin: 0 auto;
            margin-top: 50px;
        }

        .comHeader {
            width: 30%;
            height: 35px;
            line-height: 35px;
            text-align: center;
            border-radius: 7px 7px 0 0;
            color: #fff;
            background-color: rgb(97, 189, 250);
            margin-bottom: -3px;
        }

        .comSection {
            width: 100%;
            height: 135px;
            border: 2px solid rgb(106, 171, 220);
            background-color: #fff;
        }

        .pubBtn {
            float: right;
            width: 80px;
            height: 30px;
            background-color: rgb(97, 189, 250);
            color: #fff;
            border: none;
            margin-top: 7px;
            margin-right: -5px;
        }

        /*评论*/
        .commentDisplay {
            width: 90%;
            margin: 0 auto;
            margin-top: 25px;
        }

        .newest {
            width: 100%;
            height: 23px;
            line-height: 23px;
            color: rgb(97, 189, 250);
            margin: 0 auto;
            border-bottom: 1px solid rgb(97, 189, 250);
        }

        #lblCount {
            float: right;
        }

        ul, .comList {
            list-style: none;
            margin: 0;
            padding: 0;
        }

            .comList > li {
                width: 100%;
                height: 70px;
                padding-top: 10px;
                border-bottom: 1px solid #ccc;
                padding-bottom: 5px;
            }

            .comList .liLeft {
                float: left;
                width: 7%;
                height: 50px;
            }

                .comList .liLeft img {
                    width: 40px;
                    height: 40px;
                    padding-left: 10px;
                }

            .comList .liRight {
                float: left;
                width: 93%;
                height: 50px;
            }

        .liRight .u {
            color: rgb(127, 190, 207);
            height: 20px;
            line-height: 10px;
        }

        .liRight .eval {
            height: 30px;
            line-height: 20px;
            color: #444;
        }

        .liRight div {
            float: right;
            color: #999;
        }

         .page{
            float: right;
            height: 30px;
            line-height: 30px;
            margin-top: 10px;
            color: #999;
        }
        #totalNum{
            margin-right: 15px;
        }
        .btnPage{
            border: none;
            font-size: 15px;
            color: rgb(88, 157, 198);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--文章内容显示--%>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsBlog">
                <HeaderTemplate>
                    <div class="cc">
                        <div class="return" >
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/articleList.aspx" CssClass="link_return">返回文章列表</asp:HyperLink>
                        </div>
                </HeaderTemplate>
                <ItemTemplate>

                    <div class="con">
                        <div class="title">
                          <%# Eval("blogTitle") %>
                        </div>
                        <div class="note">
                            <label class="pubTime">发布时间：<%# Eval("blogTime") %> </label>
                            <label class="author">作者：<%# Eval("username") %> </label>
                        </div>
                        <div class="bcontent"><%# Eval("blogContent") %></div>
                    </div>

                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <%--选择和主页传过来的blogId相同的博客内容 默认为blogId=1的博客 博客blog表--%>
            <asp:SqlDataSource ID="sdsBlog" runat="server" ConnectionString="<%$ ConnectionStrings:MyBlogConnectionString %>" SelectCommand="SELECT blog.blogId, blog.userId, blog.typeId, blog.blogTitle, blog.blogContent, blog.blogTime, [user].userId AS Expr1, [user].username, [user].password, [user].tel, [user].email FROM blog INNER JOIN [user] ON blog.userId = [user].userId WHERE (blog.blogId = @blogId)">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="1" Name="blogId" QueryStringField="blogId" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <%--评论发表区显示--%>
            <div class="comment">
                <div class="comHeader">
                评论区
                </div>
                <asp:TextBox ID="tbComment" runat="server" CssClass="comSection" TextMode="MultiLine"></asp:TextBox>
                <asp:Button ID="btnPub" runat="server" Text="发表" CssClass="pubBtn" OnClick="btnPub_Click"/>
            </div>
            <%--评论显示区--%>
            <div class="commentDisplay">
                <div class="newest">
                    <asp:Label ID="Label2" runat="server" Text="最新评论"></asp:Label>
                    <asp:Label ID="lblCount" runat="server"></asp:Label>
                </div>
                <div class="commentContent">
                    <asp:Repeater ID="rp2" runat="server" >
                        <HeaderTemplate>
                            <ul class="comList">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li>
                                <div class="liLeft">
                                    <image src="images/head.png"></image>
                                </div>
                                <div class="liRight">
                                    <ul>
                                        <li class="u"><%# Eval("username") %></li>
                                        <li class="eval"><%# Eval("comContent") %></li>
                                    </ul>
                                    <div>
                                        <%# Eval("comTime") %>
                                    </div>
                                </div>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                    <%--选择此博客的所有评论信息--%>
                <%--    <asp:SqlDataSource ID="sdsComment" runat="server" ConnectionString="<%$ ConnectionStrings:MyBlogConnectionString %>" SelectCommand="SELECT comment.commentId, comment.blogId, comment.userId, comment.comContent, comment.comTime, [user].userId AS Expr1, [user].username, [user].password, [user].tel, [user].email FROM comment INNER JOIN [user] ON comment.userId = [user].userId WHERE (comment.blogId = @blogId) ORDER BY comment.comTime DESC">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="1" Name="blogId" QueryStringField="blogId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>--%>
                    <div class="page">
                当前页码为：<asp:Label ID="num" runat="server"></asp:Label><asp:Label ID="totalNum" runat="server"></asp:Label>
                <asp:Button ID="btnFirst" runat="server" OnClick="btnFirst_Click" Text="第一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnUp" runat="server" onclick="btnUp_Click" Text="上一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnDown" runat="server" onclick="btnDown_Click" Text="下一页" BackColor="Transparent" CssClass="btnPage" />
                <asp:Button ID="btnLast" runat="server" OnClick="btnLast_Click" Text="最后一页" BackColor="Transparent" CssClass="btnPage" />
            </div> 
                </div>
            </div>
    </div>
    </form>

</body>
</html>
