@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Cube'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #CUBE
define view entity ZI_SID_AOC_SALES_CUBE as select from ZI_SID_AOC_SALES
association[1] to ZSID_AOC_I_BPA as _BusinessPartner on
$projection.Buyer = _BusinessPartner.BpId
association[1] to ZI_SID_AOC_PRODUCT as _Product on
$projection.Product = _Product.ProductId
{
   key ZI_SID_AOC_SALES.OrderId,
   key ZI_SID_AOC_SALES._Items.item_id as ItemId,
   key _BusinessPartner.CompanyName,
   key _BusinessPartner.Country,
   ZI_SID_AOC_SALES.OrderNo,
   ZI_SID_AOC_SALES.Buyer,
   ZI_SID_AOC_SALES.CreatedBy,
   ZI_SID_AOC_SALES.CreatedOn,
   /* Associations */
   ZI_SID_AOC_SALES._Items.product as Product,
   @DefaultAggregation: #SUM
   @Semantics.amount.currencyCode: 'CurrencyCode'
   ZI_SID_AOC_SALES._Items.amount as GrossAmount,
   ZI_SID_AOC_SALES._Items.currency as CurrencyCode,
   @DefaultAggregation: #SUM
   @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
   ZI_SID_AOC_SALES._Items.qty as Quantity,
   ZI_SID_AOC_SALES._Items.uom as UnitOfMeasure,
   _Product,
   _BusinessPartner
   }
