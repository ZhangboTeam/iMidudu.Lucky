using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SuuSee.Data;
namespace iMidudu.Lucky.Data
{ 
    public class SystemUserDAO
    {
        public static object FindPasswordByUserName(string UserName)
        {
            return SqlHelper.ExecuteScalarText("select Password from SystemUser where UserName=@UserName",
                new System.Data.SqlClient.SqlParameter("@UserName", UserName));
        }
    }
}
