<%@ Page Language="C#" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
        body{
            background: url('images/bg.jpg') no-repeat;
            background-size: cover;

        }
        .about{
            width: 20%;
            margin: 0 auto;
            margin-top: 110px;
            color: #fff;
        }
        .t{
            font-weight: bold;
            font-size: 18px;
            text-align: center;
            margin-bottom:20px;
        }
        .i{
            line-height: 2;
            margin-left: 15px;
        }
        .c{
            margin-left: 20px;
        }
        .copy{
            text-align: center;
            margin-top: 280px;
            color:#999;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="about">
            <div class="t">星空博客社区</div>
            <div  class="i">
            学校： <span class="c">南昌大学</span> <br />
            组名： <span class="c">404</span> <br />
            组长： <span class="c">毛双双 8002117254</span> <br />
            组员： <span class="c">宁志成 8002117277</span> <br />
            组员： <span class="c">魏志光 8002117260</span> <br />
            </div>
            <div class="copy">
                &copy; 版权所有，翻版必究
            </div>
            
        </div>
    </form>
</body>
</html>
