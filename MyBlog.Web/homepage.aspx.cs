using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class homepage : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyBlogConnectionString"].ConnectionString.ToString());
    static int totalAtCount = 0;  //文章页面总数
    static int totalMsCount = 0;  //留言页面总数
    static int totalPhCount = 0;  //相册页面总数
    UserService us = new UserService();
    MessageService ms = new MessageService();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //博主文章列表的分页
            num.Text = "1";
            repdatabind();  //对文章列表repeater数据绑定
            //留言信息列表的分页
            num2.Text = "1";
            rep2databind();  //对留言列表repeater数据绑定
            //相片信息的分页
            num3.Text = "1";
            rep3databind();  //对图片列表repeater数据绑定
        }
        if (Session["username"] != null)
        {
            lblInfo.Text = Session["username"].ToString() + ",欢迎你";
        }

    }

    

    //对文章列表进行数据绑定
    public void repdatabind()
    {
        connection.Open(); //打开连接的数据库
        //修改sql语句
        //sql语句：连接user,blog,blogType三张表 选择此博主的所有博客 并按博客时间降序
        SqlCommand com = new SqlCommand("select * from blog left join [user] on blog.userId=[user].userId left join blogType on blog.typeId=blogType.typeId where blog.userId="+ Request.QueryString["userId"] +"order by blog.blogTime desc", connection);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds); //将数据存放在了myDs数据集中

        PagedDataSource pds = new PagedDataSource();
        pds.DataSource = ds.Tables[0].DefaultView;
        pds.AllowPaging = true;//允许分页
        pds.PageSize = 6;//单页显示项数
        int curpage = Convert.ToInt32(num.Text);
        totalAtCount = pds.PageCount;
        totalNum.Text = "/" + totalAtCount;  //设置总页数

        btnDownArticle.Enabled = true;
        btnUpArticle.Enabled = true;
        pds.CurrentPageIndex = curpage - 1; //当前页索引 从0开始
        if (curpage == 1) //如果为第一页
        {
            btnUpArticle.Enabled = false; //禁用上一页
        }
        if (curpage == totalAtCount)  //如果为最后一页
        {
            btnDownArticle.Enabled = false;  //禁用下一页
        }
        rp.DataSource = pds;  //设置repeator的数据源
        rp.DataBind();  //绑定数据源
        connection.Close();
    }

    //点击上一页文章
    protected void btnUpArticle_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) - 1);
        repdatabind();
    }

    //点击下一页文章
    protected void btnDownArticle_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) + 1);
        repdatabind();
    }

    //点击第一页文章
    protected void btnFirstArticle_Click(object sender, EventArgs e)
    {
        num.Text = "1";
        repdatabind();
    }

    //点击最后一页文章
    protected void btnLastArticle_Click(object sender, EventArgs e)
    {
        num.Text = totalAtCount.ToString();
        repdatabind();
    }


    //对留言列表进行数据绑定
    public void rep2databind()
    {
        connection.Open(); //打开连接的数据库
        //修改sql语句
        //sql语句：连接user,message三张表 选择此博主的所有留言 并按留言时间降序
        SqlCommand com = new SqlCommand("select * from message left join [user] on message.userId=[user].userId where message.authorId=" + Request.QueryString["userId"] + "order by message.messageTime desc", connection);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds); //将数据存放在了myDs数据集中

        PagedDataSource pds = new PagedDataSource();
        pds.DataSource = ds.Tables[0].DefaultView;
        pds.AllowPaging = true;//允许分页
        pds.PageSize = 2;//单页显示项数
        int curpage = Convert.ToInt32(num2.Text);
        totalMsCount = pds.PageCount;
        totalNum2.Text = "/" + totalMsCount;  //设置总页数

        btnDownMessage.Enabled = true;
        btnUpMessage.Enabled = true;
        pds.CurrentPageIndex = curpage - 1; //当前页索引 从0开始
        if (curpage == 1) //如果为第一页
        {
            btnUpMessage.Enabled = false; //禁用上一页
        }
        if (curpage == totalMsCount)  //如果为最后一页
        {
            btnDownMessage.Enabled = false;  //禁用下一页
        }
        rp2.DataSource = pds;  //设置repeator的数据源
        rp2.DataBind();  //绑定数据源
        connection.Close();
    }


   //点击上一页留言
    protected void btnUpMessage_Click(object sender, EventArgs e)
    {
        num2.Text = Convert.ToString(Convert.ToInt32(num2.Text) - 1);
        rep2databind();
    }

    //点击下一页留言
    protected void btnDownMessage_Click(object sender, EventArgs e)
    {
        num2.Text = Convert.ToString(Convert.ToInt32(num2.Text) + 1);
        rep2databind();
    }
    //点击第一页留言
    protected void btnFirstMessage_Click(object sender, EventArgs e)
    {
        num2.Text = "1";
        rep2databind();
    }
    //点击最后一页留言
    protected void btnLastMessage_Click(object sender, EventArgs e)
    {
        num2.Text = totalMsCount.ToString();
        rep2databind();
    }

    //点击发表留言
    protected void btnMessage_Click(object sender, EventArgs e)
    {
        //先检验留言是否为空
        if (tbMes.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('留言内容不能为空！');</script>");
            //Response.Write(" <script >alert( ' 弹出的消息' );</script> ");  //会使页面变白
        }
        else
        {
            //检验用户是否登录了
            //如果登录了
            if (Session["username"] != null)
            {
                //插入留言到message表中
                int userId = us.findUserid(Session["username"].ToString());  //评论者id
                string authorId = Request.QueryString["userId"];  //博主id
                if (authorId != null)
                {
                    int _authorId = int.Parse(authorId);
                    ms.insertIntoMessage(_authorId, userId, tbMes.Text); //插入评论
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('评论发表成功！');</script>");
                    tbMes.Text = ""; //清空留言信息
                    Response.AddHeader("Refresh", "0");  //刷新此页面

                }
            }
            //未登录
            else
            {
                //弹出警告
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录再留言！');</script>");
            }
        }
    }

    //点击了上方“我的”链接
    protected void lbMy_Click(object sender, EventArgs e)
    {
        //如果登录了
        if (Session["username"] != null)
        {
            //跳转到此用户的后台管理界面
            Response.Redirect("BackStage.aspx?username=" + Session["username"]);
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录！');</script>");
        }
    }

    //对相册列表进行数据绑定
    public void rep3databind()
    {
        connection.Open(); //打开连接的数据库
        //修改sql语句
        //sql语句：在photo表中 选择此博主的所有照片 并按发布时间降序
        SqlCommand com = new SqlCommand("select * from photo where photo.userId=" + Request.QueryString["userId"] + "order by photo.photoTime desc", connection);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds); //将数据存放在了myDs数据集中

        PagedDataSource pds = new PagedDataSource();
        pds.DataSource = ds.Tables[0].DefaultView;
        pds.AllowPaging = true;//允许分页
        pds.PageSize = 1;//单页显示项数
        int curpage = Convert.ToInt32(num3.Text);
        totalPhCount = pds.PageCount;
        totalNum3.Text = "/" + totalPhCount;  //设置总页数

        btnDownOne.Enabled = true;
        btnUpOne.Enabled = true;
        pds.CurrentPageIndex = curpage - 1; //当前页索引 从0开始
        if (curpage == 1) //如果为第一页
        {
            btnUpOne.Enabled = false; //禁用上一页
        }
        if (curpage == totalPhCount)  //如果为最后一页
        {
            btnDownOne.Enabled = false;  //禁用下一页
        }
        rp3.DataSource = pds;  //设置repeator的数据源
        rp3.DataBind();  //绑定数据源
        connection.Close();
    }

    //点击了相册的上一张
    protected void btnUpOne_Click(object sender, EventArgs e)
    {
        num3.Text = Convert.ToString(Convert.ToInt32(num3.Text) - 1);
        rep3databind();
    }

    //点击了相册的下一张
    protected void btnDownOne_Click(object sender, EventArgs e)
    {
        num3.Text = Convert.ToString(Convert.ToInt32(num3.Text) + 1);
        rep3databind();
    }

    //点击了相册的第一张
    protected void btnFirstOne_Click(object sender, EventArgs e)
    {
        num3.Text = "1";
        rep3databind();
    }

    //点击了相册的最后一张
    protected void btnLastOne_Click(object sender, EventArgs e)
    {
        num3.Text = totalPhCount.ToString();
        rep3databind();
    }
}