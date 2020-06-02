﻿<%@ WebHandler Language="C#" Class="ApiGetComment" %>

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

public class ApiGetComment : IHttpHandler {
    
    CommentService commentService = new CommentService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string authorId=  context.Application["userId"].ToString();        
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];
        List<comment> msgList = commentService.GetAllComment(int.Parse(authorId),int.Parse(page), int.Parse(limit));
        //注意返回的count是所有的数据，而不是分页当前页面的数据
        int counts = commentService.getCmtCounts(int.Parse(authorId));
        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray comments = new JArray();
        foreach (var item in msgList)
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}