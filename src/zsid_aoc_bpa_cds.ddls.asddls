@AbapCatalog.sqlViewName: 'ZSIDAOCBPA'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Partner'
@Metadata.ignorePropagatedAnnotations: true
define view ZSID_AOC_BPA_CDS as select from zsid_aoc_bpa
{
    key bp_id as BpId,
    bp_role as BpRole,
    company_name as CompanyName,
    street as Street,
    country as Country,
    region as Region,
    city as City
}
