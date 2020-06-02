<%@ Page Language="C#" AutoEventWireup="true" CodeFile="findPwd.aspx.cs" Inherits="findPwd" %>

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
            width: 400px;
            margin: 0 auto;
            margin-top: 135px;
            position: relative;
            color:#fff;
        }
        .title{
            width: 450px;
            color:#fff;
            text-align:center;
            font-size: 18px;
            margin-bottom: 25px;
        }
        .round{
            border-radius: 20px;
            height: 40px;
        }
        #txtUserame,#txtEmail{      
             color:#fff;
             padding-left: 20px;
        }
        #lblErr{
            margin-left: 160px;
        }
        #lblInfo{
            margin-left: 170px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
        <div class="con">
            <div class="title">
                <asp:Label ID="lblTitle" runat="server" Text="找回密码" ></asp:Label>
            </div>  
            <div class="form-group">
                <label  class="control-label col-lg-3 ">用户名：</label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtUserame" runat="server"  BackColor="Transparent" class="form-control round round-border" ></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtUserame" Display="Dynamic" ForeColor="Red" ID="rfvName" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label  class="control-label col-lg-3 ">邮箱：</label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtEmail" runat="server" BackColor="Transparent" class="form-control round round-border" ></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ID="rfvEmail" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="邮箱格式不正确！" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>      
                </div>
            </div>
            <div class="form-group">
                <label  class="control-label col-lg-3 "></label>
                <div class="col-lg-9">
                     <asp:Button ID="btnFind" runat="server" Text="找回密码" class="form-control btn-primary round" OnClick="btnFind_Click" />
            
                </div>
               </div>
            <div>
                <asp:Label ID="lblErr" runat="server" Text="" ForeColor="Red"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblInfo" runat="server" Text="" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
