<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <style> 
        body{
            background: url('images/bg.jpg') no-repeat;
            background-size: cover;
        }
  
        .con{
            width:300px;
            margin: 0 auto; 
            margin-top: 115px;
            position: relative;
            
        }
        .title{
            width: 300px;
            color:#fff;
            text-align:center;
            font-size: 18px;
            margin-bottom: 25px;
        }
        .round{
            border-radius: 20px;
            height: 40px;
        }
        #txtUserame,#txtPassword,#txtCheckcode{
             padding-left: 40px !important;
             color:#fff;
        }
        .o{
            margin-top: 15px;
        }
        #hlGetpassword{
             padding-left: 150px;
        }
        HyperLink:hover{
            color:#fff;
        }
        #imgUsername{
            width: 18px;
            height: 18px;
            position: absolute;
            top: 62px;
            left:13px; 
        }
        #imgPassword{
            width: 18px;
            height: 18px;
            position: absolute;
            top: 122px;
            left:13px; 
        }
        #imgChkcode{
            width: 25px;
            height: 25px;
            position: absolute;
            top: 178px;
            left: 10px; 
        }
        #imgChkcode2{
            position: absolute;
            top: 177px;
            left: 214px; 
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-group">
        <div></div>
        <div class="con">
            <div class="title">
                <asp:Label ID="lblTitle" runat="server" Text="星空博客 欢迎你" ></asp:Label>
            </div> 
            <asp:Image ID="imgUsername" ImageUrl="~/images/username.png" runat="server" />
            <asp:TextBox ID="txtUserame" runat="server"  BackColor="Transparent" ToolTip="用户名" class="form-control round round-border" ></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="txtUserame" Display="Dynamic" ForeColor="Red" ID="rfvName" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
            <br />
            <asp:Image ID="imgPassword"  ImageUrl="~/images/password.png" runat="server" /> 
            <asp:TextBox ID="txtPassword" runat="server"  TextMode="Password" ToolTip="密码" BackColor="Transparent" class="form-control round round-border" ></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" ID="rfvPssword" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtCheckcode" runat="server"  BackColor="Transparent" ToolTip="验证码" class="form-control round round-border" ></asp:TextBox>
            <asp:Image ID="imgChkcode" ImageUrl="~/images/checkcode.png"  runat="server" />
            <asp:Image ID="imgChkcode2" runat="server" ImageUrl="checkcode.aspx" onclick="this.src=this.src+'?'" ImageAlign="Middle" ToolTip="换一张"  />
            <asp:RequiredFieldValidator ControlToValidate="txtCheckcode" Display="Dynamic" ForeColor="Red" ID="rfvCheckcode" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="登录" class="form-control btn-primary round" OnClick="btnLogin_Click" />
            <div class="o">
                <asp:HyperLink ID="hlRegister" runat="server" NavigateUrl="~/register.aspx">没有账号？</asp:HyperLink>
                <asp:HyperLink ID="hlGetpassword" runat="server" NavigateUrl="~/findPwd.aspx">忘记密码？</asp:HyperLink>
            </div>
            <div>
                <asp:Label ID="lblErr" runat="server" Text="" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
  
    
</body>
</html>
