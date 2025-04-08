@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Analytic'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
define view entity ZC_SID_AOC_SALES_ANA as select from ZI_SID_AOC_SALES_CUBE
{
   @AnalyticsDetails.query.axis: #ROWS
   key CompanyName,
   @AnalyticsDetails.query.axis: #ROWS
   key Country,
   @AnalyticsDetails.query.axis: #COLUMNS
   GrossAmount,
   @Consumption.filter.selectionType: #SINGLE
   CurrencyCode,
   @AnalyticsDetails.query.axis: #COLUMNS
   Quantity,
   @Consumption.filter.selectionType: #SINGLE
   UnitOfMeasure
}
