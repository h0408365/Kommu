USE [Kommu]
GO
/****** Object:  StoredProcedure [dbo].[ListingVerification_Update]    Script Date: 7/17/2022 14:07:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harold Tran
-- Create date: 01-July-2022
-- Description: Created Procedure
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER PROCEDURE [dbo].[ListingVerification_Update]
					@ListingId int
					, @WiFiDocumentUrl nvarchar(500)
					, @InsuranceDocumentUrl nvarchar(500)
					, @LocationDocumentUrl nvarchar(500)
					, @ApprovedBy int
					, @CreatedBy int
					, @Notes nvarchar(Max)
					, @Id int 

AS

/* --TEST CODE --

DECLARE @Id int = 3

Declare				@ListingId int = 2
					, @WiFiDocumentUrl nvarchar(500) = 'www.WiFiDocumentUrl.com'
					, @InsuranceDocumentUrl nvarchar(500) = 'www.InsuranceDocumentUrl.com'
					, @LocationDocumentUrl nvarchar(500) = 'www.LocationDocumentUrl.com'
					, @ApprovedBy int = 2
					, @CreatedBy int = 2
					, @Notes nvarchar(Max) = 'No notes'

Execute dbo.ListingVerification_Update
					@ListingId
					, @WiFiDocumentUrl
					, @InsuranceDocumentUrl
					, @LocationDocumentUrl
					, @ApprovedBy
					, @CreatedBy
					, @Notes
					, @Id 

SELECT* FROM dbo.ListingVerification
WHERE Id = @Id


*/ --TEST CODE--

BEGIN

DECLARE @datNow datetime2 = GETUTCDATE()

UPDATE dbo.ListingVerification
SET					 
					 [ListingId] = @ListingId
					 , [WiFiDocumentUrl] = @WiFiDocumentUrl
					 , [InsuranceDocumentUrl] = @InsuranceDocumentUrl
					 , [LocationDocumentUrl] = @LocationDocumentUrl
					 , [ApprovedBy] = @ApprovedBy
					 , [CreatedBy] = @CreatedBy
					 , [Notes] = @Notes
					 , [DateModified] = @datNow

WHERE Id = @Id

END