USE [PS_GameData]
GO
/****** Object:  StoredProcedure [dbo].[usp_Read_User_CashPoint_UsersMaster]    Script Date: 8/26/2023 10:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.usp_Read_User_CashPoint_UsersMaster    Script Date: 2008/3/15 下午 05:25:51 ******/

/*==================================================
@author	lenasoft
@date	2006-09-28
@return	
@brief	USERDB曖 Users_Master纔檜綰縑憮 檣蒂 陛螳螞棻.
==================================================*/
ALTER Proc [dbo].[usp_Read_User_CashPoint_UsersMaster]
@CashPoint	int OUTPUT,
@UserUID 	int

AS

SET NOCOUNT ON

SET @CashPoint = 0

SELECT @CashPoint=ISNULL(Point,0) FROM PS_UserData.dbo.Users_Master WHERE UserUID=@UserUID 
IF( @CashPoint < 0 )
BEGIN
	UPDATE PS_UserData.dbo.Users_Master SET Point=0 WHERE UserUID=@UserUID
	SET @CashPoint = 0
END

SET NOCOUNT OFF
