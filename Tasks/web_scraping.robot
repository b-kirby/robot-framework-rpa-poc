***Settings***
Resource        ../Keywords/Poc.robot

Suite Teardown      Close Browser

***Variables***
${TECH_FILE}        Data/Technologies.xlsx
${URL}              https://github.com/search?utf8=✓&q=&type=

***Tasks***
Get Repo Count For Tech
    [Tags]              web-scraping
    @{TECH_LIST}        Get Technology List from Excel      ${TECH_FILE}
    @{REPO_COUNT}       Get Repository Counts For Each Technology      ${URL}      @{TECH_LIST}    
    Write To Excel      @{REPO_COUNT}
