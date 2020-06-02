<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homepage.aspx.cs" Inherits="homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/articleList.css" rel="stylesheet" />
    <style>
        body {
            padding: 0;
            margin: 0;
            background: url('images/bg.jpg') no-repeat center;
            background-size: cover;
        }
         /*头部导航栏*/
        .header {
            width: 100%;
            height: 80px;
            line-height: 80px;
            
        }
        .header .tt{
            list-style: none;
            padding: 0;
            margin: 0;
            margin-right: 45px;
        }
        .header .tt li{
            float: right;
            margin-right: 60px;
        }
        .header .lblInfo{
            float: right;
            margin-right: 65px;
        }
        .header a{
            text-decoration: none;
            color: #fff;
        }

        /*左边区域*/
        .left {
            width: 280px;
            height: 800px;
            margin-left: 50px;
            float: left;
        }
        /*个人资料区*/
        .top {
            width: 100%;
            height: 210px;
            background-color: #fff;
            color: #333;
            position: relative;
            border-radius: 5px;
        }

        .basic {
            padding-top: 20px;
            color: rgb(22, 26, 185);
            text-align: center;
        }

        .head {
            width: 60px;
            height: 60px;
            padding-top: 20px;
            padding-left: 15px;
            margin-bottom: 10px;
        }

        .name {
            margin-left: 15px;
            position: absolute;
            top: 90px;
            font-size: 24px;
        }

        .tel, .email {
            padding-left: 15px;
            line-height: 2;
        }

        /*相片展示区*/
        .photo{
           width: 100%;
           height: 280px;

           background-color: #fff;
           color: #333;
           margin-top:  15px;
           border-radius: 5px;
        }
        .p{    
            width: 92%;
            margin: 0 auto;       
            margin-top: 10px;
        }
         .p .imgPhoto{
             width: 100%;
             height: 160px;
             object-fit: cover;
         }

        /*留言区*/
        .message {
            width: 100%;
            height: 390px;
            background-color: #fff;
            color: #333;
            margin-top: 15px;
            border-radius: 5px 5px 0 0;
        }

        .mesArea {
            margin-top: 20px;
            margin-left: 15px;
            margin-bottom: 25px;
        }

        .tbMes {
            width: 246px;
            height: 120px;
            border: 1px solid rgb(22, 26, 185);
            border-radius: 3px;
        }

        .btnMessage {
            float: right;
            width: 60px;
            height: 30px;
            background-color: rgb(9, 101, 160);
            color: #fff;
            border: none;
            margin-top: 4px;
            margin-right: 15px;
            border-radius: 3px;
        }

        .message li {
            padding-left: 15px;
            border-bottom: 1px solid #ccc;
            padding-top: 8px;
            padding-bottom: 5px;
        }

        .username {
            color: rgb(9, 101, 160);
        }

        .msTime {
            color: #666;
            float: right;
            padding-right: 15px;
            font-size: 14px;
            padding-top: 2px;
        }

        .curPage {
            margin-left: 7px;
        }
 
        /*文章区*/
        .actile {
            width: 70%;
            height: 910px;
            float: left;
            background-color: #fff;
            margin-left: 15px;
            border-radius: 5px 5px 0 0;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="header">
                <asp:Label ID="lblInfo" runat="server" ForeColor="#0066ff"  CssClass="lblInfo"></asp:Label>
                <ul class="tt">
                    <li>
                        <asp:LinkButton ID="lbMy" runat="server" OnClick="lbMy_Click">我的</asp:LinkButton>
                    </li>
                    <li><a href="about.aspx">关于</a></li>
                    <li><a href="login.aspx">登录</a></li>
                    <li><a href="index.aspx">首页</a></li>      
                </ul>    
            </div>
            <div class="left">
                <%--个人资料区--%>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <div class="top">
                            <div class="basic">--------------基本信息--------------</div>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div>
                            <asp:Image ID="imgHead" runat="server" ImageUrl="~/images/head.png" CssClass="head" />
                            <asp:Label ID="lblUsername" runat="server" CssClass="name"><%# Eval("username") %></asp:Label>
                        </div>
                        <div>
                            <asp:Label ID="lblTel" runat="server" CssClass="tel">电话： <%# Eval("tel") %></asp:Label>
                        </div>
                        <div>
                            <asp:Label ID="lblEmail" runat="server" CssClass="email">邮箱： <%# Eval("email") %></asp:Label>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyBlogConnectionString %>" SelectCommand="SELECT * FROM [user] WHERE ([userId] = @userId)">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="1" Name="userId" QueryStringField="userId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <%--相册区--%>
                <div class="photo">
                    <div class="basic">--------------精选相片--------------</div>
                    <asp:Repeater ID="rp3" runat="server">
                        <HeaderTemplate>
                            <div class="p">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Image ID="imgPhoto" runat="server" ImageUrl='<%# Eval("photoUrl") %>' CssClass="imgPhoto"/>
                        </ItemTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                    <div class="page">
                        <div class="curPage">当前页码为：<asp:Label ID="num3" runat="server"></asp:Label><asp:Label ID="totalNum3" runat="server"></asp:Label></div>
                        <asp:Button ID="btnFirstOne" runat="server" OnClick="btnFirstOne_Click"  Text="第一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnUpOne" runat="server" OnClick="btnUpOne_Click"  Text="上一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnDownOne" runat="server" OnClick="btnDownOne_Click"  Text="下一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnLastOne" runat="server" OnClick="btnLastOne_Click" Text="最后一页" BackColor="Transparent" CssClass="btnPage" />
                    </div>

                </div>


                <%--留言区--%>
                <div class="message">
                    <div class="basic">----------------留言区----------------</div>
                    <%--写留言--%>
                    <div class="mesArea">
                        <asp:TextBox ID="tbMes" runat="server" TextMode="MultiLine" CssClass="tbMes" ToolTip="在这儿留下你的留言！"></asp:TextBox>
                        <asp:Button ID="btnMessage" runat="server" Text="留言" CssClass="btnMessage" OnClick="btnMessage_Click" />
                    </div>
                    <%--留言信息--%>
                    <asp:Repeater ID="rp2" runat="server">
                        <HeaderTemplate>
                            <ul>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li>
                                <div><%# Eval("messageContent") %></div>
                                <div>
                                    <asp:Label ID="Label1" runat="server" CssClass="username"> <%# Eval("username") %> </asp:Label>
                                    <asp:Label ID="Label3" runat="server" CssClass="msTime"> <%# Eval("messageTime") %> </asp:Label>
                                </div>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                    <div class="page">
                        <div class="curPage">当前页码为：<asp:Label ID="num2" runat="server"></asp:Label><asp:Label ID="totalNum2" runat="server"></asp:Label></div>
                        <asp:Button ID="btnFirstMessage" runat="server" OnClick="btnFirstMessage_Click" Text="第一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnUpMessage" runat="server" OnClick="btnUpMessage_Click" Text="上一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnDownMessage" runat="server" OnClick="btnDownMessage_Click" Text="下一页" BackColor="Transparent" CssClass="btnPage" />
                        <asp:Button ID="btnLastMessage" runat="server" OnClick="btnLastMessage_Click" Text="最后一页" BackColor="Transparent" CssClass="btnPage" />
                    </div>

                </div>
                
            </div>

            <%--文章显示区--%>
            <div class="actile">   
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
                    <asp:Button ID="btnFirstArticle" runat="server" OnClick="btnFirstArticle_Click" Text="第一页" BackColor="Transparent" CssClass="btnPage" />
                    <asp:Button ID="btnUpArticle" runat="server" OnClick="btnUpArticle_Click" Text="上一页" BackColor="Transparent" CssClass="btnPage" />
                    <asp:Button ID="btnDownArticle" runat="server" OnClick="btnDownArticle_Click" Text="下一页" BackColor="Transparent" CssClass="btnPage" />
                    <asp:Button ID="btnLastArticle" runat="server" OnClick="btnLastArticle_Click" Text="最后一页" BackColor="Transparent" CssClass="btnPage" />
                </div>


            </div>

        </div>

    </form>
</body>
</html>
