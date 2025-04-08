@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Fact'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #FACT
define view entity ZI_SID_AOC_SALES as select from zsid_aoc_sd_hdr  as hdr
association[1..*] to zsid_aoc_so_item as _Items on
$projection.OrderId = _Items.order_id
{
   key hdr.order_id as OrderId,
   hdr.order_no as OrderNo,
   hdr.buyer as Buyer,
   hdr.created_by as CreatedBy,
   hdr.created_on as CreatedOn,
   ---exposed association - read data at Runtime
   _Items   
}
