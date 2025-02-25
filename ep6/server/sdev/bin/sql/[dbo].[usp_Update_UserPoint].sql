USE [PS_UserData]
GO
/****** Object:  StoredProcedure [dbo].[usp_Update_UserPoint]    Script Date: 8/23/2023 4:16:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER Proc [dbo].[usp_Update_UserPoint]
@UserUID int,
@UsePoint int

AS

SET NOCOUNT ON

DECLARE 
@UserPoint int

SELECT @UserPoint= ISNULL(Point,0) FROM Users_Master WHERE UserUID=@UserUID
IF( @@ROWCOUNT=0 OR @UserPoint-@UsePoint < 0 )
BEGIN
	UPDATE Users_Master SET Point=0 WHERE UserUID=@UserUID
	RETURN -1
END

UPDATE Users_Master SET Point=ISNULL(Point,0)-@UsePoint WHERE UserUID=@UserUID
IF( @@ERROR<>0 )
BEGIN
	RETURN -1
END

RETURN 1

SET NOCOUNT OFF

