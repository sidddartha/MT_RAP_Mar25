@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection Travel - Processort'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZMT_SID_TRAVEL_APPROVER as projection on ZMT_SID_TRAVEL
{
    key TravelId,
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    AgencyName,
    CustomerName,
    Status,
    Criticality,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZMT_SID_BOOKING_APPROVER ,
    _Currency,
    _Customer,
    _OverallStatus
  
}
