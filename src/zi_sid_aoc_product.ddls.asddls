@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Dimension'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
define view entity ZI_SID_AOC_PRODUCT as select from zsid_aoc_product
{
    key product_id as ProductId,
    name as Name,
    category as Category,
    price as Price,
    currency as Currency,
    discount as Discount
}
