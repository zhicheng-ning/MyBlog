using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    public class BlogService
    {
        MyBlogDataContext db = new MyBlogDataContext();
        //插入文章数据
        public void insertBlog(int _userId,int _typeId ,string _blogTitle, string _blogContent, DateTime _dateTime)
        {
            blog blogItem = new blog
            {
                userId=_userId,
                typeId=_typeId,
                blogTitle=_blogTitle,
                blogContent=_blogContent,
                blogTime=_dateTime
            };
            db.blog.InsertOnSubmit(blogItem);
            db.SubmitChanges();
        }

        // 分页查询文章数据
        public List<blog> GetAllBlogs(int _userId, int page, int limit)
        {
            List<blog> blogList = new List<blog>();

            var x = from r in db.blog
                    where r.userId == _userId
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);

            blogList = res.ToList();
            return blogList;
        }

        // 获取该用户所有博客文章总数
        public int getBlogCounts(int _userId)
        {
            List<blog> blogs = new List<blog>();
            var x = from r in db.blog
                    where r.userId == _userId
                    select r;
            blogs = x.ToList();
            return blogs.Count();
        }

        // 删除博客
        public void delBlog(int _blogId)
        {
            var x = from r in db.blog
                    where r.blogId == _blogId
                    select r;
            db.blog.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }
        //更新博客标题和内容
        public bool updateBlog(int _blogId, string _blogTitle,string _blogContent)
        {
            bool flag = false;
            var x = from r in db.blog
                    where r.blogId == _blogId
                    select r;
            if (x != null)
            {
                foreach (var item in x)
                {
                    item.blogTitle = _blogTitle;
                    item.blogContent = _blogContent;
                    flag = true;
                }
            }
            db.SubmitChanges();
            return flag;
        }

        //模糊搜索（在博客标题和博客文章中搜索关键字）
        public List<blog> searchBlog(int _userId, string _blogTitleOrContent)
        {
            string pattern = string.Format("%{0}%", _blogTitleOrContent);

            var x = from r in db.blog
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.blogTitle, pattern) 
                    || System.Data.Linq.SqlClient.SqlMethods.Like(r.blogContent, pattern)
                    select r;
            return x.ToList();
        }

    }
}
