CLASS zsid_aoc_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_amdp_marker_hdb .
    CLASS-METHODS add_numbers
      IMPORTING
        VALUE(x)   TYPE i
        VALUE(y)   TYPE i
      EXPORTING
        VALUE(res) TYPE i.
    CLASS-METHODS get_customer_by_id IMPORTING
                                       VALUE(i_bp_id) TYPE zsid_aoc_dte_id
                                     EXPORTING
                                       VALUE(e_res)   TYPE char40.
    CLASS-METHODS get_product_mrp IMPORTING
                                    VALUE(i_tax) TYPE i
                                  EXPORTING
                                    VALUE(otab)  TYPE zsid_aoc_tt_product_mrp.
    CLASS-METHODS get_total_sales for table FUNCTION Zsid_aoc_TF.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zsid_aoc_amdp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    zsid_aoc_amdp=>get_product_mrp(
         EXPORTING
           i_tax = 12
         IMPORTING
           otab  = DATA(itab)
       ).

    out->write(
      EXPORTING
        data   = itab
*        name   =
*      RECEIVING
*        output =
    ).

  ENDMETHOD.

  METHOD add_numbers BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    res := :x + :y;
  ENDMETHOD.

  METHOD get_customer_by_id BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
 OPTIONS READ-ONLY USING zsid_aoc_bpa.
    select company_name into e_res from zsid_aoc_bpa where bp_id = :i_bp_id;

  ENDMETHOD.

  METHOD get_product_mrp BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                           OPTIONS READ-ONLY
                           USING zsid_aoc_product.
*   declare variables
    declare lv_Count integer;
    declare i integer;
    declare lv_mrp bigint;
    declare lv_price_d integer;
*   get all the products in a implicit table (like a internal table in abap)
    lt_prod = select * from zsid_aoc_product;
*   get the record count of the table records
    lv_count := record_count( :lt_prod );
*   loop at each record one by one and calculate the price after discount (dbtable)
    for i in 1..:lv_count do
*   calculate the MRP based on input tax
        lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i] ) / 100;
        lv_mrp := :lv_price_d * ( 100 + :i_tax ) / 100;
*   if the MRP is more than 15k, an additional 10% discount to be applied
        if lv_mrp > 15000 then
            lv_mrp := :lv_mrp * 0.90;
        END IF ;
*   fill the otab for result (like in abap we fill another internal table with data)
        :otab.insert( (
                          :lt_prod.name[i],
                          :lt_prod.category[i],
                          :lt_prod.price[i],
                          :lt_prod.currency[i],
                          :lt_prod.discount[i],
                          :lv_price_d,
                          :lv_mrp
                      ), i );
    END FOR ;

  ENDMETHOD.

  METHOD get_total_sales by DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                       OPTIONS READ-ONLY
                       USING zsid_aoc_bpa zsid_aoc_sd_hdr zsid_aoc_so_item
 .
   return select
           bpa.client,
           bpa.company_name,
           sum( item.amount ) as total_sales,
           item.currency as currency_code,
           RANK ( ) OVER ( order by sum( item.amount ) desc ) as customer_rank
    from zsid_aoc_bpa as bpa
   INNER join zsid_aoc_sd_hdr as sls
   on bpa.bp_id = sls.buyer
   inner join zsid_aoc_so_item as item
   on sls.order_id = item.order_id
   group by bpa.client,
           bpa.company_name,
           item.currency ;

  ENDMETHOD.

ENDCLASS.
