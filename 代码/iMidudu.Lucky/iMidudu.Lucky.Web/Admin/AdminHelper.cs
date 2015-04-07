using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace iMidudu.Lucky.Web.Admin
{
    public class AdminHelper
    {
        //统计大奖总数（奖项1）
        public int TotalAmountOfBigPrize(string ActivityName){
            return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName",new System.Data.SqlClient.SqlParameter("@ActivityName",ActivityName));       
        }
        //统计小奖1总数（奖项2）
        //public int TotalAmountOfBigPrize(string ActivityName)
        //{
        //    return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName", new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName));
        //}
        ////统计大奖总数
        //public int TotalAmountOfBigPrize(string ActivityName)
        //{
        //    return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName", new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName));
        //}
        ////统计大奖总数
        //public int TotalAmountOfBigPrize(string ActivityName)
        //{
        //    return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName", new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName));
        //}
        ////统计大奖总数
        //public int TotalAmountOfBigPrize(string ActivityName)
        //{
        //    return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName", new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName));
        //}
        ////统计大奖总数
        //public int TotalAmountOfBigPrize(string ActivityName)
        //{
        //    return (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select Quantity from Prize , Activity where Prize.QRCode=Activity.QRCode and ActivityName=@ActivityName", new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName));
        //}

    }
}