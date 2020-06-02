<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostArticle.aspx.cs" Inherits="PostArticle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布文章</title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
</head>
<body>

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend style="text-align: center">文章发布</legend>
    </fieldset>

    <form class="layui-form" id="articleForm" action="">

        <div class="layui-form-item">
            <label class="layui-form-label">博客标题</label>
            <div class="layui-input-block">
                <input id="blogTitleVal" type="text" name="blogTitle" lay-verify="required" lay-reqtext="博客标题不能为空噢" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">博客类别</label>
            <div class="layui-input-block">
                <select name="typeId" id="typeIdVal" lay-filter="blogType" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <option value="1" selected="">散文</option>
                    <option value="2">诗歌</option>
                    <option value="3">小说</option>
                    <option value="4">随笔</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">博客文章</label>
            <div class="layui-input-block">
                <textarea id="blogContentVal" name="blogContent" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <!--<div class="layui-form-item layui-form-text">
    <label class="layui-form-label">编辑器</label>
    <div class="layui-input-block">
      <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
    </div>
  </div>-->
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">发布文章</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>


    <script src="Contents/layui.js"></script>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function () {
            var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , $ = layui.jquery
            //创建一个编辑器
            //var editIndex = layedit.build('LAY_demo_editor');


            //监听提交
            form.on('submit(demo1)', function (data) {
                $.ajax({
                    url: "/Comm/ApiAddBlog.ashx",
                    type: "post",
                    async: true,
                    //data: data.field,
                    data: {
                        typeId: $("#typeIdVal").val(),
                        blogTitle: $("#blogTitleVal").val(),
                        blogContent: $("#blogContentVal").val()
                    },
                    success: function (res) {
                        console.log(res);
                        layer.alert(res.msg, {
                            titl: "提示信息"
                        })
                        $("#articleForm")[0].reset();//清空表单数据
                    }
                })
                return false;
            });



        });
    </script>
</body>
</html>
