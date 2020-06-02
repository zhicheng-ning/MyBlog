<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

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
         .title{
            width:  430px;  
            padding-top: 70px;
            text-align:center;
            color: #fff;
            font-size: 18px;
            margin-left:  510px;
            
         }
        .a{
            width:  430px;
          /*  margin: 0 auto; */
            margin-top: 40px;
            color:#fff;
            margin-left: 440px;
        }
        #txtName,#txtPwd,#txtPwdAgain,#txtEmail,#txtTel{
            color: #fff;
        }
        #lblMsg{
            padding-left:130px;
        }
        .round{
            border-radius: 20px;
            height: 40px;
        }
    </style>
</head>
<body>
  <form id="form1" runat="server" class="form-horizontal">
      <div class="title">星空博客 欢迎注册</div>
      <div class="a">
            <div class="form-group">
                <label class="control-label col-lg-4 ">用户名：</label>
                <div class="col-lg-8">
                <asp:TextBox ID="txtName" runat="server" BackColor="Transparent" class="form-control round"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtName" Display="Dynamic" ForeColor="Red" ID="rfvName" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-4 ">密码：</label>
                <div class="col-lg-8">
                <asp:TextBox ID="txtPwd" runat="server" BackColor="Transparent" TextMode="Password" class="form-control round"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtPwd" Display="Dynamic" ForeColor="Red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                </div>
            </div>
          <div class="form-group">
                <label class="control-label col-lg-4 ">确认密码：</label>
                <div class="col-lg-8">
                <asp:TextBox ID="txtPwdAgain" runat="server" BackColor="Transparent" TextMode="Password" class="form-control round"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtPwdAgain" Display="Dynamic" ForeColor="Red" ID="RequiredFieldValidator2" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                 <asp:CompareValidator ControlToValidate="txtPwdAgain" ControlToCompare="txtPwd" Display="Dynamic" ForeColor="Red" ID="cvPwd" runat="server" ErrorMessage="2次密码不一致"></asp:CompareValidator>
                </div>
           </div>
          <div class="form-group">
                <label class="control-label col-lg-4 ">邮箱：</label>
                <div class="col-lg-8">
                <asp:TextBox ID="txtEmail" runat="server" BackColor="Transparent" class="form-control round"></asp:TextBox>
                  <asp:RequiredFieldValidator ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ID="rfvEmail" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="邮箱格式不正确！" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                </asp:RegularExpressionValidator>
                </div>
           </div>
          <div class="form-group">
                <label class="control-label col-lg-4 ">电话：</label>
                <div class="col-lg-8">
                <asp:TextBox ID="txtTel" runat="server" BackColor="Transparent" class="form-control round"></asp:TextBox>
                  <asp:RequiredFieldValidator ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="电话格式不正确！" ControlToValidate="txtTel" Display="Dynamic" ForeColor="Red" ValidationExpression="(\(\d{3}\)|\d{3}-)?\d{8}"></asp:RegularExpressionValidator>
               <div>注意：电话号码格式为XXX-XXXXXXXX<br/>例如150-70859491</div>
                </div>
             
              
           </div>
          <div class="form-group">
             <a href="login.aspx"  class="control-label col-lg-4 ">我要登录</a>
              <div class="col-lg-8">
                  <asp:Button ID="btnRegister" runat="server" Text="注册" class=" btn-primary form-control round" OnClick="btnRegister_Click"/>
              </div>
          </div>
             <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
      </div>
         
    
          
       
  </form>
</body>
</html>
