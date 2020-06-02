using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class register : System.Web.UI.Page
{
    UserService userService = new UserService();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        //如果页面验证成功
        if (Page.IsValid)
        {
            //如果出现重名的情况
            if (userService.isNameSame(txtName.Text))
            {
                lblMsg.Text = "用户名已存在！"; //提示用户名已存在
            }
            //不重名
            else
            {
                //插入记录到数据库中
                userService.insertUserInfo(txtName.Text, txtPwd.Text, txtEmail.Text, txtTel.Text);
                //带参数(用户名)  跳转到登录界面 
                Response.Redirect("~/login.aspx?username=" + txtName.Text);
            }
        }
       
    }
}