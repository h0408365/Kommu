USE [Kommu]
GO
/****** Object:  StoredProcedure [dbo].[ListingVerification_Select_ByCreatedBy]    Script Date: 7/15/2022 16:06:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------
-- Author: Harold Tran
-- Create date: 01-July-2022
-- Description: Select All Entered Listing Verification Data In A Paginated Format According To User Id/Author
-- Code Review Alan Volny

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--------------------------------------------------

ALTER PROCEDURE [dbo].[ListingVerification_Select_ByCreatedBy]
					@PageIndex int
					,@PageSize int
					,@CreatedBy int

AS

/* --TEST CODE --

Declare				@PageIndex int = 0,
					@PageSize int = 2,
					@CreatedBy int = 53

Execute dbo.ListingVerification_Select_ByCreatedBy
					@PageIndex,
					@PageSize,
					@CreatedBy

SELECT * FROM ListingVerification




*/ --TEST CODE--

BEGIN

DECLARE				@offset int = @PageIndex * @PageSize

SELECT				lv.Id AS ListingVerificationId
					,lv.WiFiDocumentUrl
					,lv.InsuranceDocumentUrl
					,lv.LocationDocumentUrl
					,u.Id AS ApprovedBy
					,u.Id AS CreatedBy
					,lv.Notes 
					,l.Id AS ListingId
					,l.InternalName
					,l.Title
					,l.ShortDescription
					,l.[Description]
					,l.BedRooms
					,l.Baths
					,h.Id AS HousingTypeId
					,h.Name AS HousingTypeName
					,a.Id AS AccessTypeId
					,a.Name AS AccessTypeName
					,a.Description AS AccessTypeDescription
					,l.GuestCapacity
					,l.CostPerNight
					,l.CostPerWeek
					,l.CheckInTime
					,l.CheckOutTime
					,l.DaysAvailable
					,loc.Id AS LocationId
					,loc.Name LocationName
					,l.HasVerifiedOwnerShip
					,l.IsActive
					,HousingImages = (SELECT Url 
						FROM dbo.Files AS f INNER JOIN dbo.ListingImages AS li
						ON li.FileId = f.Id
						WHERE li.ListingId = l.[Id]
						FOR JSON AUTO)
					, TotalCount = COUNT(1) OVER()


	FROM dbo.ListingVerification
		as lv INNER JOIN dbo.Listings as l
		ON lv.ListingId = l.Id
	INNER JOIN dbo.HousingTypes as h
		ON h.Id = l.HousingTypeId
	INNER JOIN dbo.AccessTypes a
		ON a.Id = l.AccessTypeId
	INNER JOIN dbo.LocationTypes as loc
		ON loc.Id = l.LocationId
	INNER JOIN dbo.Users as u
		ON u.Id = l.CreatedBy
	WHERE l.CreatedBy = @CreatedBy
	ORDER BY lv.Id
	OFFSET @offset ROWS
	FETCH NEXT @PageSize ROWS ONLY

END
