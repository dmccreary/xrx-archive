xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Petshop XRX Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a sample XRX application that is an on-line pet shop.  It was
      writting to show the simplicity of the XRX web application architecture
      when compared with traditional four translation web/object/relational systems.</p>
      
      <a href="http://java.sun.com/blueprints/guidelines/designing_enterprise_applications_2e/app-arch/app-arch3.html">Example from Designing Enterprise Applications with the J2EE Platform, Second Edition</a>
      
      <h4>Main Menu</h4>
      <h3>Customer Use Cases</h3>
      <a href="views/browse.xq">Browe Catalog</a>
      <a href="views/account.xq">Manage Account</a>
      <a href="views/order.xq">Place Order</a>
      
      <h3>Administrator Use Cases</h3>
      <a href="views/financial.xq">Manage Financial Data</a>
      <a href="views/approve.xq">Approve Purchase Order</a>
      
     <h3>Warehouse Worker</h3>
      <a href="views/pack-and-ship.xq">Pack and Ship an Order</a>

      
</div>

return 
    style:assemble-page($title, $content)
