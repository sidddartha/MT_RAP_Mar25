@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity - Travel'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMT_SID_TRAVEL
  as select from /dmo/travel_m
  composition [0..*] of ZMT_SID_BOOKING          as _Booking
  composition [0..*] of ZMT_SID_M_ATTACH         as _Attachments
  --associations - lose coupling to get dependent data
  association [1]    to /DMO/I_Agency               as _Agency     on $projection.AgencyId = _Agency.AgencyID
  association [1]    to /DMO/I_Customer             as _Customer   on $projection.CustomerId = _Customer.CustomerID
  association [1]    to I_Currency                  as _Currency   on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus
{
  key travel_id          as TravelId,
      @Consumption.valueHelpDefinition: [
      { entity: {
                 name: 'ZMT_SID_AGENCY_ES5',
                 element: 'Agency_Id'
         } }
      ]
      @ObjectModel.text.element: [ 'AgencyName' ]
      agency_id          as AgencyId,
      _Agency.Name       as AgencyName,

      @Consumption.valueHelpDefinition: [
      { entity: {
                 name: '/DMO/I_Customer',
                 element: 'CustomerID'
         } }
      ]
      @ObjectModel.text.element: [ 'CustomerName' ]
      customer_id        as CustomerId,
      _Customer.LastName as CustomerName,
      begin_date         as BeginDate,
      end_date           as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee        as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price        as TotalPrice,
      currency_code      as CurrencyCode,
      case overall_status
       when 'A' then 3
       when 'X' then 1
       else 2
        end as Criticality,      
      description        as Description,
      @Consumption.valueHelpDefinition: [
      { entity: {
                  name: '/DMO/I_Overall_Status_VH',
                  element: 'OverallStatus'
          } }
      ]
      @ObjectModel.text.element: [ 'Status' ]
     overall_status as OverallStatus,
     _OverallStatus._Text.Text as Status,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      //Local ETag Field --> Odata Etag
      last_changed_at    as LastChangedAt,
      /*Expose associations*/
      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _OverallStatus,
      _Attachments
}
