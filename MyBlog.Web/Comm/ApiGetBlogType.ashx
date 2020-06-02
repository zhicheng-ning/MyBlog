<%@ WebHandler Language="C#" Class="ApiGetBlogType" %>


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
//获取所有的博客类别
public class ApiGetBlogType : IHttpHandler {
    
     BlogTypeService typeService = new BlogTypeService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];

        List<blogType> typeList = typeService.GetAllBlogType(int.Parse(page), int.Parse(limit));
        //注意返回的count是所有的数据，而不是分页当前页面的数据
        int counts = typeService.getBlogTypeCounts();

        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray types = new JArray();
        foreach (var item in typeList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("typeId", item.typeId));
            p.Add(new JProperty("typeName", item.typeName));
            p.Add(new JProperty("typeInfo", item.typeInfo));
            types.Add(p);
        }
        res.Add(new JProperty("data", types));
        context.Response.Write(res);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}