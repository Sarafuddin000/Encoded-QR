  DECLARE
  
  --Change the parameters as yours--
  
  com_name VARCHAR2(100) := :P4_COM_NAME;
  vat_no VARCHAR2(100) := :P4_VAT_NO;
  inv_date VARCHAR2(100) := to_Char(sysdate, 'YYYY-MM-DD HH24:MI:SS');
  inv_total VARCHAR2(100) := :P4_INV_TOTAL;
  vat VARCHAR2(100) := :P4_VAT;
  
  v_tag1 VARCHAR2(1000) := TO_CHAR(1, 'fm0X');
  v_tag2 VARCHAR2(1000) :=  TO_CHAR(2, 'fm0X');
  v_tag3 VARCHAR2(1000) :=  TO_CHAR(3, 'fm0X');
  v_tag4 VARCHAR2(1000) :=  TO_CHAR(4, 'fm0X');
  v_tag5 VARCHAR2(1000) :=  TO_CHAR(5, 'fm0X');
 
  v_tag1_len VARCHAR2(1000) := TO_CHAR(LENGTH(COM_NAME), 'fm0X');
  v_tag2_len VARCHAR2(1000) := TO_CHAR(LENGTH(vat_no), 'fm0X');
  v_tag3_len VARCHAR2(1000) := TO_CHAR(LENGTH(inv_date), 'fm0X');
  v_tag4_len VARCHAR2(1000) := TO_CHAR(LENGTH(inv_total), 'fm0X');
  v_tag5_len VARCHAR2(1000) := TO_CHAR(LENGTH(vat), 'fm0X'); 
  
  hex_com_name VARCHAR2(100) := RAWTOHEX( UTL_RAW.cast_to_raw(com_name));
  hex_vat_no VARCHAR2(100) := RAWTOHEX( UTL_RAW.cast_to_raw(vat_no));
  hex_inv_date VARCHAR2(100) := RAWTOHEX( UTL_RAW.cast_to_raw(inv_date));
  hex_inv_total VARCHAR2(100) := RAWTOHEX( UTL_RAW.cast_to_raw(inv_total));
  hex_vat VARCHAR2(100) := RAWTOHEX( UTL_RAW.cast_to_raw(vat));
 
  v_hex VARCHAR(1000);
  v_str VARCHAR(1000);
  v_enc varchar(1000);
  BEGIN
 v_hex :=  v_tag1 || v_tag1_len || com_name || 
            v_tag2 || v_tag2_len || vat_no || 
            v_tag3 || v_tag3_len || inv_date||
            v_tag4 || v_tag4_len || inv_total||
            v_tag5 || v_tag5_len || vat;
            
 v_str :=  v_tag1 || v_tag1_len || hex_com_name ||
            v_tag2 || v_tag2_len || hex_vat_no ||
            v_tag3 || v_tag3_len || hex_inv_date||
            v_tag4 || v_tag4_len || hex_inv_total||
            v_tag5 || v_tag5_len || hex_vat;
            
        v_enc := utl_raw.cast_to_varchar2(UTL_ENCODE.BASE64_ENCODE(v_STR));

---- for example
htp.p('<b><img src=
"https://barcode.tec-it.com/barcode.ashx?data='||v_enc||'&code=ZATCAQRCode&eclevel=M" </pre></b>');
---- for example
--htp.p('<b><img src="https://barcode.tec-it.com/barcode.ashx?data='||com_name||'&code=ZATCAQRCode&eclevel=M" </pre></b>');
end;
