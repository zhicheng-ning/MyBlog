using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class login : System.Web.UI.Page
{
    UserService userService = new UserService();
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //先检查验证码是否正确 正确的验证码存入了Session中
        if(txtCheckcode.Text.ToString() == Session["checkcode"].ToString())
        {
            //检查登录是否成功
            int r = userService.checkLogin(txtUserame.Text, txtPassword.Text);
            //登录成功
            if (r > 0)
            {
                lblErr.Text = "";
                Session["username"] = txtUserame.Text;  //记录用户名到session中
                Response.Redirect("~/index.aspx");  //跳转到主页
            }
            //登录失败 提示错误信息
            else
            {
                lblErr.Text = "用户名或密码错误";
            }
        }
        else
        {
            lblErr.Text = "验证码错误";
        }
 
    }
}