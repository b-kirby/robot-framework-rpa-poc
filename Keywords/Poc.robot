***Settings***
Library    ExcelLibrary
Library    Collections
Library    SeleniumLibrary
Library    OperatingSystem

***Keywords***
Get all Rows From Excel
    [Arguments]     ${file}
    @{rows}     Create List
    Open Excel Document     ${file}     doc1
    @{count}=        Read Excel Column     col_num=1
    ${row_count}=   Get Length      ${count}  
    FOR     ${index}    IN RANGE    ${row_count-1}
        @{row}=     Read Excel Row      row_num=${index+2}
        Append To List      ${rows}     ${row}
    END
    Close Current Excel Document
    Return From Keyword     @{rows}

Get Technology List from Excel
    [Arguments]     ${file}
    Open Excel Document     ${file}     doc1  
    Set Global Variable    ${filename}      ${file}   
    @{technologies}=     Read Excel Column      col_num=1
    Remove From List        ${technologies}     0
    Return From Keyword      @{technologies}   

Get Repository Counts For Each Technology
    [Arguments]     ${url}    @{tech_list}
    @{rep_num_list}     Create List
    Open Browser    ${url}    Chrome
    FOR     ${tech}     IN      @{tech_list}
        Input Text      name:q      ${tech}
        Press Keys      None       RETURN
        ${rep_num}=     Get Text        //div[contains(@class, 'codesearch-results')]//h3[not(@class)]
        Append To List  ${rep_num_list}     ${rep_num}
        Sleep   3
    END
    Return From Keyword     ${rep_num_list}

Write To Excel
    [Arguments]     @{repo_counts}
    ${length}   Get length      ${repo_counts}
    FOR     ${index}    IN RANGE   ${length}
        Write Excel Cell    row_num=${index+2}      col_num=2   value=${repo_counts}[${index}]
    END
    Save Excel Document     ${filename}
    Close Current Excel Document

Write Rows To Excel
    [Arguments]     @{rows}      ${file}
    ${length}   Get length      ${rows}
    Open Excel Document     ${file}     doc1
    FOR     ${index}    IN RANGE   ${length}
        Write Excel Row    row_num=${index+1}   row_data=@{rows}[${index}]
    END
    Save Excel Document     ${file}
    Close Current Excel Document

Check Row Matches Condition
    [Arguments]     ${rows}
    @{valid_rows}       Create List
    FOR     ${item}     IN  @{rows}  
        Run Keyword If      '@{item}[6]'=='USA' and @{item}[7]>20000000 and '@{item}[9]'=='IBM' or '@{item}[9]'=='Apple'     Append To List     ${valid_rows}   ${item} 
    END
    Return From Keyword     ${valid_rows}