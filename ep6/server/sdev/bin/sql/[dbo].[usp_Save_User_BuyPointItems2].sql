USE [PS_GameData]
GO
/****** Object:  StoredProcedure [dbo].[usp_Save_User_BuyPointItems2]    Script Date: 8/26/2023 10:54:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Proc [dbo].[usp_Save_User_BuyPointItems2]

@UserUID int,
@CharID int,
@UsePoint int,
@ProductCode varchar(20),
@UseDate datetime

AS

SET NOCOUNT ON
--SET XACT_ABORT ON

DECLARE @UseType 	int
DECLARE @Ret 		int
DECLARE @RemainPoint  	int
DECLARE @OrderNumber 	int

SET @Ret = 0

SET @UseType = 1 -- ??

BEGIN DISTRIBUTED TRANSACTION

/*========================================
??? ??
??? ?? ?? ?? UID ? ?? ?? UID? ??? ???? ???.
procRequestOrderProductByGame

???? UID       @buyClientUserNumber               BIGINT
???? UID       @receiveClientUserNumber           BIGINT
?????         @itemCode                          VARCHAR(50)
?? ??          @resultCode                        SMALLINT           	OUTPUT
?? ? ??       @cashBalanceAfterOrder             INT                      	OUTPUT
????	   @orderNumber			      INT			OUTPUT

resultCode
0            ??
1            ????
2            ?? ??? ???? ??
3            ?? ???? ???? ??
5            DB??
6            ????
=========================================*/
EXEC @Ret = PS_UserData.dbo.usp_Update_UserPoint @UserUID, @UsePoint
IF( @Ret < 0 )
BEGIN  
	INSERT INTO PointErrorLog(UserUID, CharID, ProductCode, Ret, ErrDate) 	
	VALUES(@UserUID, @CharID, @ProductCode, @Ret, @UseDate)
	GOTO ERROR
END
---------------------------------------------

-- ??? ?? ??
SET @RemainPoint = (SELECT Point FROM PS_UserData.dbo.Users_Master WHERE UserUID=@UserUID)
INSERT INTO PointLog(UserUID,CharID,UsePoint,ProductCode,TargetName,UseDate,UseType,RemainPoint,OrderNumber)
VALUES(@UserUID,@CharID,@UsePoint,@ProductCode,NULL,@UseDate,@UseType,@RemainPoint,@OrderNumber)

IF( @@ERROR<>0)
BEGIN
	GOTO ERROR
END

COMMIT TRAN
RETURN 1

ERROR:
ROLLBACK TRAN
RETURN -1


SET XACT_ABORT OFF
SET NOCOUNT OFF