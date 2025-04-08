 CLASS zcl_mt_sid_agency DEFINITION

 PUBLIC
 FINAL
 CREATE PUBLIC .
   PUBLIC SECTION.
     INTERFACES if_rap_query_provider.
   PROTECTED SECTION.
   PRIVATE SECTION.
 ENDCLASS.
 CLASS zcl_mt_sid_agency IMPLEMENTATION.
   METHOD if_rap_query_provider~select.
     DATA:
       lt_business_data TYPE TABLE OF zmt_sid_agency=>tys_z_travel_agency_es_5_type,
       lo_http_client   TYPE REF TO if_web_http_client,
       lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
       lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
       lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.
     DATA(top)     = io_request->get_paging( )->get_page_size( ).
     DATA(skip)    = io_request->get_paging( )->get_offset( ).
     DATA(requested_fields)  = io_request->get_requested_elements( ).
     DATA(sort_order)    = io_request->get_sort_elements( ).
     TRY.
         " Create http client
         DATA(lv_http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sapes5.sapdevcenter.com/' ).
         lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lv_http_destination ).
         lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
           EXPORTING
              is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                  proxy_model_id      = 'ZMT_SID_AGENCY'
                                                  proxy_model_version = '0001' )
             io_http_client             = lo_http_client
             iv_relative_service_root   = '/sap/opu/odata/sap/ZAGENCYCDS_SRV' ).
         ASSERT lo_http_client IS BOUND.
         " Navigate to the resource and create a request for the read operation
         lo_request = lo_client_proxy->create_resource_for_entity_set( 'Z_TRAVEL_AGENCY_ES_5' )->create_request_for_read( ).
         IF io_request->is_data_requested( ) = abap_true.
           lo_request->set_skip( CONV i( skip ) ).
           IF top > 0 .
             lo_request->set_top( CONV i( top ) ).
           ENDIF.
         ENDIF.
         IF io_request->is_total_numb_of_rec_requested(  ) = abap_true.
           lo_request->request_count(  ).
         ENDIF.
         lo_request->set_top( 50 )->set_skip( 0 ).
         " Execute the request and retrieve the business data
         lo_response = lo_request->execute( ).
         lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
         IF io_request->is_total_numb_of_rec_requested(  ).
           io_response->set_total_number_of_records(  lo_response->get_count(  ) ).
         ENDIF.
         IF io_request->is_data_requested(  ).
           io_response->set_data( lt_business_data ).
         ENDIF.
       CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
         " Handle remote Exception
         " It contains details about the problems of your http(s) connection
       CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
         " Handle Exception
       CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
         " Handle Exception
         RAISE SHORTDUMP lx_web_http_client_error.
     ENDTRY.
   ENDMETHOD.
 ENDCLASS.

