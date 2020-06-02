<%@ WebHandler Language="C#" Class="ApiFuzzyBlogType" %>


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

    //模糊搜索
public class ApiFuzzyBlogType : IHttpHandler {
    
    BlogTypeService typeService = new BlogTypeService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string typeNameOrInfo = context.Request.Params["typeNameOrInfo"];
        List<blogType> typeList=typeService.searchBlogType(typeNameOrInfo);
        int counts = typeList.Count;
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}