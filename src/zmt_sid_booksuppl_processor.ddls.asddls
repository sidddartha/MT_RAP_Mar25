@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZMT_SID_BOOKSUPPL_PROCESSOR as projection on ZMT_SID_BOOKSUPPL
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking :redirected to parent ZMT_SID_BOOKING_PROCESSOR,
    _Product,
    _SupplementText,
    _Travel :redirected to  ZMT_SID_TRAVEL_PROCESSOR
}
