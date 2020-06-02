<%@ WebHandler Language="C#" Class="ApiFuzzyBlog" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using MyBlog.DAL;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

public class ApiFuzzyBlog : IHttpHandler {
    
    BlogService blogService = new BlogService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string blogTitleOrContent = context.Request.Params["blogTitleOrContent"];
        string userId =context.Application["userId"].ToString();
        List<blog> blogList=blogService.searchBlog(int.Parse(userId),blogTitleOrContent);
        int counts = blogList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray blogs = new JArray();
        foreach (var item in blogList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("blogId", item.blogId));
            p.Add(new JProperty("typeId", item.typeId));
            p.Add(new JProperty("blogTitle", item.blogTitle));
            p.Add(new JProperty("blogContent", item.blogContent));
            p.Add(new JProperty("blogTime",item.blogTime));
            blogs.Add(p);
        }
        res.Add(new JProperty("data", blogs));
        context.Response.Write(res);

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}