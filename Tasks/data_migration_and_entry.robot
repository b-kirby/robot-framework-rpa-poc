***Settings***
Resource        ../Keywords/Poc.robot

***Variables***
${COMPANIES_DATA_FILE}        Data/Companies Dataset.xlsx
${OUTPUT_DATA_FILE}           Data/Output Dataset.xlsx


***Tasks***
Get Repo Count For Tech
    @{ALL_ROWS}=        Get All Rows From Excel        ${COMPANIES_DATA_FILE}
    @{VALID_ROWS}=      Check Row Matches Condition     ${ALL_ROWS}
    Write Rows to Excel      @{VALID_ROWS}       file=${OUTPUT_DATA_FILE}
