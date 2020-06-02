<%@ WebHandler Language="C#" Class="ApiFuzzyPhoto" %>

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

public class ApiFuzzyPhoto : IHttpHandler {
    AlbumService albumService = new AlbumService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string photoName = context.Request.Params["photoName"];
        string userId=context.Application["userId"].ToString();
        List<photo> photoList=albumService.searchPhoto(int.Parse(userId),photoName);
        int counts = photoList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray photos = new JArray();
        foreach (var item in photoList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("photoId", item.photoId));
            p.Add(new JProperty("photoName", item.photoName));
            p.Add(new JProperty("photoUrl", item.photoUrl));
            p.Add(new JProperty("photoTime", item.photoTime));
            photos.Add(p);
        }
        res.Add(new JProperty("data", photos));
        context.Response.Write(res);

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}