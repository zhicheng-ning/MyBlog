using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    
    public class AlbumService
    {
        MyBlogDataContext db = new MyBlogDataContext();
        //插入图片
        public void insertPhoto(int _userId,string _photoName,string _photoUrl,DateTime _dateTime)
        {
            photo photoItem = new photo
            {
                userId = _userId,
                photoName = _photoName,
                photoUrl = _photoUrl,
                photoTime=_dateTime
            };
            db.photo.InsertOnSubmit(photoItem);
            db.SubmitChanges();
        }

        // 分页查询
        public List<photo> GetAllPhoto(int _userId,int page,int limit)
        {
            List<photo> photoList = new List<photo>();

            var x=from r in db.photo
                  where r.userId==_userId 
                  select r ;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);

            photoList = res.ToList();
            return photoList; 
        }

        // 获取该用户的相片总数
        public int getPhotoCounts(int _userId)
        {
            List<photo> photos = new List<photo>();
            var x= from r in db.photo
                   where r.userId == _userId
                   select r;
            return x.ToList().Count();
        }
        public string delPhoto(int _photoId)
        {
            var x = from r in db.photo
                    where r.photoId == _photoId
                    select r;
            string pUrl=null;
            foreach (var item in x)
            {
                pUrl = item.photoUrl;
            }
            db.photo.DeleteAllOnSubmit(x);
            db.SubmitChanges();
            return pUrl;//返回被删除图片的url，从而在服务器上对该图片进行删除
        }

        public bool updatePhoto(int _photoId,string _photoName)
        {
            bool flag = false;
            var x = from r in db.photo
                    where r.photoId == _photoId
                    select r;
            if(x!=null)
            {
                foreach (var item in x)
                {
                    item.photoName = _photoName;
                    flag = true;
                }
            }
            db.SubmitChanges();
            return flag;
        }

        //模糊搜索
        public List<photo> searchPhoto(int _userId,string _photoName)
        {
            string pattern = string.Format("%{0}%", _photoName);

            var x = from r in db.photo
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.photoName, pattern)&&r.userId==_userId
                    select r;
            return x.ToList();
        }

    }

    
}
