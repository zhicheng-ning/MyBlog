using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class actile : System.Web.UI.Page
{
    CommentService cs = new CommentService();
    UserService us = new UserService();

    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyBlogConnectionString"].ConnectionString.ToString());
    static int totalCount = 0;  //页码总数
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //分页
        if (!IsPostBack)
        {
            num.Text = "1";
            repdatabind();
        }

        //获取页面传过来的博客Id
        string blogId = Request.QueryString["blogId"];
        if (blogId != null)
        {
            int id = int.Parse(blogId);  //转换为int
            //查询博客的评论数
            int count = cs.CommentCount(id);
            lblCount.Text = "共有" + count + "条评论";
        }
 
    }

    protected void btnPub_Click(object sender, EventArgs e)
    {
        //先检验评论内容是否为空
        if (tbComment.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('评论内容不能为空！');</script>");
            //Response.Write(" <script >alert( ' 弹出的消息' );</script> ");  //会使页面变白
        }
        else
        {
            //检验用户是否登录了
            //如果登录了
            if (Session["username"] != null)
            {
                //插入评论到comment表中
                int userid = us.findUserid(Session["username"].ToString());
                string blogId = Request.QueryString["blogId"];
                if (blogId != null)
                {
                    int blogid = int.Parse(blogId);
                    cs.insertIntoComment(blogid, userid, tbComment.Text); //插入评论
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('评论发表成功！');</script>");
                    tbComment.Text = ""; //清空评论信息
                    Response.AddHeader("Refresh", "0");  //刷新此页面
                    
                }
            }
            //未登录
            else
            {
                //弹出警告
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录再发表评论！');</script>");
            }
        }
        
    }

    public void repdatabind()
    {
            connection.Open(); //打开连接的数据库
            //sql语句：连接comment,user两张表  并选择对应的博客id  按评论时间降序
            SqlCommand com = new SqlCommand("select * from comment left join [user] on comment.userId = [user].userId where comment.blogId ="+ Request.QueryString["blogId"] + "order by comment.comTime desc", connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = com; //执行查询
            DataSet ds = new DataSet();
            adapter.Fill(ds); //将数据存放在了myDs数据集中

            PagedDataSource pds = new PagedDataSource();
            pds.DataSource = ds.Tables[0].DefaultView;
            pds.AllowPaging = true;//允许分页
            pds.PageSize = 3;//单页显示项数
            int curpage = Convert.ToInt32(num.Text);
            totalCount = pds.PageCount;
            totalNum.Text = "/" + totalCount;  //设置总页数

            btnDown.Enabled = true;
            btnUp.Enabled = true;
            pds.CurrentPageIndex = curpage - 1; //当前页索引 从0开始
            if (curpage == 1) //如果为第一页
            {
                btnUp.Enabled = false; //禁用上一页
            }
            if (curpage == totalCount)  //如果为最后一页
            {
                btnDown.Enabled = false;  //禁用下一页
            }
            rp2.DataSource = pds;  //设置repeator的数据源
            rp2.DataBind();  //绑定数据源
        
    }

    //点击上一页
    protected void btnUp_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) - 1);
        repdatabind();
    }

    //点击下一页
    protected void btnDown_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) + 1);
        repdatabind();
    }

    //点击第一页
    protected void btnFirst_Click(object sender, EventArgs e)
    {
        num.Text = "1";
        repdatabind();
    }

    //点击最后一页
    protected void btnLast_Click(object sender, EventArgs e)
    {
        //Response.Write(totalCount);
        num.Text = totalCount.ToString();
        repdatabind();
    }

}