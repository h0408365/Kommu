USE [Kommu]
GO
/****** Object:  StoredProcedure [dbo].[ListingVerification_SelectById]    Script Date: 7/17/2022 14:07:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------
-- Author: Harold Tran
-- Create date: 01-July-2022
-- Description: Select Listing Verification Data By Listing Verification Id

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--------------------------------------------------

ALTER PROCEDURE [dbo].[ListingVerification_SelectById]
					@Id int

AS

/*

DECLARE				@Id int = 1

EXECUTE dbo.ListingVerification_SelectById
					@Id

SELECT * FROM dbo.ListingVerification



*/

BEGIN

SELECT				lv.Id AS ListingVerificationId
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
					--,l.CreatedBy
					--,l.DateCreated
					--,l.DateModified
					,HousingImages = (SELECT Url 
						FROM dbo.Files AS f INNER JOIN dbo.ListingImages AS li
							ON li.FileId = f.Id
							WHERE li.ListingId = l.[Id]
							FOR JSON AUTO)
					, TotalCount = COUNT(1) OVER()


	FROM dbo.ListingVerification
	as lv INNER JOIN dbo.Listings as l
	ON lv.ListingId = l.Id
--INNER JOIN dbo.ListingTypes as lt
--ON lt.Id = lv.ListingId 
	INNER JOIN dbo.HousingTypes as h
	ON h.Id = l.HousingTypeId
	INNER JOIN dbo.AccessTypes a
	ON a.Id = l.AccessTypeId
	INNER JOIN dbo.LocationTypes as loc
	ON loc.Id = l.LocationId
	INNER JOIN dbo.Users as u
	ON u.Id = l.CreatedBy
	WHERE lv.Id = @Id
	ORDER BY lv.Id


END