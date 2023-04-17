<html>
<h1>QR Code in Base64 encoding for KSA E-Invoicing</h1>
<h2>Generate Base64 encoded QR in Oracle Apex 22.2 and or Oracle Reports 11g</h2>


<h3># For more details about the documentation please follow <a href="https://people.sap.com/firoz.ashraf2"  target="_blank" >(S M Firoz Ashraf)</a> the author's <a href="https://blogs.sap.com/2021/11/18/qr-code-in-base64-encoding-for-ksa-e-invoicing/">article</a></h3>

 <p>As per Zakat, Tax and Customs Authority (ZATCA) of Saudi Arabia, one of the main requirements is the implementation of QR codes on tax invoices in the e-invoicing project (Fatoora), which will be mandatory starting December 4, 2021</p>
<p>As per the <a href="https://zatca.gov.sa/ar/E-Invoicing/SystemsDevelopers/Documents/20210528_ZATCA_Electronic_Invoice_Security_Features_Implementation_Standards_vShared.pdf"  target="_blank" >ZATCA instructions</a>(Page No. 23), the minimum requirements that must be shown after scanning a QR code are the following fields, which should be represented in form of <strong>based64 encoding</strong>:</p>
<ol type="1">
<li>Seller’s name.</li>
<li>VAT registration number of the seller.</li>
<li>Time stamp of the invoice (date and time).</li>
<li>Invoice total (with VAT).</li>
<li>VAT total.</li>
</ol>
<p>In this blog,  I will show how to encode the QR data in base64 format using Oracle Apex 22.2 and Oracle Reports 11g with Oracle Database 19c to print QR code on Invoice layouts.</p>
<p><span style="text-decoration: underline"><strong>1st Step</strong></span> is to prepare each of the five values in TLV (<strong>T</strong>ag-<strong>L</strong>ength-<strong>V</strong>alue) structure</p>
<p><strong>Tag</strong> is fixed (1 for Seller&#8217;s name, 2 for VAT No&#8230;&#8230;5 for VAT Total)</p>
<p><strong>Length</strong> is the size of the value field in bytes (it’s not the count of characters but how many bytes the value represents)</p>
<p><strong>Value</strong> is the data against each of the five fields.</p>
<p>Let&#8217;s take an example to clarify TLV</p>
<ul>
<li style="list-style-type: none">
<ol>
<li><strong>Seller name</strong>; for example, “<strong>Firoz Ashraf</strong>”
<ul>
<li>Tag      = 1 (1 as a type represents the seller name)</li>
<li>Length = 12 (The number of the bytes in “Firoz Ashraf” word)</li>
<li>Value   = Firoz Ashraf</li>
</ul>
</li>
<li><strong>VAT Number</strong>; for example, <strong>1234567891</strong>
<ul>
<li>Tag      = 2 (2 as a type represents the VAT number)</li>
<li>Length = 10</li>
<li>Value   = 1234567891</li>
</ul>
</li>
<li><strong>Time Stamp</strong>; for example, <strong>2021-11-17 08:30:00</strong>
<ul>
<li>Tag      = 3 (3 as a type represents invoice time stamp)</li>
<li>Length = 19</li>
<li>Value   = 2021-11-17 08:30:00</li>
</ul>
</li>
<li><strong>Invoice Total</strong>; for example, <strong>100.00</strong>
<ul>
<li>Tag      = 4 (4 as a type represents the invoice amount)</li>
<li>Length = 6</li>
<li>Value   = 100.00</li>
</ul>
</li>
<li><strong>VAT Total</strong>; for example, <strong>15.00</strong>
<ul>
<li>Tag      = 5 (5 as a type represents the tax amount)</li>
<li>Length = 5</li>
<li>Value   = 15.00</li>
</ul>
</li>
</ol>
</li>
</ul>
<p>&nbsp;</p>
<p><span style="text-decoration: underline"><strong>2nd Step</strong></span></p>
<p>For each tag first convert it to hexa, then concatenate the hexa value into one string. Use this single string to convert to base64.</p>
<p>For example,</p>
<p>Tag1: convert 1, 12 (length of 'Firoz Ashraf') &amp; 'Firoz Ashraf' itself to hexa. Store this in variable tlv1</p>
<p>(01 for 1, 0C for 12, 4669726F7A20417368726166 for Firoz Ashraf)</p>
<p>So the <strong>hexa</strong> value in <strong>tlv1</strong> will be <strong>010C4669726F7A20417368726166</strong></p>
<p>&nbsp;</p>
<p>Tag2: convert 2, 10 (length of '1234567891') &amp; '1234567891' itself to hexa. Store this in variable tlv2</p>
<p>(02 for 2, 0A for 10, 31323334353637383931 for 1234567891)</p>
<p>So the <strong>hexa</strong> value in <strong>tlv2</strong> will be <strong>020A31323334353637383931 </strong></p>
<p>&nbsp;</p>
<p>Do this for remaining tags. Then concatenate tlv1 tlv2 tlv3 tlv4 tlv5 into a single variable say <!--StartFragment -->qrcode_xstring</p>

<p><span style="text-decoration: underline"><strong>3rd Step</strong></span></p>
<p>As per above example the value in variable qrcode_xstring will be</p>
<p>010C4669726F7A20417368726166020A313233343536373839310313323032312D31312D31372030383A33303A303004063131352E3030050531352E3030</p>
<p>Now convert this to base64, which will become(for the value above)</p>
<p>AQxGaXJveiBBc2hyYWYCCjEyMzQ1Njc4OTEDEzIwMjEtMTEtMTcgMDg6MzA6MDAEBjExNS4wMAUFMTUuMDA=</p>
<p>I tested it here on this site and it works fine https://tomeko.net/online_tools/hex_to_base64.php
</p>
<p>Now let&#8217;s see how we can do this in Oracle PL/SQL</p>
 </html>
