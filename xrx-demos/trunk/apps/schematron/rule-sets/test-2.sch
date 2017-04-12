<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:filename>test-2.sch</sch:filename>
    <sch:title>Test 2</sch:title>
    <sch:ns uri="http://www.example.com"/>
    <sch:pattern name="Pattern Name 1">
        <sch:rule context="context1">
            <sch:assert subject="ContractDate in Past" test="ContractDate &lt; current-date()">
            The contract data must be in the past.
         </sch:assert>
        </sch:rule>
        <sch:rule context="context2">
            <sch:assert test="Pattern 1 Assert Test  1">                          
            This is the error message to display if the assertion is false.
         </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Pattern Name 2">
        <sch:rule context="Pattern 2 rule 1 context 1">
            <sch:assert test="String">
            This is the error message to display if the assertion is  false.
         </sch:assert>
        </sch:rule>
        <sch:rule context="Pattern 2 rule 2 context 1">
            <sch:assert test="String">
            This is the new and exciting error message to display if the assertion is  false.
         </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>