using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iMidudu.Lucky.Data;

namespace iMidudu.Lucky.Biz
{
    public class SystemUserBiz
    {
        public static bool Login(string UserName,string Password)
        {
            if (string.IsNullOrEmpty(UserName) || string.IsNullOrEmpty(Password))
            {
                throw new Exception("用户名或密码为空");
            }
            var userPassword = SystemUserDAO.FindPasswordByUserName(UserName);
            if (userPassword == null)// 没有该用户
            {
                throw new Exception("没有该用户");
            }
            return userPassword.ToString() == Password;
        }
    }
}
