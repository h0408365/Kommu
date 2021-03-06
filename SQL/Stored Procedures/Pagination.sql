USE [Kommu]
GO
/****** Object:  StoredProcedure [dbo].[ListingVerification_Pagination]    Script Date: 7/17/2022 14:06:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------
-- Author: Harold Tran
-- Create date: 01-July-2022
-- Description: Select All Listing Verification Data in a Paginated Format

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--------------------------------------------------

ALTER PROCEDURE [dbo].[ListingVerification_Pagination]
					@PageIndex int
					,@PageSize int

AS

/* --TEST CODE --

Declare				@PageIndex int = 2
					, @PageSize int = 5

Execute dbo.ListingVerification_Pagination
					@PageIndex
					,@PageSize

					SELECT * FROM dbo.ListingTypes

*/ --TEST CODE--

BEGIN

DECLARE				@offset int = @PageIndex * @PageSize

SELECT				lv.Id
					,lv.WiFiDocumentUrl
					,lv.InsuranceDocumentUrl
					,lv.LocationDocumentUrl
					,u.Id AS ApprovedBy
					,u.Id AS CreatedBy
					,lv.Notes
					,l.Id 
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
	ORDER BY lv.Id
	OFFSET @offset ROWS
	FETCH NEXT @PageSize ROWS ONLY

END