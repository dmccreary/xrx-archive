<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <id>1</id>
    <filename>test-1.sch</filename>
    <title>Ruleset Title Test</title>
    <ns uri="http://www.example.com"/>
    <pattern name="Pattern Name 1">
        <rule context="Contract">
            <assert subject="ContractDate in Past" test="ContractDate &lt; current-date()">
            The contract data must be in the past.
         </assert>
        </rule>
        <rule context="context2">
            <assert test="Pattern 1 Assert Test  1">                          
            This is the error message to display if the assertion is false.
         </assert>
        </rule>
    </pattern>
    <pattern name="Pattern Name 2">
        <rule context="Pattern 2 rule 1 context 1">
            <assert test="String">
            This is the error message to display if the assertion is  false.
         </assert>
        </rule>
        <rule context="Pattern 2 rule 2 context 1">
            <assert test="String">
            This is the error message to display if the assertion is  false.
         </assert>
        </rule>
    </pattern>
</sch:schema>