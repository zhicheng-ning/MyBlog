using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;
namespace MyBlog.BLL
{
    public class CommentService
    {
        MyBlogDataContext db = new MyBlogDataContext();

        //函数： 返回blogId为id的博客的评论数
        public int CommentCount(int id)
        {
            return (from c in db.comment where c.blogId == id select c).Count();
        }

        //函数： 插入评论到comment表中
        public void insertIntoComment(int blogId, int userId, string comment)
        {
            //设置一个默认值时间插入
            DateTime time = new DateTime();
            time = Convert.ToDateTime(DateTime.Now);
            comment c = new comment
            {
                blogId = blogId,
                userId = userId,
                comContent = comment,
                comTime = time
            };
            db.comment.InsertOnSubmit(c);  //插入到comment表中
            db.SubmitChanges();  //提交修改
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="_authorId"></param>
        /// <param name="page"></param>
        /// <param name="limit"></param>
        /// <returns></returns>

        // 分页查询评论,_authorId为博主的Id，即查询该博主所有博文的评论
        public List<comment> GetAllComment(int _authorId, int page, int limit)
        {
            List<comment> cmtList = new List<comment>();
            var x = from r in db.comment
                        //直接引用，不用多表连接，但是只返回一个表的数据，若要
                        //返回多个表的数据，则自定义与返回类型相同结构的类，或者使用委托
                    where r.blogId==r.blog.blogId&&r.blog.userId==_authorId
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);
            cmtList = res.ToList();
            return cmtList;
        }

        // 获取评论总数
        public int getCmtCounts(int _authorId)
        {
            var x = from r in db.comment
                    where r.blogId == r.blog.blogId&&r.blog.userId==_authorId
                    select r;
            return x.ToList().Count();
        }

        //删除评论
        public void delMsg(int _commentId)
        {
            var x = from r in db.comment
                    where r.commentId == _commentId
                    select r;
            db.comment.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }

        //模糊搜索评论关键字
        public List<comment> searchCmt(string _comContent)
        {
            string pattern = string.Format("%{0}%", _comContent);

            var x = from r in db.comment
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.comContent, pattern)
                    select r;
            return x.ToList();
        }
    }
}
