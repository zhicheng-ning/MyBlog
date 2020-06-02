<%@ WebHandler Language="C#" Class="ApiAddBlog" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;

public class ApiAddBlog : IHttpHandler {

    BlogService blogService=new BlogService();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string userId =  context.Application["userId"].ToString();
        
        string typeId = context.Request.Params["typeId"];
        string blogTitle = context.Request.Params["blogTitle"];
        string blogContent = context.Request.Params["blogContent"];
        DateTime nowTime = DateTime.Now.ToLocalTime();
        blogService.insertBlog(int.Parse(userId), int.Parse(typeId), blogTitle, blogContent, nowTime);
        JObject jo = new JObject(new JProperty("msg", "文章发布成功！"));
        context.Response.Write(jo);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}