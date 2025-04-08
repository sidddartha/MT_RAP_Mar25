@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Processor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZMT_SID_M_ATTACH_PROCESSOR as projection on ZMT_SID_M_ATTACH
{
   key TravelId,
   key Id,
   Memo,
   @Semantics.largeObject: {
       mimeType: 'Filetype',
       fileName: 'Filename',
       contentDispositionPreference: #INLINE,
       acceptableMimeTypes: [ 'APPLICATION/PDF' ]
   }
   Attachment,
   Filename,
   @Semantics.mimeType: true
   Filetype,
   LocalCreatedBy,
   LocalCreatedAt,
   LocalLastChangedBy,
   LocalLastChangedAt,
   LastChangedAt,
   /* Associations */
   _Travel: redirected to parent ZMT_SID_TRAVEL_PROCESSOR
}
