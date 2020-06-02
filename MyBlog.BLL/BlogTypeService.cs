using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    public class BlogTypeService
    {
        MyBlogDataContext db = new MyBlogDataContext();
        //插入博客类别
        /*public void insertBlogType(string _typeName, string _typeInfo)
        {
            blogType typeItem = new blogType
            {
                typeName = _typeName,
                typeInfo = _typeInfo
            };
            db.blogType.InsertOnSubmit(typeItem);
            db.SubmitChanges();
        }*/

        // 分页查询博客类别
        public List<blogType> GetAllBlogType(int page, int limit)
        {
            List<blogType> blogTypeList = new List<blogType>();

            var x = from r in db.blogType
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);

            blogTypeList = res.ToList();
            return blogTypeList;
        }

        // 获取博客类别总数
        public int getBlogTypeCounts()
        {
            var x = from r in db.blogType
                    select r;
            return x.ToList().Count();
        }
        
        //删除博客类别
        /*public void delBlogType(int _typeId)
        {
            var x = from r in db.blogType
                    where r.typeId == _typeId
                    select r;
            db.blogType.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }*/

        //更新博客类别
        /*public bool updateBlogType(int _typeId, string _typrName,string _typeInfo)
        {
            bool flag = false;
            var x = from r in db.blogType
                    where r.typeId == _typeId
                    select r;
            if (x != null)
            {
                foreach (var item in x)
                {
                    item.typeName=_typrName;
                    item.typeInfo = _typeInfo;
                    flag = true;
                }
            }
            db.SubmitChanges();
            return flag;
        }*/

        //模糊搜索博客类别
        public List<blogType> searchBlogType(string _typeNameOrInfo)
        {
            string pattern = string.Format("%{0}%", _typeNameOrInfo);

            var x = from r in db.blogType
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.typeName, pattern) 
                    || System.Data.Linq.SqlClient.SqlMethods.Like(r.typeInfo, pattern)
                    select r;
            return x.ToList();
        }

    }
}
