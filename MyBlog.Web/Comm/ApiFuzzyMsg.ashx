<%@ WebHandler Language="C#" Class="ApiFuzzyMsg" %>


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
public class ApiFuzzyMsg : IHttpHandler {
    
    MessageService messageService = new MessageService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string messageContent = context.Request.Params["messageContent"];
        List<message> msgList=messageService.searchMsg(messageContent);
        int counts = msgList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray messages = new JArray();
        foreach (var item in msgList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("messageId", item.messageId));
            p.Add(new JProperty("authorId", item.authorId));
            p.Add(new JProperty("messageContent", item.messageContent));
            p.Add(new JProperty("messageTime", item.messageTime));
            messages.Add(p);
        }
        res.Add(new JProperty("data", messages));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }


}