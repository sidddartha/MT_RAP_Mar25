CLASS zcl_mt_sod_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    DATA lv_mode TYPE c VALUE 'R'.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_mt_sod_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    CASE lv_mode.
      WHEN 'R'.
        READ ENTITIES OF zmt_sid_travel
        ENTITY Travel
        FIELDS ( TravelId BeginDate TotalPrice )
        WITH VALUE #( ( TravelId = '00000011' )
         ( TravelId = '00000015' )
          ( TravelId = '89569636' ) )
        RESULT DATA(lt_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_message).
        out->write(
          EXPORTING
            data   = lt_result
*              name   =
*            RECEIVING
*              output =
        ).
        out->write(
          EXPORTING
            data   = lt_failed
*              name   =
*            RECEIVING
*              output =
        ).
        out->write(
         EXPORTING
           data   = lt_message
*              name   =
*            RECEIVING
*              output =
       ).
      WHEN 'C'.
        DATA(lv_description) = 'Anubhav Rocks with RAP'.
        DATA(lv_agency) = '070016'.
        DATA(lv_customer) = '000697'.
        MODIFY ENTITIES OF zmt_sid_travel
        ENTITY Travel
        CREATE FIELDS ( TravelId AgencyId CurrencyCode BeginDate EndDate Description OverallStatus )
        WITH VALUE #(
                        (
                          %cid = 'ANUBHAV'
                          TravelId = '00012347'
                          AgencyId = lv_agency
                          CustomerId = lv_customer
                          BeginDate = cl_abap_context_info=>get_system_date( )
                          EndDate = cl_abap_context_info=>get_system_date( ) + 30
                          Description = lv_description
                          OverallStatus = 'O'
                         )
                        ( %cid = 'EML-1'
                          TravelId = '89569636'
                          AgencyId = lv_agency
                          CustomerId = lv_customer
                          BeginDate = cl_abap_context_info=>get_system_date( )
                          EndDate = cl_abap_context_info=>get_system_date( ) + 30
                          Description = lv_description
                          OverallStatus = 'O'
                         )
                         (
                          %cid = 'ANUBHAV-2'
                          TravelId = '00000010'
                          AgencyId = lv_agency
                          CustomerId = lv_customer
                          BeginDate = cl_abap_context_info=>get_system_date( )
                          EndDate = cl_abap_context_info=>get_system_date( ) + 30
                          Description = lv_description
                          OverallStatus = 'O'
                         )
         )
         MAPPED DATA(lt_mapped)
         FAILED lt_failed
         REPORTED lt_message.
        COMMIT ENTITIES.
        out->write(
         EXPORTING
           data   = lt_mapped
       ).
        out->write(
          EXPORTING
            data   = lt_failed
        ).
      WHEN 'U'.
        lv_description = 'Wow, That was an update'.
        lv_agency = '070032'.
        MODIFY ENTITIES OF zmt_sid_travel
        ENTITY Travel
        UPDATE FIELDS ( AgencyId Description )
        WITH VALUE #(
                        ( TravelId = '00001133'
                          AgencyId = lv_agency
                          Description = lv_description
                         )
                        ( TravelId = '00001135'
                          AgencyId = lv_agency
                          Description = lv_description
                         )
         )
         MAPPED lt_mapped
         FAILED lt_failed
         REPORTED lt_message.
        COMMIT ENTITIES.
        out->write(
         EXPORTING
           data   = lt_mapped
       ).
        out->write(
          EXPORTING
            data   = lt_failed
        ).
      WHEN 'D'.
        MODIFY ENTITIES OF zmt_sid_travel
            ENTITY Travel
            DELETE FROM VALUE #(
                            ( TravelId = '00012347'
                             )
             )
             MAPPED lt_mapped
             FAILED lt_failed
             REPORTED lt_message.
        COMMIT ENTITIES.
        out->write(
         EXPORTING
           data   = lt_mapped
       ).
        out->write(
          EXPORTING
            data   = lt_failed
        ).

ENDCASE.
ENDMETHOD.

ENDCLASS.
