using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.DAL;

public partial class actileList : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyBlogConnectionString"].ConnectionString.ToString());
    static int totalCount=0;  //页面总数
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            num.Text = "1";
            repdatabind();
        }


    }
    public void repdatabind()
    {
        connection.Open(); //打开连接的数据库
        //sql语句：连接user,blog,blogType三张表 并按博客时间降序
        SqlCommand com = new SqlCommand("select * from blog left join [user] on blog.userId=[user].userId left join blogType on blog.typeId=blogType.typeId order by blog.blogTime desc", connection);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds); //将数据存放在了myDs数据集中

        PagedDataSource pds = new PagedDataSource();
        pds.DataSource = ds.Tables[0].DefaultView;
        pds.AllowPaging = true;//允许分页
        pds.PageSize = 5;//单页显示项数
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
        rp.DataSource = pds;  //设置repeator的数据源
        rp.DataBind();  //绑定数据源
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