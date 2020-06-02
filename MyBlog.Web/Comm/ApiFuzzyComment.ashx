<%@ WebHandler Language="C#" Class="ApiFuzzyComment" %>

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
public class ApiFuzzyComment : IHttpHandler {
    
    CommentService commentService = new CommentService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string comContent = context.Request.Params["comContent"];
        List<comment> cmtList=commentService.searchCmt(comContent);
        int counts = cmtList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray comments = new JArray();
        foreach (var item in cmtList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("commentId", item.commentId));
            p.Add(new JProperty("blogId", item.blogId));
            p.Add(new JProperty("userId", item.userId));
            p.Add(new JProperty("comContent", item.comContent));
            p.Add(new JProperty("comTime", item.comTime));
            comments.Add(p);
        }
        res.Add(new JProperty("data", comments));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}