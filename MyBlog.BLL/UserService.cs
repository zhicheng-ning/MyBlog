using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;
using System.Web;


namespace MyBlog.BLL
{
    public class UserService
    {
        MyBlogDataContext db = new MyBlogDataContext();

        //函数： 检查用户登录是否成功
        public int checkLogin(string username, string password)
        {
            user u = (from r in db.user
                          where r.username == username && r.password == password
                          select r).FirstOrDefault();
            //用户名和密码存在 登录成功
            if (u != null)
            {
                return u.userId;
            }
            //用户名或密码错误
            else
            {
                return 0;
            }
        }

        //函数：查询用户名是否重名
        public bool isNameSame(string username)
        {
            user u = (from r in db.user
                            where r.username == username
                            select r).FirstOrDefault();
            //用户不重名
            if (u == null)
            {
                return false;
            }
            //用户重名
            else
            {
                return true;
            }
        }

        //函数：插入用户信息到数据库的user表中
        public void insertUserInfo(string username, string password, string email,string tel)
        {
            user u = new user
            {
                username = username,
                password = password,
                email = email,
                tel = tel
            };
            db.user.InsertOnSubmit(u);  //将记录插入到数据库中
            db.SubmitChanges();  //提交修改
        }

        //函数： 查询邮箱是否存在
        public bool IsEmailExist(string username, string email)
        {
            user u = (from c in db.user
                      where c.username == username && c.email == email
                      select c).FirstOrDefault();
            if (u != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //函数：重置用户的密码 返回重置后的密码
        public string ResetPassword(string username, string email)
        {
            //找到此用户
            user u = (from c in db.user
                                 where c.username == username && c.email == email
                                 select c).First();
            //随机生成的六位数
            string character = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";//要随机的字母
            Random rand = new Random(); //随机类
            string pwd = "";
            for (int i = 0; i < 6; i++) //循环6次，生成6位数字，10位就循环10次
            {
                pwd += character[rand.Next(62)]; //通过索引下标随机

            }
            //Session["pwd"] = pwd;
            //设置用户的密码  为随机的六位数
            u.password = pwd;
            db.SubmitChanges();
            return pwd;
        }

        //函数：通过用户名找到用户id
        public int findUserid(string username)
        {
            user usr = (from u in db.user
                        where u.username == username
                        select u).FirstOrDefault();
            return usr.userId;
        }

        //函数： 修改用户密码为password
        public void changePassword(int userId, string password)
        {
            user _user = (from u in db.user
                                 where u.userId == userId
                                 select u).First();
            _user.password = password;
            db.SubmitChanges();
        }
    }
}
