using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    public class MessageService
    {
        MyBlogDataContext db = new MyBlogDataContext();

        //插入留言到message表中
        public void insertIntoMessage(int authorId, int userId, string content)
        {
            DateTime date = Convert.ToDateTime(DateTime.Now);
            message m = new message
            {
                authorId = authorId,
                userId = userId,
                messageContent = content,
                messageTime = date
            };
            db.message.InsertOnSubmit(m); //插入到message表中
            db.SubmitChanges();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="_authorId"></param>
        /// <param name="page"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        // 分页查询留言
        public List<message> GetAllMsg(int _authorId,int page, int limit)
        {
            List<message> msgTypeList = new List<message>();

            var x = from r in db.message
                    where r.authorId== _authorId
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);
            msgTypeList = res.ToList();
            return msgTypeList;
        }

        // 获取留言总数
        public int getMsgCounts(int _authorId)
        {
            var x = from r in db.message
                    where r.authorId== _authorId
                    select r;
            return x.ToList().Count();
        }

        //删除留言
        public void delMsg(int _messageId)
        {
            var x = from r in db.message
                    where r.messageId == _messageId
                    select r;
            db.message.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }

        //模糊搜索博客类别
        public List<message> searchMsg(string _messageContent)
        {
            string pattern = string.Format("%{0}%", _messageContent);

            var x = from r in db.message
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.messageContent, pattern)
                    select r;
            return x.ToList();
        }

    }
}
