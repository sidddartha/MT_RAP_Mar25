@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Child'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMT_SID_BOOKING as select from /dmo/booking_m
---for BO
composition[0..*] of ZMT_SID_BOOKSUPPL as _BookingSupplement
association to parent ZMT_SID_TRAVEL as _Travel on
   $projection.TravelId = _Travel.TravelId

association[1..1] to /DMO/I_Customer as _Customer on
   $projection.CustomerId = _Customer.CustomerID
association[1..1] to /DMO/I_Carrier as _Carrier on
   $projection.CarrierId = _Carrier.AirlineID
association[1..1] to /DMO/I_Connection as _Connection on
   $projection.CarrierId = _Connection.AirlineID and
   $projection.ConnectionId = _Connection.ConnectionID
association[1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on
   $projection.BookingStatus = _BookingStatus.BookingStatus   
{
   key travel_id as TravelId,
   key booking_id as BookingId,
   booking_date as BookingDate,
   @Consumption.valueHelpDefinition: [
   { entity: {
               name: '/DMO/I_Customer',
               element: 'CustomerID'
       } }
   ]
   
   customer_id as CustomerId,
   @Consumption.valueHelpDefinition: [
   { entity: {
               name: '/DMO/I_Carrier',
               element: 'AirlineID'
       } }
   ]   
   carrier_id as CarrierId,
   @Consumption.valueHelpDefinition: [
   { entity: {
               name: '/DMO/I_Connection',
               element: 'ConnectionID'
       },additionalBinding: [{
           element: 'AirlineID', localElement: 'CarrierId'
       }] }
   ]   
   connection_id as ConnectionId,
   @Consumption.valueHelpDefinition: [
   { entity: {
               name: '/DMO/I_Flight',
               element: 'CustomerID'
       },additionalBinding: [{
           element: 'AirlineID', localElement: 'CarrierId'
       },{
           element: 'ConnectionID', localElement: 'ConnectionId'
       }] }
   ]   
   flight_date as FlightDate,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   flight_price as FlightPrice,
   currency_code as CurrencyCode,
   @Consumption.valueHelpDefinition: [
   { entity: {
               name: '/DMO/I_Booking_Status_VH',
               element: 'BookingStatus'
       } }
   ]
   
   booking_status as BookingStatus,
   @Semantics.systemDateTime.lastChangedAt: true
   last_changed_at as LastChangedAt,
   /*Expose associations*/
   _Customer,
   _Carrier,
   _Connection,
   _BookingStatus,
   _Travel,
   _BookingSupplement
   
}
