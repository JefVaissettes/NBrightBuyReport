SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_ProductXML]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_ProductXML]
END
GO

CREATE VIEW [dbo].[vw_NBS_ProductXML]
AS
SELECT nbs1.[ItemId] as [ProductId],
	  nbs2.[ItemId] as [LangId],
	  nbs2.[ParentItemId],
      nbs1.[PortalId],
      nbs1.[ModuleId],
      nbs1.[TypeCode],
      nbs1.[XMLData],
	  nbs2.[XMLData] as [XMLLang],
      nbs1.[GUIDKey],
      nbs1.[ModifiedDate],      
      nbs2.[Lang] as [Language]
  FROM [dbo].[NBrightBuy] as nbs1
  inner join [dbo].[NBrightBuy] as nbs2 on nbs1.ItemId = nbs2.ParentItemId and nbs2.TypeCode = 'PRDLANG'
  where nbs1.TypeCode = 'PRD'

GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Products]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Products]
END
GO

CREATE VIEW [dbo].[vw_NBS_Products]
AS
SELECT [ProductId],
      [ParentItemId],
      [LangId],
      [PortalId],
      [TypeCode],
	  nbslang.value('(txtproductname)[1]','nvarchar(50)') as ProductName,
	  nbslang.value('(txtsummary)[1]','nvarchar(50)') as ProductSummary,
	  nbslang.value('(txtseoname)[1]','nvarchar(50)') as SeoName,
	  nbslang.value('(txtseopagetitle)[1]','nvarchar(50)') as SeoPageTitle,
	  nbslang.value('(txttagwords)[1]','nvarchar(50)') as TagWords,
	  nbslang.value('(manufacturer)[1]','nvarchar(50)') as Manufacturer,
	  nbslang.value('(extrafield)[1]','nvarchar(50)') as Extrafield,
      [GUIDKey],
      [ModifiedDate],
      [Language],
	  nbs.value('(textbox/txtproductref)[1]','nvarchar(50)') as TextPrdRef,
	  nbs.value('(checkbox/chkishidden)[1]','nvarchar(50)') as Prdishidden,
	  nbs.value('(checkbox/chkdisable)[1]','nvarchar(50)') as Prddisable,
	  nbs.value('(checkbox/chkfileupload)[1]','nvarchar(50)') as Prdfileupload,
	  nbs.value('(importref)[1]','nvarchar(50)') as ImportRef,	  	  
	  CASE ISNUMERIC(nbs.value('(calcfromprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfromprice)[1]','decimal(10,2)')  ELSE 0 END as Calcfromprice,
	  CASE ISNUMERIC(nbs.value('(calcsaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsaleprice)[1]','decimal(10,2)')  ELSE 0 END as Calcsaleprice,
	  CASE ISNUMERIC(nbs.value('(calcfrombulkprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrombulkprice)[1]','decimal(10,2)')  ELSE 0 END as Calcfrombulkprice,
	  CASE ISNUMERIC(nbs.value('(calcsalebulkprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalebulkprice)[1]','decimal(10,2)')  ELSE 0 END as Calcsalebulkprice,
	  CASE ISNUMERIC(nbs.value('(calcdealerfromprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerfromprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerfromprice,
	  CASE ISNUMERIC(nbs.value('(calcdealersaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealersaleprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealersaleprice,
	  CASE ISNUMERIC(nbs.value('(calcfrompriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrompriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcfrompriceunit,
	  CASE ISNUMERIC(nbs.value('(calcsalepriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalepriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcsalepriceunit,
	  CASE ISNUMERIC(nbs.value('(calcfrombulkpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrombulkpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcfrombulkpriceunit,
	  CASE ISNUMERIC(nbs.value('(calcsalebulkpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalebulkpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcsalebulkpriceunit,
	  CASE ISNUMERIC(nbs.value('(calcdealerfrompriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerfrompriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerfrompriceunit,
	  CASE ISNUMERIC(nbs.value('(calcdealersalepriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealersalepriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealersalepriceunit,
	  CASE ISNUMERIC(nbs.value('(calchighunitprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calchighunitprice)[1]','decimal(10,2)')  ELSE 0 END as Calchighunitprice,
	  CASE ISNUMERIC(nbs.value('(calcbestprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestprice)[1]','decimal(10,2)')  ELSE 0 END as Calcbestprice,
	  CASE ISNUMERIC(nbs.value('(calcbestpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceunit,
	  CASE ISNUMERIC(nbs.value('(calcdealerbestprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerbestprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerbestprice,
	  CASE ISNUMERIC(nbs.value('(calcdealerbestpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerbestpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerbestpriceunit,
	  CASE ISNUMERIC(nbs.value('(calcbestpriceall)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceall)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceall,
	  CASE ISNUMERIC(nbs.value('(calcbestpriceallunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceallunit)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceallunit
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/textbox') AS Tblang (nbslang)

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Product_Docs]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Product_Docs]
END
GO

CREATE VIEW [dbo].[vw_NBS_Product_Docs]
AS
SELECT [ProductId],
	  [PortalId],
      nbslang.value('(textbox/txtdocdesc)[1]','nvarchar(max)') as DocDesc,
	  nbslang.value('(textbox/txttitle)[1]','nvarchar(max)') as DocTitle,
	  nbs.value('(hidden/fileext)[1]','nvarchar(max)') as FileExt,
	  nbs.value('(hidden/filepath)[1]','nvarchar(max)') as Filepath,
	  nbs.value('(hidden/filename)[1]','nvarchar(max)') as NameofFile,
	  nbs.value('(hidden/filerelpath)[1]','nvarchar(max)') as Filerelpath,	  
	  nbs.value('(textbox/txtfilename)[1]','nvarchar(max)') as TextFileName,
	  nbs.value('(checkbox/chkishidden)[1]','nvarchar(max)') as ChkisHidden,
	  nbs.value('(checkbox/chkpurchase)[1]','nvarchar(max)') as Chkpurchase,			  	
      [Language]
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml/docs/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/docs/genxml') AS Tblang (nbslang)

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Product_Images]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Product_Images]
END
GO

CREATE VIEW [dbo].[vw_NBS_Product_Images]
As
SELECT [ProductId],
      nbslang.value('(textbox/txtimagedesc)[1]','nvarchar(max)') as ImageDesc,
      nbs.value('(hidden/imageurl)[1]','nvarchar(max)') as ImageUrl,
	  nbs.value('(hidden/imagepath)[1]','nvarchar(max)') as ImagePath,
	  nbs.value('(checkbox/chkhidden)[1]','nvarchar(max)') as ImageHidden,
      [Language]
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml/imgs/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/imgs/genxml') AS Tblang (nbslang)

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Product_Models]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Product_Models]
END
GO


  CREATE VIEW [dbo].[vw_NBS_Product_Models]
  AS
  SELECT 
	  [ProductId],
	  [PortalId],	  
      nbs.value('(hidden/modelid)[1]','nvarchar(50)') as ModelId,
	  nbs.value('(textbox/txtqtyminstock)[1]','nvarchar(max)') as ModelQtyMinStock,
      nbs.value('(textbox/txtmodelref)[1]','nvarchar(max)') as ModelRef,
	  CASE ISNUMERIC(nbs.value('(textbox/txtunitcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(textbox/txtunitcost)[1]','decimal(10,2)')  ELSE 0 END as [Price],
	  CASE ISNUMERIC(nbs.value('(textbox/txtsaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(textbox/txtsaleprice)[1]','decimal(10,2)')  ELSE 0 END as [SalePrice],
	  nbs.value('(textbox/txtbarcode)[1]','nvarchar(max)') as BarCode,
	  nbs.value('(textbox/txtqtyremaining)[1]','nvarchar(max)') as QtyRemaining,
	  nbs.value('(textbox/txtqtystockset)[1]','nvarchar(max)') as QtyStockSet,
	  CASE ISNUMERIC(nbs.value('(textbox/txtpurchasecost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(textbox/txtpurchasecost)[1]','decimal(10,2)')  ELSE 0 END as [PurchaseCost],
	  nbs.value('(textbox/weight)[1]','nvarchar(max)') as Weight,
	  nbs.value('(textbox/depth)[1]','nvarchar(max)') as Depth,
	  nbs.value('(textbox/width)[1]','nvarchar(max)') as Width,
	  nbs.value('(textbox/height)[1]','nvarchar(max)') as Height,
	  nbs.value('(textbox/unit)[1]','nvarchar(max)') as Unit,
	  nbs.value('(textbox/delay)[1]','nvarchar(max)') as Delay,
	  CASE ISNUMERIC(nbs.value('(textbox/txtdealersale)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(textbox/txtdealersale)[1]','decimal(10,2)')  ELSE 0 END as Txtdealersale,
	  nbs.value('(textbox/unitqty)[1]','nvarchar(max)') as UnitQty,
	  nbs.value('(checkbox/chkstockon)[1]','nvarchar(max)') as Chkstockon,
	  nbs.value('(checkbox/chkishidden)[1]','nvarchar(max)') as Chkishidden,
	  nbs.value('(checkbox/chkdeleted)[1]','nvarchar(max)') as Chkdeleted,
	  nbs.value('(checkbox/chkdealeronly)[1]','nvarchar(max)') as Chkdealeronly,
	  nbs.value('(checkbox/chkdisablesale)[1]','nvarchar(max)') as Chkdisablesale,
	  nbs.value('(checkbox/chkdisabledealer)[1]','nvarchar(max)') as Chkdisabledealer,
      nbs.value('(dropdownlist/modelstatus)[1]','nvarchar(50)') as Modelstatus,
      nbs.value('(dropdownlist/taxrate)[1]','nvarchar(50)') as ModelsTaxRate,
	  nbslang.value('(textbox/txtmodelname)[1]','nvarchar(50)') as ModelsName,
      [Language]
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml/models/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/models/genxml') AS TblLang (nbslang)

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Product_Options]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Product_Options]
END
GO


CREATE VIEW [dbo].[vw_NBS_Product_Options]
AS
SELECT [ProductId],
	  [PortalId],	
	  nbs.value('(hidden/optionid)[1]','nvarchar(50)') as OptionId,
	  nbslang.value('(txtoptiondesc)[1]','nvarchar(50)') as OptionDesc,
      [Language]
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml/options/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/options/genxml/textbox') AS Tblang (nbslang)

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Product_Options_Values]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Product_Options_Values]
END
GO

CREATE VIEW [dbo].[vw_NBS_Product_Options_Values]
AS
SELECT  [ProductId],
	   [PortalId],
		nbs.value('(hidden/optionid)[1]','nvarchar(50)') as OptionId,
		nbslang.value('(txtoptionvaluedesc)[1]','nvarchar(50)') as OptionsValuesDesc,
		nbs.value('(hidden/optionvalueid)[1]','nvarchar(50)') as OptionValuesId,
	    CASE ISNUMERIC(nbs.value('(textbox/txtaddedcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(textbox/txtaddedcost)[1]','decimal(10,2)')  ELSE 0 END as AddedCost,
		[Language]
  FROM [dbo].[vw_NBS_ProductXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml/optionvalues/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/optionvalues/genxml/textbox') AS Tblang (nbslang)

GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Orders]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Orders]
END
GO
                                                                    
  CREATE VIEW [dbo].[vw_NBS_Orders]
  AS
  SELECT 
	  [ItemId] as [OrderId]
	  ,[PortalId]
      ,[ModuleId]
      ,[TypeCode]
      ,[GUIDKey]
      ,[ModifiedDate]
      ,[TextData]
      ,[XrefItemId]
      ,[ParentItemId]
      ,[UserId]
      ,[LegacyItemId]
      ,nbs.value('(createddate)[1]','datetime') as CreatedDate
      ,nbs.value('(ordernumber)[1]','nvarchar(50)') as OrderNumber
      ,nbs.value('(paymentproviderkey)[1]','nvarchar(50)') as PaymentProviderKey
      ,nbs.value('(dropdownlist/orderstatus)[1]','nvarchar(50)') as OrderStatus
	  ,nbs.value('(carteditmode)[1]','nvarchar(max)') as CarteditMode
	  ,nbs.value('(clientmode)[1]','nvarchar(max)') as ClientMode
	  ,nbs.value('(clientdisplayname)[1]','nvarchar(max)') as ClientDisplayName
	  ,nbs.value('(lang)[1]','nvarchar(max)') as Lang
	  ,nbs.value('(clientlang)[1]','nvarchar(max)') as ClientLang
	  ,nbs.value('(productrefs)[1]','nvarchar(max)') as ProductRefs
	  ,nbs.value('(totalqty)[1]','nvarchar(max)') as TotalQty
	  ,nbs.value('(totalweight)[1]','nvarchar(max)') as TotalWeight
	  ,CASE ISNUMERIC(nbs.value('(subtotalcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(subtotalcost)[1]','decimal(10,2)')  ELSE 0 END as [SubtotalCost]
	  ,CASE ISNUMERIC(nbs.value('(subtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(subtotal)[1]','decimal(10,2)')  ELSE 0 END as [SubTotal]
	  ,CASE ISNUMERIC(nbs.value('(appliedsubtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedsubtotal)[1]','decimal(10,2)')  ELSE 0 END as [AppliedSubtotal]
	  ,CASE ISNUMERIC(nbs.value('(discountstatus)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(discountstatus)[1]','decimal(10,2)')  ELSE 0 END as DiscountStatus
	  ,CASE ISNUMERIC(nbs.value('(voucherdiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(voucherdiscount)[1]','decimal(10,2)')  ELSE 0 END as VoucherDiscount
	  ,CASE ISNUMERIC(nbs.value('(applieddiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(applieddiscount)[1]','decimal(10,2)')  ELSE 0 END as AppliedDiscount
	  ,CASE ISNUMERIC(nbs.value('(totaldealerbonus)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldealerbonus)[1]','decimal(10,2)')  ELSE 0 END as TotalDealerBonus
	  ,CASE ISNUMERIC(nbs.value('(totaldiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldiscount)[1]','decimal(10,2)')  ELSE 0 END as TotalDiscount
	  ,CASE ISNUMERIC(nbs.value('(totalsalediscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totalsalediscount)[1]','decimal(10,2)')  ELSE 0 END as TotalSaleDiscount
	  ,CASE ISNUMERIC(nbs.value('(taxcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(taxcost)[1]','decimal(10,2)')  ELSE 0 END as Taxcost
	  ,CASE ISNUMERIC(nbs.value('(appliedtax)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedtax)[1]','decimal(10,2)')  ELSE 0 END as Appliedtax	  
	  ,CASE ISNUMERIC(nbs.value('(total)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(total)[1]','decimal(10,2)')  ELSE 0 END as Total
	  ,CASE ISNUMERIC(nbs.value('(appliedtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedtotal)[1]','decimal(10,2)')  ELSE 0 END as AppliedTotal
	  ,nbs.value('(currentcartstage)[1]','nvarchar(max)') as CurrentcartStage
	  ,CASE ISNUMERIC(nbs.value('(shippingcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(shippingcost)[1]','decimal(10,2)')  ELSE 0 END as ShippingCost
	  ,CASE ISNUMERIC(nbs.value('(shippingdealercost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(shippingdealercost)[1]','decimal(10,2)')  ELSE 0 END as ShippingDealerCost
	  ,CASE ISNUMERIC(nbs.value('(appliedshipping)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedshipping)[1]','decimal(10,2)')  ELSE 0 END as AppliedShipping
	  ,nbs.value('(shippingproductcode)[1]','nvarchar(max)') as ShippingProductCode
	  ,nbs.value('(pickuppointref)[1]','nvarchar(max)') as PickuppointRef
	  ,nbs.value('(pickuppointaddr)[1]','nvarchar(max)') as PickuppointAddr
	  ,nbs.value('(isvalidated)[1]','nvarchar(max)') as IsValidated
	  ,nbs.value('(billaddress/genxml/textbox/firstname)[1]','nvarchar(max)') as BAdFirstName
	  ,nbs.value('(billaddress/genxml/textbox/lastname)[1]','nvarchar(max)') as BAdLastName
	  ,nbs.value('(billaddress/genxml/textbox/telephone)[1]','nvarchar(max)') as BAdTelephone
	  ,nbs.value('(billaddress/genxml/textbox/email)[1]','nvarchar(max)') as BAdEmail
	  ,nbs.value('(billaddress/genxml/textbox/company)[1]','nvarchar(max)') as BAdCompany
	  ,nbs.value('(billaddress/genxml/textbox/unit)[1]','nvarchar(max)') as BAdUnit
	  ,nbs.value('(billaddress/genxml/textbox/street)[1]','nvarchar(max)') as BAdStreet
	  ,nbs.value('(billaddress/genxml/textbox/city)[1]','nvarchar(max)') as BAdCity
	  ,nbs.value('(billaddress/genxml/textbox/postalcode)[1]','nvarchar(max)') as BAdPostalCode
	  ,nbs.value('(billaddress/genxml/dropdownlist/selectaddress/@selectedtext)[1]','nvarchar(max)') as BAdAddress
	  ,nbs.value('(billaddress/genxml/dropdownlist/country/@selectedtext)[1]','nvarchar(max)') as BAdCountry
	  ,nbs.value('(billaddress/genxml/dropdownlist/region/@selectedtext)[1]','nvarchar(max)') as BAdRegion
	  ,nbs.value('(shipaddress/genxml/textbox/firstname)[1]','nvarchar(max)') as ShipAdFirstName
	  ,nbs.value('(shipaddress/genxml/textbox/lastname)[1]','nvarchar(max)') as ShipAdLastName
	  ,nbs.value('(shipaddress/genxml/textbox/telephone)[1]','nvarchar(max)') as ShipAdTelephone
	  ,nbs.value('(shipaddress/genxml/textbox/email)[1]','nvarchar(max)') as ShipAdEmail
	  ,nbs.value('(shipaddress/genxml/textbox/company)[1]','nvarchar(max)') as ShipAdCompany
	  ,nbs.value('(shipaddress/genxml/textbox/unit)[1]','nvarchar(max)') as ShipAdUnit
	  ,nbs.value('(shipaddress/genxml/textbox/street)[1]','nvarchar(max)') as ShipAdStreet
	  ,nbs.value('(shipaddress/genxml/textbox/city)[1]','nvarchar(max)') as ShipAdCity
	  ,nbs.value('(shipaddress/genxml/textbox/postalcode)[1]','nvarchar(max)') as ShipAdPostalCode
	  ,nbs.value('(shipaddress/genxml/dropdownlist/selectshipaddress/@selectedtext)[1]','nvarchar(max)') as ShipAdAddress
	  ,nbs.value('(shipaddress/genxml/dropdownlist/country/@selectedtext)[1]','nvarchar(max)') as ShipAdCountry
	  ,nbs.value('(shipaddress/genxml/dropdownlist/region/@selectedtext)[1]','nvarchar(max)') as ShipAdRegion
	  ,nbs.value('(extrainfo/genxml/hidden/shippingproductcode)[1]','nvarchar(max)') as ShipProductCode
	  ,nbs.value('(extrainfo/genxml/hidden/pickuppointref)[1]','nvarchar(max)') as ShipPickuppointRef
	  ,nbs.value('(extrainfo/genxml/hidden/shippingdisplayanme)[1]','nvarchar(max)') as ShipDisplayanme
	  ,nbs.value('(extrainfo/genxml/textbox/extramessage)[1]','nvarchar(max)') as Shipextramessage
	  ,nbs.value('(extrainfo/genxml/textbox/promocode)[1]','nvarchar(max)') as Shippromocode
	  ,nbs.value('(extrainfo/genxml/textbox/taxnumber)[1]','nvarchar(max)') as ShipTaxnumber
	  ,nbs.value('(extrainfo/genxml/textbox/cartemailaddress)[1]','nvarchar(max)') as Shipcartemail
	  ,nbs.value('(extrainfo/genxml/checkbox/chknews)[1]','nvarchar(max)') as Shipchknews
	  ,nbs.value('(extrainfo/genxml/radiobuttonlist/shippingprovider)[1]','nvarchar(max)') as ShippingProvider
	  ,nbs.value('(extrainfo/genxml/radiobuttonlist/rblshippingoptions)[1]','nvarchar(max)') as ShipRblshippingoptions
  FROM [dbo].[NBrightBuy] as nbs
  CROSS APPLY nbs.XMLData.nodes('/genxml') AS Tbl (nbs)
  where TypeCode = 'ORDER'


GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Order_Products]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Order_Products]
END
GO

  CREATE VIEW [dbo].[vw_NBS_Order_Products]
  AS
  SELECT 
	  [ItemId] as [OrderId]
	  ,[PortalId]
      ,[ModuleId]
      ,[TypeCode]
      ,[GUIDKey]
      ,[ModifiedDate]
      ,[TextData]
      ,[XrefItemId]
      ,[ParentItemId]
      ,[LegacyItemId]
      ,nbs.value('(createddate)[1]','datetime') as CreatedDate
      ,nbs.value('(ordernumber)[1]','nvarchar(50)') as OrderNumber
      ,nbs.value('(paymentproviderkey)[1]','nvarchar(50)') as PaymentProviderKey
      ,nbs.value('(dropdownlist/orderstatus)[1]','nvarchar(50)') as OrderStatus
	  ,nbs.value('(carteditmode)[1]','nvarchar(max)') as CarteditMode
	  ,nbs.value('(lang)[1]','nvarchar(max)') as Lang
	  ,nbs.value('(productrefs)[1]','nvarchar(max)') as ProductRefs
	  ,nbs.value('(totalqty)[1]','nvarchar(max)') as TotalQty
	  ,nbs.value('(totalweight)[1]','nvarchar(max)') as TotalWeight
	  ,CASE ISNUMERIC(nbs.value('(subtotalcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(subtotalcost)[1]','decimal(10,2)')  ELSE 0 END as [SubtotalCost]
	  ,CASE ISNUMERIC(nbs.value('(subtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(subtotal)[1]','decimal(10,2)')  ELSE 0 END as [SubTotal]
	  ,CASE ISNUMERIC(nbs.value('(appliedsubtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedsubtotal)[1]','decimal(10,2)')  ELSE 0 END as [AppliedSubtotal]
	  ,CASE ISNUMERIC(nbs.value('(discountstatus)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(discountstatus)[1]','decimal(10,2)')  ELSE 0 END as DiscountStatus
	  ,CASE ISNUMERIC(nbs.value('(voucherdiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(voucherdiscount)[1]','decimal(10,2)')  ELSE 0 END as VoucherDiscount
	  ,CASE ISNUMERIC(nbs.value('(applieddiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(applieddiscount)[1]','decimal(10,2)')  ELSE 0 END as AppliedDiscount
	  ,CASE ISNUMERIC(nbs.value('(totaldealerbonus)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldealerbonus)[1]','decimal(10,2)')  ELSE 0 END as TotalDealerBonus
	  ,CASE ISNUMERIC(nbs.value('(totaldiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldiscount)[1]','decimal(10,2)')  ELSE 0 END as TotalDiscount
	  ,CASE ISNUMERIC(nbs.value('(totalsalediscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totalsalediscount)[1]','decimal(10,2)')  ELSE 0 END as TotalSaleDiscount
	  ,CASE ISNUMERIC(nbs.value('(taxcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(taxcost)[1]','decimal(10,2)')  ELSE 0 END as Taxcost
	  ,CASE ISNUMERIC(nbs.value('(appliedtax)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedtax)[1]','decimal(10,2)')  ELSE 0 END as Appliedtax
	  ,CASE ISNUMERIC(nbs.value('(total)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(total)[1]','decimal(10,2)')  ELSE 0 END as Total
	  ,CASE ISNUMERIC(nbs.value('(appliedtotal)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedtotal)[1]','decimal(10,2)')  ELSE 0 END as AppliedTotal
	  ,nbs.value('(currentcartstage)[1]','nvarchar(max)') as CurrentcartStage
	  ,CASE ISNUMERIC(nbs.value('(shippingcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(shippingcost)[1]','decimal(10,2)')  ELSE 0 END as ShippingCost
	  ,CASE ISNUMERIC(nbs.value('(shippingdealercost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(shippingdealercost)[1]','decimal(10,2)')  ELSE 0 END as ShippingDealerCost
	  ,CASE ISNUMERIC(nbs.value('(appliedshipping)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedshipping)[1]','decimal(10,2)')  ELSE 0 END as AppliedShipping
	  ,nbs.value('(shippingproductcode)[1]','nvarchar(max)') as ShippingProductCode
	  ,nbs.value('(pickuppointref)[1]','nvarchar(max)') as PickuppointRef
	  ,nbs.value('(pickuppointaddr)[1]','nvarchar(max)') as PickuppointAddr
  FROM [dbo].[NBrightBuy] as nbs
  CROSS APPLY nbs.XMLData.nodes('/genxml') AS Tbl (nbs)
  where TypeCode = 'ORDER'

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Order_Audits]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Order_Audits]
END
GO

  CREATE VIEW [dbo].[vw_NBS_Order_Audits]
  AS
  SELECT 
	  [ItemId] as [OrderId]
	  ,[PortalId]
      ,nbs.value('(date)[1]','datetime') as AuditDate
      ,nbs.value('(status)[1]','nvarchar(50)') as AuditStatus
      ,nbs.value('(username)[1]','nvarchar(50)') as AuditUsername
      ,nbs.value('(showtouser)[1]','nvarchar(50)') as AuditShowtouser
	  ,nbs.value('(type)[1]','nvarchar(max)') as AuditType
	  ,nbs.value('(emailsubject)[1]','nvarchar(max)') as AuditEmailsubject
	  ,nbs.value('(msg)[1]','nvarchar(max)') as Auditmsg
  FROM [dbo].[NBrightBuy] as nbs
  CROSS APPLY nbs.XMLData.nodes('/genxml/audit/genxml') AS Tbl (nbs)
  where TypeCode = 'ORDER'


GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Order_Items]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Order_Items]
END
GO

  CREATE VIEW [dbo].[vw_NBS_Order_Items]
  AS
  SELECT 
	  [ItemId] as [OrderId]
	  ,[PortalId]
      ,nbs.value('(productid)[1]','nvarchar(max)') as NBSId
      ,nbs.value('(modelid)[1]','nvarchar(50)') as ModelId
      ,nbs.value('(qty)[1]','nvarchar(50)') as Qty
      ,nbs.value('(productname)[1]','nvarchar(50)') as ProductName
	  ,nbs.value('(summary)[1]','nvarchar(max)') as Summary
	  ,nbs.value('(modelref)[1]','nvarchar(max)') as ModelRef
	  ,nbs.value('(modeldesc)[1]','nvarchar(max)') as ModelDesc
	  ,nbs.value('(modelextra)[1]','nvarchar(max)') as ModelExtra
	  ,CASE ISNUMERIC(nbs.value('(unitcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(unitcost)[1]','decimal(10,2)')  ELSE 0 END as [UnitCost]
	  ,CASE ISNUMERIC(nbs.value('(dealercost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(dealercost)[1]','decimal(10,2)')  ELSE 0 END as [DealerCost]
	  ,nbs.value('(taxratecode)[1]','nvarchar(max)') as TaxRateCode
	  ,CASE ISNUMERIC(nbs.value('(saleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(saleprice)[1]','decimal(10,2)')  ELSE 0 END as [SalePrice]
	  ,CASE ISNUMERIC(nbs.value('(basecost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(basecost)[1]','decimal(10,2)')  ELSE 0 END as [BaseCost]
	  ,nbs.value('(isdealer)[1]','nvarchar(max)') as IsDealer
	  ,nbs.value('(options/option/optid)[1]','nvarchar(max)') as OptionId
	  ,nbs.value('(options/option/optvalueid)[1]','nvarchar(max)') as OptValueId
	  ,nbs.value('(options/option/optname)[1]','nvarchar(max)') as OptName
	  ,CASE ISNUMERIC(nbs.value('(options/option/optvalcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(options/option/optvalcost)[1]','decimal(10,2)')  ELSE 0 END as [OptvalCost]
	  ,nbs.value('(options/option/optvaltext)[1]','nvarchar(max)') as OptValText
	  ,nbs.value('(options/option/optvaltotal)[1]','nvarchar(max)') as OptValTotal
	  ,nbs.value('(itemcode)[1]','nvarchar(max)') as ItemCode
	  ,CASE ISNUMERIC(nbs.value('(promodiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(promodiscount)[1]','decimal(10,2)')  ELSE 0 END as [PromoDiscount]
	  ,nbs.value('(totalweight)[1]','nvarchar(max)') as TotalWeight
	  ,CASE ISNUMERIC(nbs.value('(totalcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totalcost)[1]','decimal(10,2)')  ELSE 0 END as [TotalCost]
	  ,CASE ISNUMERIC(nbs.value('(totaldealerbonus)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldealerbonus)[1]','decimal(10,2)')  ELSE 0 END as [TotalDealerBonus]
	  ,CASE ISNUMERIC(nbs.value('(totaldiscount)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(totaldiscount)[1]','decimal(10,2)')  ELSE 0 END as [TotalDiscount]
	  ,CASE ISNUMERIC(nbs.value('(appliedtotalcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedtotalcost)[1]','decimal(10,2)')  ELSE 0 END as [AppliedTotalCost]
	  ,CASE ISNUMERIC(nbs.value('(appliedcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(appliedcost)[1]','decimal(10,2)')  ELSE 0 END as [AppliedCost]
	  ,CASE ISNUMERIC(nbs.value('(taxcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(taxcost)[1]','decimal(10,2)')  ELSE 0 END as [TaxCost]
	  ,nbs.value('(productxml/genxml/textbox/txtproductref)[1]','nvarchar(max)') as ProductRef
	  ,nbs.value('(productxml/genxml/checkbox/chkishidden)[1]','nvarchar(max)') as PrdIsHidden
	  ,nbs.value('(productxml/genxml/checkbox/chkdisable)[1]','nvarchar(max)') as PrdDisable
	  ,nbs.value('(productxml/genxml/checkbox/chkfileupload)[1]','nvarchar(max)') as PrdFileUpload
	  ,nbs.value('(productxml/genxml/models/genxml/hidden/modelid)[1]','nvarchar(max)') as ModeleId
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/availabledate)[1]','datetime') as AvailableDate
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/txtqtyminstock)[1]','nvarchar(max)') as QtyMinStock
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/txtmodelref)[1]','nvarchar(max)') as ModeleRef
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/models/genxml/textbox/txtunitcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/models/genxml/textbox/txtunitcost)[1]','decimal(10,2)')  ELSE 0 END as [ModelsUnitCost]
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/models/genxml/textbox/txtsaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/models/genxml/textbox/txtsaleprice)[1]','decimal(10,2)')  ELSE 0 END as [ModelsSalePrice]
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/txtbarcode)[1]','nvarchar(max)') as BarCode
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/txtqtyremaining)[1]','nvarchar(max)') as QtyRemaining
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/txtqtystockset)[1]','nvarchar(max)') as QtyStock
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/models/genxml/textbox/txtdealercost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/models/genxml/textbox/txtdealercost)[1]','decimal(10,2)')  ELSE 0 END as [ModelsDealerCost]
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/models/genxml/textbox/txtpurchasecost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/models/genxml/textbox/txtpurchasecost)[1]','decimal(10,2)')  ELSE 0 END as [PurchaseCost]
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/weight)[1]','nvarchar(max)') as [Weight]
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/depth)[1]','nvarchar(max)') as Depth
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/width)[1]','nvarchar(max)') as Width
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/height)[1]','nvarchar(max)') as Height
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/unit)[1]','nvarchar(max)') as Unit
	  ,nbs.value('(productxml/genxml/models/genxml/textbox/delay)[1]','nvarchar(max)') as [Delay]
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/models/genxml/textbox/txtdealersale)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/models/genxml/textbox/txtdealersale)[1]','decimal(10,2)')  ELSE 0 END as [DealerSale]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkstockon)[1]','nvarchar(max)') as [ChkStockOn]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkishidden)[1]','nvarchar(max)') as [ChkIsHidden]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkdeleted)[1]','nvarchar(max)') as [ChkDeleted]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkdealeronly)[1]','nvarchar(max)') as [ChkDealerOnly]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkdisablesale)[1]','nvarchar(max)') as [ChkDisablesale]
	  ,nbs.value('(productxml/genxml/models/genxml/checkbox/chkdisabledealer)[1]','nvarchar(max)') as [ChkDisableDealer]
	  ,nbs.value('(productxml/genxml/models/genxml/dropdownlist/modelstatus)[1]','nvarchar(max)') as [ModelStatus]
	  ,nbs.value('(productxml/genxml/models/genxml/dropdownlist/taxrate)[1]','nvarchar(max)') as [TaxRate]
	  ,nbs.value('(productxml/genxml/importref)[1]','nvarchar(max)') as ImportRef
	  ,nbs.value('(productxml/genxml/imgs/genxml/hidden/imageurl)[1]','nvarchar(max)') as ImageUrl
	  ,nbs.value('(productxml/genxml/imgs/genxml/hidden/imagepath)[1]','nvarchar(max)') as ImagePath
	  ,nbs.value('(productxml/genxml/imgs/genxml/checkbox/chkhidden)[1]','nvarchar(max)') as Imghidden
	  ,nbs.value('(productxml/genxml/optionvalues/genxml/hidden/optionid)[1]','nvarchar(max)') as OptId
	  ,nbs.value('(productxml/genxml/optionvalues/genxml/hidden/optionvalueid)[1]','nvarchar(max)') as OptionValueId
	  ,CASE ISNUMERIC(nbs.value('(productxml/genxml/optionvalues/genxml/textbox/txtaddedcost)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(productxml/genxml/optionvalues/genxml/textbox/txtaddedcost)[1]','decimal(10,2)')  ELSE 0 END as [AddedCost]
	  ,CASE ISNUMERIC(nbs.value('(calcfromprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfromprice)[1]','decimal(10,2)')  ELSE 0 END as Calcfromprice
	  ,CASE ISNUMERIC(nbs.value('(calcsaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsaleprice)[1]','decimal(10,2)')  ELSE 0 END as Calcsaleprice
	  ,CASE ISNUMERIC(nbs.value('(calcfrombulkprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrombulkprice)[1]','decimal(10,2)')  ELSE 0 END as Calcfrombulkprice
	  ,CASE ISNUMERIC(nbs.value('(calcsalebulkprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalebulkprice)[1]','decimal(10,2)')  ELSE 0 END as Calcsalebulkprice
	  ,CASE ISNUMERIC(nbs.value('(calcdealerfromprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerfromprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerfromprice
	  ,CASE ISNUMERIC(nbs.value('(calcdealersaleprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealersaleprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealersaleprice
	  ,CASE ISNUMERIC(nbs.value('(calcfrompriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrompriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcfrompriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcsalepriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalepriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcsalepriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcfrombulkpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcfrombulkpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcfrombulkpriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcsalebulkpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcsalebulkpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcsalebulkpriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcdealerfrompriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerfrompriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerfrompriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcdealersalepriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealersalepriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealersalepriceunit
	  ,CASE ISNUMERIC(nbs.value('(calchighunitprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calchighunitprice)[1]','decimal(10,2)')  ELSE 0 END as Calchighunitprice
	  ,CASE ISNUMERIC(nbs.value('(calchighdealerunitprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calchighdealerunitprice)[1]','decimal(10,2)')  ELSE 0 END as Calchighdealerunitprice
	  ,CASE ISNUMERIC(nbs.value('(calcbestprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestprice)[1]','decimal(10,2)')  ELSE 0 END as Calcbestprice
	  ,CASE ISNUMERIC(nbs.value('(calcbestpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcdealerbestprice)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerbestprice)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerbestprice
	  ,CASE ISNUMERIC(nbs.value('(calcdealerbestpriceunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcdealerbestpriceunit)[1]','decimal(10,2)')  ELSE 0 END as Calcdealerbestpriceunit
	  ,CASE ISNUMERIC(nbs.value('(calcbestpriceall)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceall)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceall
	  ,CASE ISNUMERIC(nbs.value('(calcbestpriceallunit)[1]','nvarchar(max)')) WHEN 1 THEN nbs.value('(calcbestpriceallunit)[1]','decimal(10,2)')  ELSE 0 END as Calcbestpriceallunit	  
  FROM [dbo].[NBrightBuy] as nbs
  CROSS APPLY nbs.XMLData.nodes('/genxml/items/genxml') AS Tbl (nbs)
  where TypeCode = 'ORDER'


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_CategoryXML]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_CategoryXML]
END
GO

CREATE VIEW [dbo].[vw_NBS_CategoryXML]
  AS SELECT nbs1.[ItemId] as [CatId]
      , nbs2.[ItemId] as [LangId]
      ,nbs1.[PortalId]
      ,nbs1.[TypeCode]
      ,nbs1.[XMLData]
      ,nbs2.[XMLData] as [XMLLang]
      ,nbs2.[Lang] as [Language]
  FROM [dbo].[NBrightBuy] as nbs1
  inner join [dbo].[NBrightBuy] as nbs2 on nbs1.ItemId = nbs2.ParentItemId and nbs2.TypeCode = 'CATEGORYLANG'
  where nbs1.TypeCode = 'CATEGORY' 
  and nbs1.[XmlData].value('(genxml/dropdownlist/ddlgrouptype)[1]','nvarchar(max)') = 'CAT'

GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Categories]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Categories]
END
GO

CREATE VIEW [dbo].[vw_NBS_Categories]

As
SELECT vw_Cat.[CatId]
	  ,vw_Cat.[PortalId]
      ,nbs.value('(hidden/recordsortorder)[1]','nvarchar(max)') as RecordSortOrder
      ,nbs.value('(hidden/imagepath)[1]','nvarchar(max)') as ImagePath
      ,nbs.value('(hidden/imageurl)[1]','nvarchar(max)') as ImageUrl
      ,nbs.value('(textbox/txtcategoryref)[1]','nvarchar(max)') as CatRef
      ,nbs.value('(checkbox/chkishidden)[1]','nvarchar(max)') as IsHidden
      ,nbs.value('(dropdownlist/ddlgrouptype)[1]','nvarchar(max)') as GroupType
      ,nbs.value('(dropdownlist/ddlparentcatid)[1]','nvarchar(max)') as ParentCatId
      ,nbslang.value('(textbox/txtcategoryname)[1]','nvarchar(max)') as CategoryName
      ,nbslang.value('(textbox/txtcategorydesc)[1]','nvarchar(max)') as CategoryDesc
      ,nbslang.value('(textbox/txtseoname)[1]','nvarchar(max)') as Seoname
      ,nbslang.value('(textbox/txtmetadescription)[1]','nvarchar(max)') as Metadescription
      ,nbslang.value('(textbox/txtmetakeywords)[1]','nvarchar(max)') as Metakeywords
      ,nbslang.value('(textbox/txtseopagetitle)[1]','nvarchar(max)') as Seopagetitle
      ,nbslang.value('(edt/message)[1]','nvarchar(max)') as Message
      ,nbslang.value('(textbox/txtcategoryref)[1]','nvarchar(max)') as CategoryRef
      ,vw_Cat.[Language]
  FROM [dbo].[vw_NBS_CategoryXML] as vw_Cat
  CROSS APPLY vw_Cat.XMLData.nodes('/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Cat.XMLLang.nodes('/genxml') AS Tblang (nbslang)
  
  GO
  
  
  
  
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_PropertyXML]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_PropertyXML]
END
GO

CREATE VIEW [dbo].[vw_NBS_PropertyXML]
  AS SELECT nbs1.[ItemId] as [PropId]
      , nbs2.[ItemId] as [LangId]
      ,nbs1.[PortalId]
      ,nbs1.[TypeCode]
      ,nbs1.[XMLData]
      ,nbs2.[XMLData] as [XMLLang]
      ,nbs2.[Lang] as [Language]
  FROM [dbo].[NBrightBuy] as nbs1
  inner join [dbo].[NBrightBuy] as nbs2 on nbs1.ItemId = nbs2.ParentItemId and nbs2.TypeCode = 'CATEGORYLANG'
  where nbs1.TypeCode = 'CATEGORY' 
  and not nbs1.[XmlData].value('(genxml/dropdownlist/ddlgrouptype)[1]','nvarchar(max)') = 'CAT'

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Properties]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Properties]
END
GO

CREATE VIEW [dbo].[vw_NBS_Properties]

As
SELECT vw_Prd.[PropId]
	   ,vw_Prd.[PortalId]
      ,nbs.value('(hidden/recordsortorder)[1]','nvarchar(max)') as RecordSortOrder
      ,nbs.value('(textbox/propertyref)[1]','nvarchar(max)') as PropertyRef
      ,nbs.value('(textbox/txtcategoryref)[1]','nvarchar(max)') as CategoryRef
      ,nbs.value('(checkbox/chkishidden)[1]','nvarchar(max)') as IsHidden
      ,nbs.value('(dropdownlist/ddlgrouptype)[1]','nvarchar(max)') as GroupType
      ,nbs.value('(dropdownlist/ddlparentcatid)[1]','nvarchar(max)') as ParentCatId
      ,nbslang.value('(txtcategoryname)[1]','nvarchar(max)') as CategoryName
      ,vw_Prd.[Language]
  FROM [dbo].[vw_NBS_PropertyXML] as vw_Prd
  CROSS APPLY vw_Prd.XMLData.nodes('/genxml') AS Tbl (nbs)
  CROSS APPLY vw_Prd.XMLLang.nodes('/genxml/textbox') AS Tblang (nbslang)
  
  GO
  
  

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_Userdata]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_Userdata]
END
GO

CREATE VIEW [dbo].[vw_NBS_Userdata]
AS
SELECT [ItemId]
	  ,[PortalId]
      ,[UserId]
      ,[Lang]
      ,nbs.[XMLData].value('(hidden/default)[1]','nvarchar(max)') DefaultAdd
      ,nbs.[XMLData].value('(hidden/index)[1]','nvarchar(max)') [Index]
      ,nbs.[XMLData].value('(textbox/firstname)[1]','nvarchar(max)') [FirstName]
      ,nbs.[XMLData].value('(textbox/lastname)[1]','nvarchar(max)') [LastName]
      ,nbs.[XMLData].value('(textbox/telephone)[1]','nvarchar(max)') [Telephone]
      ,nbs.[XMLData].value('(textbox/email)[1]','nvarchar(max)') [Email]
      ,nbs.[XMLData].value('(textbox/company)[1]','nvarchar(max)') [Company]
      ,nbs.[XMLData].value('(textbox/unit)[1]','nvarchar(max)') [Unit]
      ,nbs.[XMLData].value('(textbox/street)[1]','nvarchar(max)') [Street]
      ,nbs.[XMLData].value('(textbox/city)[1]','nvarchar(max)') [City]
      ,nbs.[XMLData].value('(textbox/postalcode)[1]','nvarchar(max)') [PostalCode]
      ,nbs.[XMLData].value('(textbox/region)[1]','nvarchar(max)') [Region]
      ,nbs.[XMLData].value('(textbox/country)[1]','nvarchar(max)') [Country]
      ,nbs.[XMLData].value('(dropdownlist/selectaddress/@selectedtext)[1]','nvarchar(max)') [SelectedAdress]
      ,nbs.[XMLData].value('(dropdownlist/country/@selectedtext)[1]','nvarchar(max)') [SelectedCountry]
      ,nbs.[XMLData].value('(dropdownlist/region/@selectedtext)[1]','nvarchar(max)') [SelectedRegion]
  FROM [dbo].[NBrightBuy] nb
  CROSS APPLY nb.XMLData.nodes('genxml/address/genxml') nbs (XMLData)
  where TypeCode = 'USERDATA'


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_NBS_UserInfos]'))
BEGIN
	DROP VIEW [dbo].[vw_NBS_UserInfos]
END
GO

CREATE VIEW [dbo].[vw_NBS_UserInfos]
  AS SELECT u.UserId
			,u.City
			,u.Company
			,u.Country
			,u.DefaultAdd
			,u.Email
			,u.FirstName
			,u.[Index]
			,u.LastName
			,u.PostalCode
			,u.Region
			,u.SelectedAdress
			,u.SelectedCountry
			,u.SelectedRegion
			,u.Street
			,u.Telephone
			,u.Unit
			,u2.AutoAssignment
			,u2.BillingFrequency
			,u2.RoleName
			,u2.Username
			,u2.DisplayName
			,u2.IsOwner
			,u2.TrialFee
			,u2.IsPublic
			,u2.CreatedOnDate
			,u2.LastModifiedOnDate
			,u3.PortalId
			,u3.IsSuperUser
			,u3.IsDeleted
			,u3.RefreshRoles
			,u3.LastIPAddress
			,u3.PasswordResetToken
			,u3.PasswordResetExpiration
			,u3.Authorised
  FROM vw_Userdata as u
  inner join vw_UserRoles as u2 on u.UserId = u2.UserID 
  inner join vw_Users as u3 on u2.UserID = u3.UserId

GO






