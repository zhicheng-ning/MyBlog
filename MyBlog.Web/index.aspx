<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="Scripts/jquery-3.5.1.js"></script>
    <style>
        body {
            padding: 0;
            margin: 0;
            background: url('images/bg.jpg') no-repeat center ;
            background-size: cover;
        }

        /*头部导航栏*/
        .top {
            width: 100%;
            height: 80px; 
        }

        .tt {
            padding: 0;
            margin: 0;
            list-style: none;
            padding-top: 35px;
            padding-left: 62%;
        }

        .tt li {
            float: left;
            margin-right: 58px;
        }

         .tt a {
            text-decoration: none;
            color: #fff;
         }

         /*下方内容栏*/
        .bot {
            width: 100%;
            height: 753px;   
        }

        /*下左方部分*/
        .left {
            float: left;
            width: 20%;
            height: 100%;   
        }

        /*每日一句*/
        .mood {
            width: 87%;
            /*margin-left: 25px;*/
            float: right;
            height: 220px;
            border: none;
            border-radius: 5px;
            background-color: #fff;
            position: relative;
        }

        .t {
            width: 100%;
            height: 34px;
            line-height: 34px;
            background-color: rgb(88, 157, 198);
            border-radius: 5px 5px 0 0;
            border: 0;
            text-align: center;
            color: #fff;
            font-size: 16px;
        }

        .content {
            text-align: center;
            color: #555;
            padding-top: 10px;
            font-size: 14px;
        }

        .time {
            font-size: 14px;
            position: absolute;
            bottom: 7px;
            left: 0;
            color: rgb(107, 184, 235);
            width: 100%;
            text-align: center;
        }

        /*日历部分*/
        #Ctime {
            width: 87%;
            margin-top: 40px !important;
            background-color: #fff;
            border-style: none !important;
            border-radius: 5px; 
            float: right;
        }

        #Ctime a {
            text-decoration: none;
        }
        
        #Ctime tr{
            height: 35px;
        }
        /*日历标题的样式*/
        #Ctime tr:nth-child(1) td {
            background-color: #fff !important;
            border-radius: 10px;
        }

        .ts {
            margin: 8px auto;
            color: #666;
            font-size: 18px;
        }

        .np a {
            color: #ccc !important;
            padding: 6px;
        }

        /*星期的样式*/
        .dh {
            color: #666;
            padding-bottom: 10px;
            padding-top: 10px;
            border-bottom: 1px solid #68bcf1;
        }

        /*天的样式*/
        .ds {
            font-weight: bold;
            padding: 7px;
        }

        .ds a {
            color: #333;
         }

        .ds:hover {
           background-color: cornflowerblue;
           border-radius: 50%;
         }

        /*今天日期的样式*/
        .td {
            background-color: #68bcf1;
            border-radius: 50%;
        }

        .td a{
            color: #fff !important;
        }

        /*非当前月的天的样式*/
        .om a {
            color: #bbb !important;
        }

        /*被选择的天的样式*/
        .sd {
            border-radius: 50%;
            background-color: cadetblue !important;
        }

        .right {
            float: left;
            width: 80%;
            height: 100%;
        }
        /*右边文章的样式*/
        .r {
            width: 95%;
            height: 100%;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 5px 5px 0 0;
        }
     
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="top">
                <ul class="tt">
                    <li><a href="index.aspx">首页</a></li>
                    <li><a href="login.aspx">登录</a></li>
                    <li><a href="about.aspx">关于</a></li>
                    <li>
                        <asp:LinkButton ID="lbMy" runat="server" OnClick="lbMy_Click">我的</asp:LinkButton>  
                    </li>       
                </ul>
                <asp:Label ID="lblInfo" runat="server" ForeColor="#0066ff"></asp:Label>
            </div>
            <div class="bot">
                <div class="left">
                    <div class="mood">
                        <div class="t">
                            每日一句
                        </div>
                        <div class="content">
                            没有什么能够阻挡<br />
                            你对自由的向往<br />
                            天马行空的生涯
                            <br />
                            你的心了无牵挂
                            <br />
                            <br />
                            摘自《蓝莲花》 
                        </div>
                        <div class="time">
                            星空博客| 2020-05-25
                        </div>
                    </div>
                    <div class="cal">
                        <asp:Calendar ID="Ctime" runat="server" DayNameFormat="Shortest" FirstDayOfWeek="Sunday" TitleStyle-CssClass="ts" SelectedDayStyle-CssClass="sd"
                            DayHeaderStyle-CssClass="dh" DayStyle-CssClass="ds" TodayDayStyle-CssClass="td" OtherMonthDayStyle-CssClass="om" NextPrevStyle-CssClass="np"></asp:Calendar>
                   </div>
                </div>
                <div class="right">
                    <div class="r">
                        <iframe src="articleList.aspx" width="100%" height="100%" scrolling="none"  frameborder="0"  >
                        </iframe>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
