<%@ WebHandler Language="C#" Class="ApiEditBlog" %>


using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiEditBlog : IHttpHandler {

    BlogService blogService = new BlogService();

    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string blogId = context.Request.Form["blogId"];
        string blogTitle = context.Request.Form["blogTitle"];
        string blogContent=context.Request.Form["blogContent"];

        bool flag=blogService.updateBlog(int.Parse(blogId),blogTitle,blogContent);
        JObject jo;
        if(flag==true)
        {
            jo = new JObject(new JProperty("msg", "修改成功"));
        }
        else
        {
            jo = new JObject(new JProperty("msg", "修改失败"));

        }
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