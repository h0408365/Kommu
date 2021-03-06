USE [Kommu]
GO
/****** Object:  StoredProcedure [dbo].[ListingVerification_Insert]    Script Date: 7/17/2022 14:06:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harold Tran
-- Create date: 30-June-2022
-- Description: Created Procedure
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER PROCEDURE [dbo].[ListingVerification_Insert]
					@ListingId int
					, @WiFiDocumentUrl nvarchar(500)
					, @InsuranceDocumentUrl nvarchar(500)
					, @LocationDocumentUrl nvarchar(500)
					, @ApprovedBy int
					, @CreatedBy int
					, @Notes nvarchar(Max)
					, @Id int OUTPUT

AS

/* --TEST CODE --

Declare				@ListingId int = 2
					, @WiFiDocumentUrl nvarchar(500) = 'www.TEST.com'
					, @InsuranceDocumentUrl nvarchar(500) = 'www.TEST.com'
					, @LocationDocumentUrl nvarchar(500) = 'www.TEST.com'
					, @ApprovedBy int = 53
					, @CreatedBy int = 53
					, @Notes nvarchar(Max) = 'TEST'
					, @Id int 

Execute dbo.ListingVerification_Insert
					@ListingId
					, @WiFiDocumentUrl
					, @InsuranceDocumentUrl
					, @LocationDocumentUrl
					, @ApprovedBy
					, @CreatedBy
					, @Notes
					, @Id OUTPUT


SELECT *			FROM dbo.Listings
SELECT *			FROM dbo.ListingVerification
SELECT *			FROM dbo.Users

*/ --TEST CODE--

BEGIN

INSERT INTO dbo.ListingVerification
					([ListingId]
					, [WiFiDocumentUrl]
					, [InsuranceDocumentUrl]
					, [LocationDocumentUrl]
					, [ApprovedBy]
					, [CreatedBy]
					, [Notes]
					)

VALUES				(@ListingId
					, @WiFiDocumentUrl
					, @InsuranceDocumentUrl
					, @LocationDocumentUrl
					, @ApprovedBy
					, @CreatedBy
					, @Notes
					)

SET					@Id = SCOPE_IDENTITY();

END