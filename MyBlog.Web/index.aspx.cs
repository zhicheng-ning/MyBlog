using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            lblInfo.Text=Session["username"].ToString() + ",欢迎你";
        }
        //Response.Write(Request.QueryString["blogId"]);
        ////页面传递了参数-blogId 
        //if (id != null)
        //{
        //    //在right中 加载此id对应的博客内容
        //    Response.Write("<script> $(function(){ $('.right').load('actile.aspx') }) </script>");
        //}
      
    }



    protected void lbMy_Click(object sender, EventArgs e)
    {
        //如果登录了
        if (Session["username"] != null)
        {
            //跳转到此用户的后台管理界面
            Response.Redirect("BackStage.aspx?username="+ Session["username"]);
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录！');</script>");
        }
    }

}