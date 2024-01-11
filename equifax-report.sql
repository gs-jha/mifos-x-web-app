SELECT c.display_name AS `Client Name`, DATE_FORMAT(c.date_of_birth, '%d%m%Y') AS `Date of Birth`,
if(gendervalue.code_value='male', '2', if(gendervalue.code_value='female', '1', if(gendervalue.code_value='others', '3', NULL))) AS `Gender`,
 panvalult.identifier AS `Income Tax ID Number`,
 passportvalult.identifier AS `Passport Number`,
 '' AS `Passport Issue Date`,
 '' AS `Passport Expiry Date`,
 votevalult.identifier AS `Voter ID Number`,
 driverrvalult.identifier AS `Driving License Number`,
 '' AS `Driving License Issue Date`,
 '' AS `Driving License Expiry Date`,
 rationvalult.identifier AS `Ration Card Number`,
 '' AS `Universal ID Number`,
 '' AS `Additional ID 1`,
 '' AS `Additional ID 2`,
 c.mobile_no AS `Telephone No.Mobile`,
 '' AS `Telephone No.Residence`,
 '' AS `Telephone No.Office`,
 '' AS `Extension Office`,
 '' AS `Telephone No.Other`,
 '' AS `Extension Other`,
 c.email_address AS `Email ID 1`,
 '' AS `Email ID 2`, CONCAT(IFNULL(currmaddr.street, ''), IFNULL(currmaddr.address_line_1, ''), IFNULL(currmaddr.address_line_2, ''), IFNULL(currmaddr.address_line_3, '')) AS `Address 1`,
 currequistcode.equifax_state_code AS `State Code 1`,
 currpinmaster.pincode AS `PIN Code 1`,
 '2' AS `Address Category 1`,
 '' AS `Residence Code 1`, CONCAT(IFNULL(permmaddr.street, ''), IFNULL(permmaddr.address_line_1, ''), IFNULL(permmaddr.address_line_2, ''), IFNULL(permmaddr.address_line_3, '')) AS `Address2`,
 permequistcode.equifax_state_code AS `State Code 2`,
 permpinmaster.pincode AS `PIN Code 2`,
 '1' AS `Address Category 2`,
 '' AS `Residence Code 2`,
 (
SELECT value
FROM `hab_app_configuration_properties`
WHERE key_for_the_value = 'Equifax New Member Code') AS `Current/New Member Code`,
 (
SELECT value
FROM `hab_app_configuration_properties`
WHERE key_for_the_value = 'Equifax New Member Short Name') AS `Current/New Member Short Name`,
 ml.account_no AS `Curr/New Account No`, IFNULL(if(acctype.code_value='Auto Loan', '01', if(acctype.code_value='Housing Loan', '02', if(acctype.code_value='Property Loan', '03', if(acctype.code_value='Loan against Shares/Securities', '04', if(acctype.code_value='Personal Loan', '05', if(acctype.code_value='Consumer Loan', '06', if(acctype.code_value='Gold Loan', '07', if(acctype.code_value='Education Loan', '08', if(acctype.code_value='Loan to Professional', '09', if(acctype.code_value='Credit Card', '10', if(acctype.code_value='Lease', '11', if(acctype.code_value='Overdraft', '12', if(acctype.code_value='Two-wheeler Loan', '13', if(acctype.code_value='Non-Funded Credit Facility', '14', if(acctype.code_value='Loan Against Bank Deposits', '15', if(acctype.code_value='Fleet Card', '16', if(acctype.code_value='Commercial Vehicle Loan', '17', if(acctype.code_value='Telco – Wireless (For Future Use)', '18', if(acctype.code_value='Telco – Broadband (For Future Use)', '19', if(acctype.code_value='Telco – Landline (For Future Use)', '20', if(acctype.code_value='Secured Credit Card', '31', if(acctype.code_value='Used Car Loan', '32', if(acctype.code_value='Construction Equipment Loan', '33', if(acctype.code_value='Tractor Loan', '34', if(acctype.code_value='Corporate Credit Card', '35', if(acctype.code_value='Kisan Credit Card', '36', if(acctype.code_value='Loan on Credit Card', '37', if(acctype.code_value='Prime Minister Jaan Dhan Yojana – Overdraft', '38', if(acctype.code_value='Mudra Loans – Shishu / Kishor / Tarun', '39', if(acctype.code_value='MicroFinance – Business Loan', '40', if(acctype.code_value='MicroFinance – Personal Loan', '41', if(acctype.code_value='MicroFinance – Housing Loan', '42', if(acctype.code_value='MicroFinance – Others', '43', if(acctype.code_value='Pradhan Mantri Awas Yojana – Credit Link Subsidy Scheme MAY CLSS', '44', if(acctype.code_value='Business Loan – Secured', '50', if(acctype.code_value='Business Loan – General', '51', if(acctype.code_value='Business Loan – Priority Sector – Small Business', '52', if(acctype.code_value='Business Loan – Priority Sector – Agriculture', '53', if(acctype.code_value='Business Loan – Priority Sector – Others', '54', if(acctype.code_value='Business Non-Funded Credit Facility – General', '55', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Small Business', '56', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Agriculture', '57', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Others', '58', if(acctype.code_value='Business Loan Against Bank Deposits', '59', if(acctype.code_value='Business Loan – Unsecured', '61', if(acctype.code_value='Other', '00', NULL)))))))))))))))))))))))))))))))))))))))))))))),'05') AS `Account Type`,
 '' AS `Ownership Indicator`, DATE_FORMAT(ml.disbursedon_date, '%d%m%Y') AS `Date Opened/Disbursed`,
 lt.transaction_date AS `Date of Last Payment`, DATE_FORMAT(ml.closedon_date, '%d%m%Y') AS `Date Closed`, DATE_FORMAT(CURDATE(), '%d%m%Y') AS `Date Reported`,
 ml.approved_principal AS `High Credit/Sanctioned Amt`,
 ml.total_expected_repayment_derived- IFNULL(lt.amount,0) - IFNULL(lt.feeAtDisbursement,0) AS `Current  Balance`,
 IF(IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0) >0, IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0),0) AS `Amt Overdue`,
 IF(IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0) >0, IFNULL(DATEDIFF('${asOnDate}',mlr.duedate),0),0) AS `No of Days Past Due`,
 '' AS `Old Mbr Code`,
 '' AS `Old Mbr Short Name`,
 '' AS `Old Acc No`,
 '' AS `Old Acc Type`,
 '' AS `Old Ownership Indicator`,
 '' AS `Suit Filed / Wilful Default`,
 '' AS `Written-off and Settled Status`,
 '' AS `Asset Classification`,
 '' AS `Value of Collateral`,
 '' AS `Type of Collateral`,
 '' AS `Credit Limit`,
 '' AS `Cash Limit`,
 ml.nominal_interest_rate_per_period AS `Rate of Interest`,
 ml.number_of_repayments AS `RepaymentTenure`,
(
SELECT IFNULL(principal_amount,0)+ IFNULL(interest_amount,0)
FROM m_loan_repayment_schedule
WHERE loan_id = ml.id AND installment=1) AS `EMI Amount`,
 lt.writeOffAmt AS `Written- off Amount (Total)`,
 lt.writeOffPrincipal AS `Written- off Principal Amount`,
 '' AS `Settlement Amt`,
 if(ml.term_period_frequency_enum = 0, '1', if(ml.term_period_frequency_enum = 1, '2', if(ml.term_period_frequency_enum = 2, '3', if(ml.term_period_frequency_enum =3, '4', NULL)))) AS `Payment Frequency`,
 '' AS `Actual Payment Amt`,
 if(occudetail.code_value='Salary', '01', if(occudetail.code_value='Self Employed Professional', '02', if(occudetail.code_value='Self Employ', '03', if(occudetail.code_value='Others', '04', NULL)))) AS `Occupation Code`,
 '' AS `Income`,
 '' AS `Net/Gross Income Indicator`,
 '' AS `Monthly/Annual Income Indicator`
FROM `m_loan` ml
INNER JOIN `m_client` c ON c.id= ml.client_id
INNER JOIN m_office o ON o.id= c.office_id
LEFT JOIN m_code_value gendervalue ON gendervalue.id=c.gender_cv_id
LEFT JOIN m_client_identifier mci ON mci.client_id=c.id AND mci.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Pan' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault panvalult ON panvalult.document_key = mci.document_key
LEFT JOIN m_client_identifier mcip ON mcip.client_id=c.id AND mcip.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Passport' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault passportvalult ON passportvalult.document_key = mcip.document_key
LEFT JOIN m_client_identifier mciv ON mciv.client_id=c.id AND mciv.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='VoterID' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault votevalult ON votevalult.document_key = mciv.document_key
LEFT JOIN m_client_identifier mcia ON mcia.client_id=c.id AND mcia.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Drivers License' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault driverrvalult ON driverrvalult.document_key = mcia.document_key
LEFT JOIN m_client_identifier mcir ON mcir.client_id=c.id AND mcir.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='RationId' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault rationvalult ON rationvalult.document_key = mcir.document_key
LEFT JOIN m_client_address curraddr ON curraddr.client_id=c.id AND curraddr.address_type_id=(
SELECT id
FROM m_code_value
WHERE code_value = 'Current') AND curraddr.is_active =1
LEFT JOIN m_address currmaddr ON currmaddr.id = curraddr.address_id
LEFT JOIN hab_state_master currstmaster ON currstmaster.id = currmaddr.state
LEFT JOIN hab_equifax_state_code currequistcode ON currequistcode.state_id = currstmaster.id
LEFT JOIN hab_pincode_master currpinmaster ON currpinmaster.id = currmaddr.pincode
LEFT JOIN m_client_address permaddr ON permaddr.client_id=c.id AND permaddr.address_type_id=(
SELECT id
FROM m_code_value
WHERE code_value = 'Permanent') AND permaddr.is_active =1
LEFT JOIN m_address permmaddr ON permmaddr.id = permaddr.address_id
LEFT JOIN hab_state_master permstmaster ON permstmaster.id = permmaddr.state
LEFT JOIN hab_equifax_state_code permequistcode ON permequistcode.state_id = permstmaster.id
LEFT JOIN hab_pincode_master permpinmaster ON permpinmaster.id = permmaddr.pincode
LEFT JOIN (
SELECT loan_id, MIN(CASE WHEN ((obligations_met_on_date > '${asOnDate}') OR (obligations_met_on_date IS NULL)) THEN duedate END) AS duedate, SUM(IFNULL(principal_amount,0)+ IFNULL(interest_amount,0)+ IFNULL(fee_charges_amount,0)+ IFNULL(penalty_charges_amount,0)) AS Dueamount
FROM m_loan_repayment_schedule
WHERE duedate <= '${asOnDate}'
GROUP BY loan_id) mlr ON mlr.loan_id=ml.id
LEFT JOIN (
SELECT loan_id, MAX(CASE transaction_type_enum WHEN 2 THEN transaction_date END) AS transaction_date, 
SUM(CASE transaction_type_enum WHEN 5 THEN amount ELSE 0 END) AS feeAtDisbursement,
SUM(CASE transaction_type_enum WHEN 6 THEN amount ELSE 0 END) AS writeOffAmt,
SUM(CASE transaction_type_enum WHEN 6 THEN principal_portion_derived ELSE 0 END) AS writeOffPrincipal,
SUM(CASE WHEN transaction_type_enum NOT IN(5) THEN amount ELSE 0 END) AS amount
FROM m_loan_transaction
WHERE transaction_type_enum in(2,4,5,6,9) AND is_reversed=0 AND transaction_date <= '${asOnDate}'
GROUP BY loan_id)lt ON lt.loan_id=ml.id
LEFT JOIN r_enum_value re1 ON re1.enum_id=ml.repayment_period_frequency_enum AND re1.enum_name='repayment_period_frequency_enum'
LEFT JOIN `equifax additional details` ead ON ead.client_id=c.id
LEFT JOIN m_code_value occudetail ON occudetail.id=ead.Occupation_cd_occupation
LEFT JOIN m_code_value acctype ON acctype.id=ml.account_type
WHERE ml.loan_status_id NOT in(100,200,400,500) AND ml.disbursedon_date<='${asOnDate}' AND ((IFNULL(ml.closedon_date, '${asOnDate}') BETWEEN '${closedLoanFrom}' AND '${asOnDate}') OR (if(ml.closedon_date > '${asOnDate}', '${asOnDate}', ml.closedon_date) BETWEEN '${closedLoanFrom}' AND '${asOnDate}'))
  
  UNION

SELECT c.display_name AS `Client Name`, DATE_FORMAT(c.date_of_birth, '%d%m%Y') AS `Date of Birth`,
if(gendervalue.code_value='male', '2', if(gendervalue.code_value='female', '1', if(gendervalue.code_value='others', '3', NULL))) AS `Gender`,
 panvalult.identifier AS `Income Tax ID Number`,
 passportvalult.identifier AS `Passport Number`,
 '' AS `Passport Issue Date`,
 '' AS `Passport Expiry Date`,
 votevalult.identifier AS `Voter ID Number`,
 driverrvalult.identifier AS `Driving License Number`,
 '' AS `Driving License Issue Date`,
 '' AS `Driving License Expiry Date`,
 rationvalult.identifier AS `Ration Card Number`,
 '' AS `Universal ID Number`,
 '' AS `Additional ID 1`,
 '' AS `Additional ID 2`,
 c.mobile_no AS `Telephone No.Mobile`,
 '' AS `Telephone No.Residence`,
 '' AS `Telephone No.Office`,
 '' AS `Extension Office`,
 '' AS `Telephone No.Other`,
 '' AS `Extension Other`,
 c.email_address AS `Email ID 1`,
 '' AS `Email ID 2`, CONCAT(IFNULL(currmaddr.street, ''), IFNULL(currmaddr.address_line_1, ''), IFNULL(currmaddr.address_line_2, ''), IFNULL(currmaddr.address_line_3, '')) AS `Address 1`,
 currequistcode.equifax_state_code AS `State Code 1`,
 currpinmaster.pincode AS `PIN Code 1`,
 '2' AS `Address Category 1`,
 '' AS `Residence Code 1`, CONCAT(IFNULL(permmaddr.street, ''), IFNULL(permmaddr.address_line_1, ''), IFNULL(permmaddr.address_line_2, ''), IFNULL(permmaddr.address_line_3, '')) AS `Address2`,
 permequistcode.equifax_state_code AS `State Code 2`,
 permpinmaster.pincode AS `PIN Code 2`,
 '1' AS `Address Category 2`,
 '' AS `Residence Code 2`,
 (
SELECT value
FROM `hab_app_configuration_properties`
WHERE key_for_the_value = 'Equifax New Member Code') AS `Current/New Member Code`,
 (
SELECT value
FROM `hab_app_configuration_properties`
WHERE key_for_the_value = 'Equifax New Member Short Name') AS `Current/New Member Short Name`,
 ml.account_no AS `Curr/New Account No`, IFNULL(if(acctype.code_value='Auto Loan', '01', if(acctype.code_value='Housing Loan', '02', if(acctype.code_value='Property Loan', '03', if(acctype.code_value='Loan against Shares/Securities', '04', if(acctype.code_value='Personal Loan', '05', if(acctype.code_value='Consumer Loan', '06', if(acctype.code_value='Gold Loan', '07', if(acctype.code_value='Education Loan', '08', if(acctype.code_value='Loan to Professional', '09', if(acctype.code_value='Credit Card', '10', if(acctype.code_value='Lease', '11', if(acctype.code_value='Overdraft', '12', if(acctype.code_value='Two-wheeler Loan', '13', if(acctype.code_value='Non-Funded Credit Facility', '14', if(acctype.code_value='Loan Against Bank Deposits', '15', if(acctype.code_value='Fleet Card', '16', if(acctype.code_value='Commercial Vehicle Loan', '17', if(acctype.code_value='Telco – Wireless (For Future Use)', '18', if(acctype.code_value='Telco – Broadband (For Future Use)', '19', if(acctype.code_value='Telco – Landline (For Future Use)', '20', if(acctype.code_value='Secured Credit Card', '31', if(acctype.code_value='Used Car Loan', '32', if(acctype.code_value='Construction Equipment Loan', '33', if(acctype.code_value='Tractor Loan', '34', if(acctype.code_value='Corporate Credit Card', '35', if(acctype.code_value='Kisan Credit Card', '36', if(acctype.code_value='Loan on Credit Card', '37', if(acctype.code_value='Prime Minister Jaan Dhan Yojana – Overdraft', '38', if(acctype.code_value='Mudra Loans – Shishu / Kishor / Tarun', '39', if(acctype.code_value='MicroFinance – Business Loan', '40', if(acctype.code_value='MicroFinance – Personal Loan', '41', if(acctype.code_value='MicroFinance – Housing Loan', '42', if(acctype.code_value='MicroFinance – Others', '43', if(acctype.code_value='Pradhan Mantri Awas Yojana – Credit Link Subsidy Scheme MAY CLSS', '44', if(acctype.code_value='Business Loan – Secured', '50', if(acctype.code_value='Business Loan – General', '51', if(acctype.code_value='Business Loan – Priority Sector – Small Business', '52', if(acctype.code_value='Business Loan – Priority Sector – Agriculture', '53', if(acctype.code_value='Business Loan – Priority Sector – Others', '54', if(acctype.code_value='Business Non-Funded Credit Facility – General', '55', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Small Business', '56', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Agriculture', '57', if(acctype.code_value='Business Non-Funded Credit Facility – Priority Sector – Others', '58', if(acctype.code_value='Business Loan Against Bank Deposits', '59', if(acctype.code_value='Business Loan – Unsecured', '61', if(acctype.code_value='Other', '00', NULL)))))))))))))))))))))))))))))))))))))))))))))),'05') AS `Account Type`,
 '' AS `Ownership Indicator`, DATE_FORMAT(ml.disbursedon_date, '%d%m%Y') AS `Date Opened/Disbursed`,
 lt.transaction_date AS `Date of Last Payment`, DATE_FORMAT(ml.closedon_date, '%d%m%Y') AS `Date Closed`, DATE_FORMAT(CURDATE(), '%d%m%Y') AS `Date Reported`,
 ml.approved_principal AS `High Credit/Sanctioned Amt`,
 ml.total_expected_repayment_derived- IFNULL(lt.amount,0) - IFNULL(lt.feeAtDisbursement,0) AS `Current  Balance`,
 IF(IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0) >0, IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0),0) AS `Amt Overdue`,
 IF(IFNULL(mlr.Dueamount,0)- IFNULL(lt.amount,0) >0, IFNULL(DATEDIFF('${asOnDate}',mlr.duedate),0),0) AS `No of Days Past Due`,
 '' AS `Old Mbr Code`,
 '' AS `Old Mbr Short Name`,
 '' AS `Old Acc No`,
 '' AS `Old Acc Type`,
 '' AS `Old Ownership Indicator`,
 '' AS `Suit Filed / Wilful Default`,
 '' AS `Written-off and Settled Status`,
 '' AS `Asset Classification`,
 '' AS `Value of Collateral`,
 '' AS `Type of Collateral`,
 '' AS `Credit Limit`,
 '' AS `Cash Limit`,
 ml.nominal_interest_rate_per_period AS `Rate of Interest`,
 ml.number_of_repayments AS `RepaymentTenure`,
(
SELECT IFNULL(principal_amount,0)+ IFNULL(interest_amount,0)
FROM m_loan_repayment_schedule
WHERE loan_id = ml.id AND installment=1) AS `EMI Amount`,
 lt.writeOffAmt AS `Written- off Amount (Total)`,
 lt.writeOffPrincipal AS `Written- off Principal Amount`,
 '' AS `Settlement Amt`,
 if(ml.term_period_frequency_enum = 0, '1', if(ml.term_period_frequency_enum = 1, '2', if(ml.term_period_frequency_enum = 2, '3', if(ml.term_period_frequency_enum =3, '4', NULL)))) AS `Payment Frequency`,
 '' AS `Actual Payment Amt`,
 if(occudetail.code_value='Salary', '01', if(occudetail.code_value='Self Employed Professional', '02', if(occudetail.code_value='Self Employ', '03', if(occudetail.code_value='Others', '04', NULL)))) AS `Occupation Code`,
 '' AS `Income`,
 '' AS `Net/Gross Income Indicator`,
 '' AS `Monthly/Annual Income Indicator`
FROM `m_loan` ml
INNER JOIN m_guarantor g ON ml.id=g.loan_id
INNER JOIN m_client c ON c.id= g.entity_id
INNER JOIN m_office o ON o.id= c.office_id
LEFT JOIN m_code_value gendervalue ON gendervalue.id=c.gender_cv_id
LEFT JOIN m_client_identifier mci ON mci.client_id=c.id AND mci.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Pan' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault panvalult ON panvalult.document_key = mci.document_key
LEFT JOIN m_client_identifier mcip ON mcip.client_id=c.id AND mcip.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Passport' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault passportvalult ON passportvalult.document_key = mcip.document_key
LEFT JOIN m_client_identifier mciv ON mciv.client_id=c.id AND mciv.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='VoterID' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault votevalult ON votevalult.document_key = mciv.document_key
LEFT JOIN m_client_identifier mcia ON mcia.client_id=c.id AND mcia.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='Drivers License' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault driverrvalult ON driverrvalult.document_key = mcia.document_key
LEFT JOIN m_client_identifier mcir ON mcir.client_id=c.id AND mcir.document_type_id = (
SELECT pcv.id
FROM m_code_value pcv
WHERE pcv.code_value='RationId' AND pcv.is_active=1 AND pcv.code_id=1)
LEFT JOIN hab_identifier_data_vault rationvalult ON rationvalult.document_key = mcir.document_key
LEFT JOIN m_client_address curraddr ON curraddr.client_id=c.id AND curraddr.address_type_id=(
SELECT id
FROM m_code_value
WHERE code_value = 'Current') AND curraddr.is_active =1
LEFT JOIN m_address currmaddr ON currmaddr.id = curraddr.address_id
LEFT JOIN hab_state_master currstmaster ON currstmaster.id = currmaddr.state
LEFT JOIN hab_equifax_state_code currequistcode ON currequistcode.state_id = currstmaster.id
LEFT JOIN hab_pincode_master currpinmaster ON currpinmaster.id = currmaddr.pincode
LEFT JOIN m_client_address permaddr ON permaddr.client_id=c.id AND permaddr.address_type_id=(
SELECT id
FROM m_code_value
WHERE code_value = 'Permanent') AND permaddr.is_active =1
LEFT JOIN m_address permmaddr ON permmaddr.id = permaddr.address_id
LEFT JOIN hab_state_master permstmaster ON permstmaster.id = permmaddr.state
LEFT JOIN hab_equifax_state_code permequistcode ON permequistcode.state_id = permstmaster.id
LEFT JOIN hab_pincode_master permpinmaster ON permpinmaster.id = permmaddr.pincode
LEFT JOIN (
SELECT loan_id, MIN(CASE WHEN ((obligations_met_on_date > '${asOnDate}') OR (obligations_met_on_date IS NULL)) THEN duedate END) AS duedate, SUM(IFNULL(principal_amount,0)+ IFNULL(interest_amount,0)+ IFNULL(fee_charges_amount,0)+ IFNULL(penalty_charges_amount,0)) AS Dueamount
FROM m_loan_repayment_schedule
WHERE duedate <= '${asOnDate}'
GROUP BY loan_id) mlr ON mlr.loan_id=ml.id
LEFT JOIN (
SELECT loan_id, MAX(CASE transaction_type_enum WHEN 2 THEN transaction_date END) AS transaction_date, 
SUM(CASE transaction_type_enum WHEN 5 THEN amount ELSE 0 END) AS feeAtDisbursement,
SUM(CASE transaction_type_enum WHEN 6 THEN amount ELSE 0 END) AS writeOffAmt,
SUM(CASE transaction_type_enum WHEN 6 THEN principal_portion_derived ELSE 0 END) AS writeOffPrincipal,
SUM(CASE WHEN transaction_type_enum NOT IN(5) THEN amount ELSE 0 END) AS amount
FROM m_loan_transaction
WHERE transaction_type_enum in(2,4,5,6,9) AND is_reversed=0 AND transaction_date <= '${asOnDate}'
GROUP BY loan_id)lt ON lt.loan_id=ml.id
LEFT JOIN r_enum_value re1 ON re1.enum_id=ml.repayment_period_frequency_enum AND re1.enum_name='repayment_period_frequency_enum'
LEFT JOIN `equifax additional details` ead ON ead.client_id=c.id
LEFT JOIN m_code_value occudetail ON occudetail.id=ead.Occupation_cd_occupation
LEFT JOIN m_code_value acctype ON acctype.id=ml.account_type
WHERE ml.loan_status_id NOT in(100,200,400,500) AND ml.disbursedon_date<='${asOnDate}' AND ((IFNULL(ml.closedon_date, '${asOnDate}') BETWEEN '${closedLoanFrom}' AND '${asOnDate}') OR (if(ml.closedon_date > '${asOnDate}', '${asOnDate}', ml.closedon_date) BETWEEN '${closedLoanFrom}' AND '${asOnDate}')) 
